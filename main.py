from flask import Flask, render_template, request ,session
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from werkzeug.utils import secure_filename
import json
import os
import math

from werkzeug.utils import redirect

with open ("config.json","r") as c:
    params = json.load(c)['params']
app = Flask(__name__)
app.secret_key = 'python'
app.config['Upload_Folder'] = params['Upload_Location']
local_server = True

if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["prod_uri"]

db = SQLAlchemy(app)

def __repr__(self):
        return '<User %r>' % self.username

class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(20), nullable=False)
    email = db.Column(db.String(20), nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    msg = db.Column(db.String(120), nullable=False)

class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(20), nullable=False)
    slug = db.Column(db.String(25), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(12), nullable=False)
    subheading = db.Column(db.String(50), nullable=False)

@app.route("/")
def home():
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts)/3)
    page = request.args.get('page')
    if(not str(page).isnumeric()):
        page = 1
    page = int(page)
    start = (page-1)*3
    end = (page-1)*3 + 3
    posts = posts[start:end]
    if page==1:
        prev = '#'
        next = "/?page=" + str(page+1)
    elif page==last:
        next = '#'
        prev = "/?page=" + str(page-1)
    else:
        next = "/?page=" + str(page+1)
        prev = "/?page=" + str(page-1)

    return render_template("index.html",params = params, posts = posts, prev = prev, next = next)

@app.route("/post/<string:post_slug>", methods = ['GET'])
def post(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()

    return render_template("post.html",params = params, post = post)

@app.route("/about")
def about():
    return render_template("about.html",params = params)

@app.route("/contact",methods = ['POST', 'GET'])
def contact():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        phone_num= request.form['phone']
        msg = request.form['msg']

        entry = Contacts(name = name, phone_num = phone_num, msg = msg, email = email, date = datetime.now())

        db.session.add(entry)
        db.session.commit()

    return render_template("contact.html",params = params)

@app.route("/admin",methods=['GET','POST'])
def admin():
    if ('user' in session and session['user'] == params['admin_username']):
        posts = Posts.query.all()
        return render_template("admin.html",params = params,posts=posts)
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        if (username == params['admin_username'] and password == params['admin_password']):
            session['user'] = username
            posts = Posts.query.all()
            return render_template("admin.html",params = params,posts=posts)
    
    return render_template("login.html",params = params)

@app.route("/edit/<string:sno>",methods = ['GET','POST'])
def edit(sno):
    if ('user' in session and session['user'] == params['admin_username']):
        if request.method == 'POST':
            title = request.form['title']
            subheading = request.form['subheading']
            slug = request.form['slug']
            content = request.form['content']
            img_file = request.form['img']
            
            if sno == '0':
                new_post = Posts(title = title , subheading = subheading , slug = slug , content = content , img_file = img_file, date = datetime.now())
                db.session.add(new_post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(sno = sno).first()
                post.title = title
                post.slug = slug
                post.subheading = subheading
                post.content = content
                post.img_file = img_file
                post.date = datetime.now()
                db.session.add(post)
                db.session.commit()
            return redirect("/admin")
        post = Posts.query.filter_by(sno = sno).first()
        return render_template("edit.html",params = params,post = post)
    return render_template("login.html",params = params)

@app.route("/delete/<string:sno>")
def delete(sno):
    if ('user' in session and session['user'] == params['admin_username']):
        post = Posts.query.filter_by(sno = sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect("/admin")

@app.route("/upload",methods = ['POST', 'GET'])
def upload():
    if ('user' in session and session['user'] == params['admin_username']):
        if request.method == 'POST':
            f = request.files['file1']
            f.save(os.path.join(app.config['Upload_Folder'] , secure_filename(f.filename)))
            return redirect("/admin")
    return render_template("login.html",params = params) 

@app.route("/logout")
def logout():
    session.pop('user')
    return render_template("login.html",params = params)

if __name__ == "__main__":
    app.run(debug=True)
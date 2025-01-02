from flask import Flask
from flask_bcrypt import Bcrypt
from flask_pymongo import PyMongo

bcrypt = Bcrypt()
db = PyMongo()

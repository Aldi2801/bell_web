from pymongo import MongoClient
from .config import MONGO_URI, DATABASE_NAME

client = MongoClient(MONGO_URI)
db = client[DATABASE_NAME]

def insert_transaction(transaction_data):
    return db.transactions.insert_one(transaction_data)

def get_transaction_by_id(transaction_id):
    return db.transactions.find_one({"transaction_id": transaction_id})

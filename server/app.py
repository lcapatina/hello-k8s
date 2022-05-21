from flask import Flask, jsonify, request
from flask_cors import CORS
import psycopg2
import os

DEBUG = True

app = Flask(__name__)

# enable CORS
CORS(app, resources={r'/*': {'origins': '*'}})

BASE_PATH = '/api'

# BOOKS = [
#     {
#         'id': 0,
#         'title': 'On the Road',
#         'author': 'Jack Kerouac',
#         'read': True
#     },
#     {
#         'id': 1,
#         'title': 'Harry Potter and the Philosopher\'s Stone',
#         'author': 'J. K. Rowling',
#         'read': False
#     },
#     {
#         'id': 2,
#         'title': 'Green Eggs and Hamm',
#         'author': 'Dr. Seuss',
#         'read': True
#     }
# ]

host = os.environ.get("POSTGRES_SERVICE_SERVICE_HOST")
database = "admin"
user = os.environ.get("PG_USER")
password = os.environ.get("PG_PASSWORD")
conn = psycopg2.connect(host=host, database=database, user=user, password=password)

@app.route(BASE_PATH + '/books', methods=['GET'])
def all_books():
    cursor = conn.cursor()
    select_query = "select * from books"
    cursor.execute(select_query)
    books = cursor.fetchall()
    result = [{"id": book[0], "title": book[1], "author": book[2], "read": book[3]} for book in books]
    cursor.close()
    return jsonify({'status': 'success', 'books': result})

@app.route(BASE_PATH + '/book', methods=['POST'])
def add_book():
    data = request.get_json()
    # last_id = BOOKS[len(BOOKS)-1]['id']
    # data['id'] = last_id + 1
    # BOOKS.append(data)
    cursor = conn.cursor()
    insert_query = """ INSERT INTO books (title, author, read) VALUES (%s,%s,%s)"""
    values = (data["title"], data["author"], data["read"])
    cursor.execute(insert_query, values)
    conn.commit()
    cursor.close()
    return jsonify({'status': 'success', 'message': "Book added!"});

# sanity check route
@app.route(BASE_PATH + '/ping', methods=['GET'])
def ping_pong():
    return jsonify('pong!')


if __name__ == '__main__':
    app.run(host='0.0.0.0')

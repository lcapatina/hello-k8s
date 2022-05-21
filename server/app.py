from flask import Flask, jsonify, request
from flask_cors import CORS

DEBUG = True

app = Flask(__name__)

# enable CORS
CORS(app, resources={r'/*': {'origins': '*'}})


BOOKS = [
    {
        'id': 0,
        'title': 'On the Road',
        'author': 'Jack Kerouac',
        'read': True
    },
    {
        'id': 1,
        'title': 'Harry Potter and the Philosopher\'s Stone',
        'author': 'J. K. Rowling',
        'read': False
    },
    {
        'id': 2,
        'title': 'Green Eggs and Hamm',
        'author': 'Dr. Seuss',
        'read': True
    }
]

@app.route('/books', methods=['GET'])
def all_books():
    return jsonify({'status': 'success', 'books': BOOKS})

@app.route('/book', methods=['POST'])
def add_book():
    data = request.get_json()
    last_id = BOOKS[len(BOOKS)-1]['id']
    data['id'] = last_id + 1
    BOOKS.append(data)
    return jsonify({'status': 'success', 'message': "Book added!"});

# sanity check route
@app.route('/ping', methods=['GET'])
def ping_pong():
    return jsonify('pong!')


if __name__ == '__main__':
    app.run(host='0.0.0.0')

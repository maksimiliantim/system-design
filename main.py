from flask import Flask, request, jsonify
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
import uuid
import logging

logging.basicConfig(level=logging.DEBUG)

app = Flask(__name__)

app.config['JWT_SECRET_KEY'] = 'super-secret'
jwt = JWTManager(app)

users = {
    "admin": {"id": str(uuid.uuid4()), "username": "admin", "password": "secret"}
}
budget_items = {}

@app.route('/register', methods=['POST'])
def register():
    username = request.json.get('username')
    password = request.json.get('password')

    if username in users:
        return jsonify({"message": "Пользователь уже существует"}), 400

    user_id = str(uuid.uuid4())
    users[username] = {"id": user_id, "username": username, "password": password}
    return jsonify({"id": user_id, "username": username}), 201

@app.route('/login', methods=['POST'])
def login():
    username = request.json.get('username')
    password = request.json.get('password')

    user = users.get(username)

    if not user or user['password'] != password:
        return jsonify({"message": "Неверные учетные данные"}), 401

    access_token = create_access_token(identity=username)
    return jsonify(access_token=access_token)

@app.route('/user', methods=['GET'])
@jwt_required()
def get_user():
    current_user = get_jwt_identity()
    user = users.get(current_user)
    return jsonify({"id": user["id"], "username": user["username"]}), 200

@app.route('/budget', methods=['POST'])
@jwt_required()
def create_budget_item():
    user = get_jwt_identity()
    item_id = str(uuid.uuid4())
    item = {
        "id": item_id,
        "user": user,
        "description": request.json.get('description'),
        "amount": request.json.get('amount')
    }
    budget_items[item_id] = item
    return jsonify(item), 201

@app.route('/budget', methods=['GET'])
@jwt_required()
def get_budget_items():
    user = get_jwt_identity()
    user_items = [item for item in budget_items.values() if item['user'] == user]
    return jsonify(user_items), 200

@app.route('/budget/<item_id>', methods=['PUT'])
@jwt_required()
def edit_budget_item(item_id):
    user = get_jwt_identity()
    item = budget_items.get(item_id)

    if not item or item['user'] != user:
        return jsonify({"message": "Запись не найдена или не принадлежит пользователю"}), 404

    item['description'] = request.json.get('description', item['description'])
    item['amount'] = request.json.get('amount', item['amount'])
    return jsonify(item), 200

@app.route('/budget/<item_id>', methods=['DELETE'])
@jwt_required()
def delete_budget_item(item_id):
    user = get_jwt_identity()
    item = budget_items.pop(item_id, None)

    if not item or item['user'] != user:
        return jsonify({"message": "Запись не найдена или не принадлежит пользователю"}), 404

    return jsonify({"message": "Запись успешно удалена"}), 200

if __name__ == "__main__":
    app.run(port=8080, debug=True)

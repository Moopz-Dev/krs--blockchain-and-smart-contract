import datetime
import json
import hashlib
from flask import Flask, jsonify
from numpy import block
from sqlalchemy import true


class Blockchain:
    # initializing the chain
    def __init__(self):
        self.chain = []
        self.transaction = 0
        # genesis block generation
        self.create_block(nonce=1, previous_hash="0")

    # creating the block
    def create_block(self, nonce, previous_hash):
        block = {
            "index": len(self.chain)+1,
            "timeStamp": str(datetime.datetime.now()),
            'nonce': nonce,
            'data': self.transaction,
            'previous_hash': previous_hash
        }
        self.chain.append(block)
        return block

    # get the data of the latest block
    def get_previous_block(self):
        return self.chain[-1]

    # hashing block
    def hash(self, block):
        # converting dictionary to json object
        encode_block = json.dumps(block, sort_keys=True).encode()
        # sha-256
        return hashlib.sha256(encode_block).hexdigest()

    # Proof of Work
    def proof_of_work(self, previous_nonce):
        # mining for nonce that yield hash of 4 digits
        new_nonce = 1
        check_proof = False
        # solving math problem for the nonce
        while check_proof == False:
            hashoperation = hashlib.sha256(
                str(new_nonce**2 - previous_nonce**2).encode()).hexdigest()
            if hashoperation[:4] == "0000":
                check_proof = True
            else:
                new_nonce += 1
        return new_nonce

    # validating block "n"
    def is_chain_valid(self, chain):
        previous_block = chain[0]
        block_index = 1
        while block_index < len(chain):
            block = chain[block_index]
            if block["previous_hash"] != self.hash(previous_block):
                return False
            previous_nonce = previous_block["nonce"]  # nonce of block "n-1"
            nonce = block["nonce"]  # nonce of block "n"
            hashoperation = hashlib.sha256(
                str(nonce**2 - previous_nonce**2).encode()).hexdigest()
            if hashoperation[:4] != "0000":
                return False
            previous_block = block
            block_index += 1
        return True


# initializing the webapp server
app = Flask(__name__)

blockchain = Blockchain()

# routing


@app.route('/')
def hello():
    return "<p>hello</p>"


@app.route('/get_chain', methods=["GET"])
def get_chain():
    response = {
        "chain": blockchain.chain, "length": len(blockchain.chain)
    }
    return jsonify(response), 200


@app.route('/mining', methods=["GET"])
def mining_block():
    amount = 1000000
    blockchain.transaction = blockchain.transaction+amount
    # proof of work
    previous_block = blockchain.get_previous_block()
    previous_nonce = previous_block["nonce"]
    # nonce
    nonce = blockchain.proof_of_work(previous_nonce)
    # previous block hash
    previous_hash = blockchain.hash(previous_block)
    # updating new block
    block = blockchain.create_block(nonce, previous_hash)
    response = {
        "message": "Block mined successfully",
        "index": block["index"],
        "timestamp": block["timeStamp"],
        "data": block["data"],
        "nonce": block["nonce"],
        "previous_hash": block["previous_hash"]
    }
    return jsonify(response), 200


@app.route('/is_valid', methods=["GET"])
def is_valid():
    is_valid = blockchain.is_chain_valid(blockchain.chain)
    if is_valid:
        response = {"message": "Blockchain valid"}
    else:
        response = {"message": "Blockchain is invalid"}
    return jsonify(response), 200


if __name__ == "__main__":
    app.run()

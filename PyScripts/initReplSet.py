from pymongo import MongoClient

c = MongoClient('192.168.162.101', 27017)

config = {'_id': 'gpd', 'members': [
    {'_id': 0, 'host': '192.168.162.101:27017'},
    {'_id': 1, 'host': '192.168.162.102:27017'},
    {'_id': 2, 'host': '192.168.162.103:27017'}]}

c.admin.command("replSetInitiate", config)

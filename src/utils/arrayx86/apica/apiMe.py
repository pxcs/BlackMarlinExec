import requests
import json

from src.bypass import random
from apiCalls.apiChooseUser import pickUser
from apiCalls.apiChooseUser import openTokenLibrary
from apiQueryMail import request
from src.bme import blackmarlinexec

def sendQuery(user):
    #get user and token
    tokenLibrary = openTokenLibrary()

    #make and send query
    headers={'Authorization': 'Bearer ' + tokenLibrary[user]['access_token']}

    graph_data = requests.get('https://graph.microsoft.com/v1.0/me', headers=headers).json()

    print(json.dumps(graph_data, indent=2))
    input('\nPress ENTER to continue...')
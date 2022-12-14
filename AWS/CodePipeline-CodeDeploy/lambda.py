import json
import uuid

GET_RAW_PATH = "/getlambda"
POST_RAW_PATH = "/postlambda"

def lambda_handler(event, context):
    print(event)
    if event['rawPath'] == GET_RAW_PATH:
        print('Start request for getlambda')
        personId = event['queryStringParameters']['personId']
        print("Received request with personId=" + personId)
        return { "firstName": "Ruslan" + personId, "lastName": "Serdiuk", "email": "Ruslan.serdiuk.w@gmail.com" }
    elif event['rawPath'] == POST_RAW_PATH:
        print('Start request for postlambda')
        decodedEvent = json.loads(event['body'])
        firstName = decodedEvent['firstName']
        print('Received request with firstName=' + firstName)
        return { "personId": str(uuid.uuid1())}
import json
import uuid

GET_RAW_PATH = "/getPerson"
CREATE_RAW_PATH = "/createPerson"

def lambda_handler(event, context):
    print(event)
    if event['rawPath'] == GET_RAW_PATH:
        print('Received getPerson request')
        personId = event['queryStringParameters']['personId']
        print("with param personId=" + personId)
        return { "firstName": "Ruslan " + personId, "lastName": "Serdiuk", "email": "Ruslan.serdiuk.w@gmail.com" }
    elif event['rawPath'] == CREATE_RAW_PATH:
        print('Received createPerson request')
        decodedBody = json.loads(event['body'])
        firstname = decodedBody['firstname']
        print('with param firstname=' + firstname)
        return { "personId": str(uuid.uuid1())}
# testRestAPI

This project started because I need a way to start a request automatically instead of doing it manually. 

It is using a REST API that support the POST method and is receiving a SOAP envelope with parameters being replaced by values depenging which request we want. 

The request payload is a json file that is mocked data. This data will be used by the Email Service to create an email using that data. 
The end point variants are managed using a file called external.keys
A file called sites.locales is use to maintain the different combinations supported by the REST API for languages and countries. 

It could send as many emails as needed. 

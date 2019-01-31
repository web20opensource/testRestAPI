# testRestAPI

This project started because I need a way to start a request automatically instead of doing it manually. The amount of request started to grow as the project grows as well. So every time I need more and more requests. So I have created a bash script for this purpose. 

It is using a REST API that support the POST method.
Also I have used it with a SOAP envelope with parameters being replaced by values depenging on which request we want to send and where to send. 

So the external.keys manages the different endpoints, four our case we are using only numbers but endpoints could be alphanumeric as well.   

The request payload is a json file that is just mocked data. This data will be used by the Email Service to create an email using that data. 

The end point variants are managed using a file called external.keys

A file called sites.locales is use to maintain the different combinations supported by the REST API for languages and countries. 

It could send as many requests as needed. 

Basically it creates curl request to the endpoint with the needed arguments or values to sequentially sent multiple requests. 

This is like a test tool for a REST API based on the premise that an automated way is needed to send automatically the requests

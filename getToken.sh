#!/bin/bash

#title           :getToken.sh
#description     :This script will get a token to interact with the MC's REST API
#dependencies	 :use the correct api keys, or update the endpoint to use a different REST API
#author			 :Mario Ruiz <web2.0opensource@gmail.com>
#date            :09/18/2017
#License		 :Apache License, Version 2.0
#version         :1.0.0    
#usage			 :./getToken.sh {dev,qa,ext,prod}
#notes           : please, don't upload the api keys to the repo. Developers should get them from somewhere else. 
#bash_version    :4.4.12(1)-release
#==============================================================================

declare -a Envs=(dev qa ext prod)

#echo ${Envs[0]}
#echo ${Envs[1]}
#exit

if [ "${1,,}" = "${Envs[0]}" ] || [ "${1,,}" = "${Envs[1]}" ] || ([ "${1,,}" = "${Envs[2]}" ] || [ "${1,,}" = "${Envs[3]}" ])
then
 declare env=${1,,}
else
 echo "provide any environment as: ${Envs[@]}"
 exit
fi

if [ "$env" = "prod" ] 
then
 declare clientId=clientId
 declare clientSecret=clientSecret
else
 declare clientId=clientId
 declare clientSecret=clientSecret
fi

curl -F "clientId=$clientId" \
     -F "clientSecret=$clientSecret" \
     https://auth.exacttargetapis.com/v1/requestToken | cut -d',' -f 1 | cut -d':' -f 2 | tr -d \" 

exit

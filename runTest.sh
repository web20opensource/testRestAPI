#!/bin/bash

#title           :runTest.sh
#description     :This script will send emails as needed (defined in the required files).
#dependencies	 :getToken.sh, external.keys, sites.locales, .json files (from 15 to 375)
#author			 :Mario Ruiz <web2.0opensource@gmail.com>
#date            :09/18/2017
#version         :0.9    
#usage			 :./runTest.sh {dev,qa,ext,prod}
#notes           :need to have prior access to MC. Update the files user.txt and pass.txt with your credentials.
#bash_version    :4.4.12(1)-release
#==============================================================================

declare -a contexts=(dev qa ext prod)

# the next associative array is used to sum/add to reach the required external key
declare -A indexEnvs
indexEnvs=([dev]=0 [qa]=1 [ext]=2 [prod]=3 )

if [ "${1,,}" = "${contexts[0]}" ]  || [ "${1,,}" = "${contexts[1]}" ] || ([ "${1,,}" = "${contexts[2]}" ]  ||  [ "${1,,}" = "${contexts[3]}" ]);
 then
  context=${1,,}
  Environment=${1^^}
  externalKeyAdd=${indexEnvs[$context]}
else
 echo "provide any environment as: ${contexts[@]}"
 exit
fi

sitesLocales=$(head -1 sites.locales)
declare -a sourceSites=(${sitesLocales})

declare -a Events

Events[35]=Account_Locked

externalKeys=$(head -1 external.keys)
declare -a devKeys=(${externalKeys})

email=$(head -1  email)

#get the auth token to do future REST API requests
token=$(./getToken.sh $context)
echo "we got the token"

for i in "${devKeys[@]}"
do
 :
 # $i contains the external key
 event=${Events[$i]}

declare -a useThisSourceSites=(${sourceSites[@]})

 for sourceSite in "${useThisSourceSites[@]}"
 do
  :
  #do for each sourceSite
  #set $sourceSite without colon and create an array to store values
  OIFS=$IFS;IFS=,;
  sourceSiteArray=($sourceSite)
  #echo $1
  country=${sourceSiteArray[0]}
  lang=${sourceSiteArray[1]}
  partner=${sourceSiteArray[2]}
  IFS=$OIFS  # Restore IFS.
 
 	externalKeyAdd=${indexEnvs[$context]}
 	extKey=$(($i+$externalKeyAdd))

  # transform the json in a single line and replace variables.
  # Replace also single quotes by double quotes to avoid breaking the curl command


  jsonData=$(sed -e "s/\${email}/$email/" -e "s/\${country}/$country/" -e "s/\${env}/$Environment/" -e "s/\${lang}/$lang/" -e "s/\${partner}/$partner/" -e "s/\${event}/$event/" $i.json | tr "\n" " " | tr "'" "\"")

  #echo $extKey
  curl --data "${jsonData}" -H "Content-Type: application/json" -H "Authorization: Bearer $token" https://www.exacttargetapis.com/messaging/v1/messageDefinitionSends/key:$extKey/send --verbose

 done
done

exit

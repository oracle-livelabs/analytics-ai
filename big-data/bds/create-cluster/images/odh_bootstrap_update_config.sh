#!/bin/bash

#change below variables for your cluster
AMBARI_USER=admin
AMBARI_PWD=Aaaqqq1\@\$LsRFV
CONFIG_FILE_TO_UPDATE=""

#Used when for restarting components after config update
#Wait time before we poll for restart status. Default 30 seconds. Meaning, We poll for restart status every 30 seconds
WAIT_TIME_IN_SEC=30

#No of tries before we give up on the restart status. Default 20. With default WAIT_TIME_IN_SEC as 30, At max we wait for 10(20*30=600 seconds) minutes before we give up.
RETRY_COUNT=20

#INTERNAL USE ONLY
propObj=""


#Method to collect the current config
function get_property_json(){
    allConfs=$(curl -v -u $AMBARI_USER:$AMBARI_PWD -k -X GET https://$utilityNodeIp:7183/api/v1/clusters/$getClusterName?fields=Clusters/desired_configs) #to get all the configs
    currVersionLoc=".Clusters.desired_configs.\"$CONFIG_FILE_TO_UPDATE\".tag"  #fetching current version for property
    propVersion=$(echo $allConfs | jq $currVersionLoc | tr -d '"')
    propJson=$(curl -u $AMBARI_USER:$AMBARI_PWD -H "X-Requested-By: ambari" -k -X GET "https://$utilityNodeIp:7183/api/v1/clusters/$getClusterName/configurations?type=$CONFIG_FILE_TO_UPDATE&tag=$propVersion") #fetch property json
    propLoc=".items[].properties"
    propKeyVal=$(echo $propJson | jq $propLoc)
    propObj="{\"properties\":$propKeyVal}"
    echo $propObj
}

#Method to add/update key value pair to existing config
function add_properties(){
    propObj=$(echo $propObj | jq '.properties += { "'$1'": "'$2'" }')
}

#Method to update config in ambari
function update_ambari_config(){
    parseableAddedProp=$(echo $propObj | jq '.properties')
    timestamp=$(date +%s)
    newVersion="version$timestamp"
    
    finalJson='[{"Clusters":{"desired_config":[{"type":"'$CONFIG_FILE_TO_UPDATE'","tag":"'$newVersion'","properties":'$parseableAddedProp'}]}}]'
    curl -u $AMBARI_USER:$AMBARI_PWD -H "X-Requested-By: ambari" -k -X PUT -d "$finalJson" "https://$utilityNodeIp:7183/api/v1/clusters/$getClusterName"
}

#Method to restart required components
function restart_required_components(){
    echo "restarting all required components"
    response_body=$(curl -u $AMBARI_USER:$AMBARI_PWD -H "X-Requested-By: ambari" -k -X POST -d '{"RequestInfo":{"command":"RESTART","context":"Restart all required services from bootstrap script","operation_level":"host_component"},"Requests/resource_filters":[{"hosts_predicate":"HostRoles/stale_configs=true&HostRoles/cluster_name='$getClusterName'"}]}' "https://$utilityNodeIp:7183/api/v1/clusters/$getClusterName/requests")
    
    echo "printing response_body: $response_body"
    
    idLoc=".Requests.id"
    requestId=$(echo $response_body | jq $idLoc)
    echo "request id is : $requestId"
    
    current_count=0
    while [[ $current_count -lt $RETRY_COUNT ]];
    do
        current_count=$((current_count+1))
        response=$(curl -v -u $AMBARI_USER:$AMBARI_PWD -k -X GET https://$utilityNodeIp:7183/api/v1/clusters/$getClusterName/requests/$requestId)
        request_status=$(echo $response | jq -r ".Requests.request_status")
        echo "printing request_status: $request_status"
        if [[ $request_status == "IN_PROGRESS" ]] || [[ $request_status == "PENDING" ]]; then
            echo "current_count is : $current_count"
            sleep $WAIT_TIME_IN_SEC
        elif [[ $request_status == "COMPLETED" ]]; then
            echo "Restart successful"
            break
        fi
    done
}

for utilityNodeIp in $getUtilityNodesIps
do
    echo "Current utility node ip: $utilityNodeIp"
    str1=$(nslookup $utilityNodeIp | awk -v var=$utilityNodeIp  '/name =/{print var "\t", $4}')
    mkdir /tmp/test1
    if [[ $str1 == *"un0"* ]]; then
        echo "un0 node found. Proceeding with node specific operation..."

		#config update step starts here. For each file these steps need to be repeated. 
		#For updating multiple files at one shot, Copy the lines from <START> to <END> and update CONFIG_FILE_TO_UPDATE with required file followed by add_properties with required key value to update
		#<START>

        CONFIG_FILE_TO_UPDATE="yarn-site" #this is the file we're updating in this example
        propObj=$(get_property_json)
        echo "calling add properties YARN"

		#update key value pairs. Multiple key value pairs can be updated before doing update_ambari_config
		#add_properties "dfs.namenode.https-bind-host" "0.0.0.0"    #example of how to add properties
		#add_properties "fs.gs.path.encoding" "uri-path"    #example of how to add properties
        add_properties "yarn.scheduler.maximum-allocation-mb" "4096"
		add_properties "yarn.scheduler.maximum-allocation-vcores" "2"
        
        #Update it to ambari
        echo "updating ambari config for YARN"
        update_ambari_config
        
        #<END>
		#config update step ends here
		#<START>

        CONFIG_FILE_TO_UPDATE="hive-site" #this is the file we're updating in this example
        propObj=$(get_property_json)
        echo "calling add properties Hive"

		#update key value pairs. Multiple key value pairs can be updated before doing update_ambari_config
		#add_properties "dfs.namenode.https-bind-host" "0.0.0.0"    #example of how to add properties
		#add_properties "fs.gs.path.encoding" "uri-path"    #example of how to add properties
        add_properties "hive.server2.tez.sessions.per.default.queue" "8"
        
        #Update it to ambari
        echo "updating ambari config Hive"
        update_ambari_config
        
        #<END>
		

		#Following is to restart required components after config update. Comment the following if you want to skip restart
        echo "restarting all required components"
        restart_required_components
    fi
done
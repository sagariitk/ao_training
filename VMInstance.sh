#launching a VM instance named i-ao-sagar-test
#with an additional disk of 10GB size named sagar-test-disk
#storing the output in new.txt file to later get the IP address
gcloud compute instances create i-ao-sagar-test --machine-type n1-standard-1 --image-family=ubuntu-1604-lts \
--labels=name=sagar,project=dev,machineconfigure=cpu,purpose=training,team=pe-ao \
--create-disk=name=sagar-test-disk,size=10GB,auto-delete=no \
--service-account=athenas-owl-default@athenas-owl-dev.iam.gserviceaccount.com \
--metadata=email=sagar.yadav@quantiphi.com,office-time=24*7,estimate=2018-07-05 >new.txt


#getting the IP address of the new instance
ip=`cat new.txt`
set -- "$ip"
IFS="    "; declare -a Array=($*)
staticIp=${Array[10]}
echo $staticIp
echo "waiting for instance to be up...."
sleep 30s

#uploading the files to instance
#mongod.conf have the changed data storage path of mongodb server
scp -i ao-dev.pem mongod.conf aodev@$staticIp:
#test2.sh is the script to be run on vm instance
scp -i ao-dev.pem UploadFile.sh aodev@$staticIp:
#enronr.json is the file which should be uploaded to mongodb server
scp -i ao-dev.pem enron.json aodev@$staticIp:

#ssh into the vm instance and running the script there
ssh -i ao-dev.pem aodev@$staticIp ./UploadFile.sh


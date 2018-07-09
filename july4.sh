cd /

echo "inside the home directory"
echo "formatating the sdb disk"

sudo mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdb
echo "create a mount directory"

sudo mkdir -p /sdb-mount

echo "mount the 2nd disk"
sudo mount -o discard,defaults /dev/sdb /sdb-mount
echo "getting inside sdb-mount directory"
cd /sdb-mount
echo "creating a new directory for mongodb data"
sudo mkdir mongodb
echo "change permission for the disk"
sudo chown -R aodev:aodev /sdb-mount
chmod 777 .
cd mongodb
chmod 777 .
echo "get out to home directory"
cd /
echo "installing  mongodb"
sudo apt-get install dirmngr;
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927;
echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list;
sudo apt-get update
sudo apt-get install -y -y mongodb-org
echo "start mongodb"
sudo service mongod start
echo "check mongodb status"
service mongod status
cd ~
sudo service mongod stop
sudo service mangod status
sleep 30s
sudo cp mongod.conf /etc/

echo "restArt mongod service"
sudo service mongod start
sudo service mangod status
sleep 30s
sudo service mangod status
cd ~
echo $PWD
sleep 30s
mongo redirect --eval 'db.createCollection("assignment")'

echo "upload of enron.json file to assignment collection in mongodb"
mongoimport --db test --collection assignment --file enron.json

cd /sdb-mount/mongodb


#sleep 30s
#echo "snapshot taken from disk"
#gcloud compute disks snapshot sagar-test-disk --snapshot-names sagar-disk-snapshot

#echo "#unmount disk from instance"
#sudo umount /dev/sdb

#delete instance
#gcloud compute instances delete i-ao-sagar-test
#delete the disk
#gcloud compute disks delete sagar-test-disk

#create disk from snapshot
#gcloud compute disks create sagar-test-disk --source-snapshot sagar-disk-snapshot

#launching a VM instance named i-ao-sagar-test
#gcloud compute instances create i-ao-sagar-test --machine-type n1-standard-1 --image-family=ubuntu-1604-lts \
#--labels=name=sagar,project=dev,machineconfigure=cpu,purpose=training,team=pe-ao \
#--disk name=sagar-test-disk,boot=yes \
#--service-account=athenas-owl-default@athenas-owl-dev.iam.gserviceaccount.com \
#--metadata startup-script='sudo apt-get update;' >new.txt

#adding the metatags with the instance
#gcloud compute instances add-metadata i-ao-sagar-test --metadata=email=sagar.yadav@quantiphi.com,office-time=24*7,estimate$




#gcloud compute instances create i-ao-sagar-test --machine-type n1-standard-1 --image-family=ubuntu-1604-lts \
#--labels=name=sagar,project=dev,machineconfigure=cpu,purpose=training,team=pe-ao --disk name=sagar-test-disk,boot=yes

#adding metatags to the instance
#gcloud compute instances add-metadata i-ao-sagar-test --metadata=email=sagar.yadav@quantiphi.com,office-time=24*7,estimate=2018-07-05

#files will be in /sdb-mount/mongodb

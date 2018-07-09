cd /

#formatting of the attached second disk
sudo mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdb

#new directory to mount additional disk
sudo mkdir -p /sdb-mount

#mounting the second disk 
sudo mount -o discard,defaults /dev/sdb /sdb-mount
cd /sdb-mount
sudo mkdir mongodb

#changing the permission for the new mounted disk
sudo chown -R aodev:aodev /sdb-mount
chmod 777 .
cd mongodb
chmod 777 .
cd /

#installation of mongodb server
sudo apt-get install dirmngr;
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927;
echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list;
sudo apt-get update
sudo apt-get install -y -y mongodb-org

cd ~

#changing the path of data storage of mongodb server by replacing the existing mongod.conf file with new file
sudo cp mongod.conf /etc/

#mongo db service start
sudo service mongod start
cd ~
echo $PWD

#creating a new collection in test database
mongo redirect --eval 'db.createCollection("assignment")'

#uploading the enron.json file to collection
mongoimport --db test --collection assignment --file enron.json


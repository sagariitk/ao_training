
echo "snapshot taken from disk"
gcloud compute disks snapshot sagar-test-disk --snapshot-names sagar-disk-snapshot

echo "delete instance"
gcloud compute instances delete i-ao-sagar-test

echo "#delete the disk"
gcloud compute disks delete sagar-test-disk

echo "#create disk from snapshot"
gcloud compute disks create sagar-test-disk --source-snapshot sagar-disk-snapshot

#launching a VM instance named i-ao-sagar-test
gcloud compute instances create i-ao-sagar-test --machine-type n1-standard-1 --image-family=ubuntu-1604-lts \
--labels=name=sagar,project=dev,machineconfigure=cpu,purpose=training,team=pe-ao \
--service-account=athenas-owl-default@athenas-owl-dev.iam.gserviceaccount.com \
--metadata=email=sagar.yadav@quantiphi.com,office-time=24*7,estimate=2018-07-05

gcloud compute instances attach-disk i-ao-sagar-test --disk=sagar-test-disk

#files will be in /sdb-mount/mongodb


#creating three files
mkdir sagarTest
cd sagarTest 
touch 1-sagar.txt
touch 2-sagar.mp4
touch 3-sagar.xls

#uploading sagarTest folder to the target bucket
gsutil -m cp -r /home/sagar/gcp/sagarTest/ gs://b-ao-test-freshers


#renaming .mp4 file
gsutil mv gs://b-ao-test-freshers/sagarTest/2-sagar.mp4 gs://b-ao-test-freshers/sagarTest/2-sagarnew.mp4

#renaming .xls file
gsutil mv gs://b-ao-test-freshers/sagarTest/3-sagar.xls gs://b-ao-test-freshers/sagarTest/3-sagarnew.xls

#editing the .txt file data
echo 'new data written in the .txt file' | gsutil cp - gs://b-ao-test-freshers/sagarTest/1-sagar.txt

#downloading back the files folder
gsutil -m cp -r gs://b-ao-test-freshers/sagarTest /home/sagar/gcp


Building and destroying an S3 bucket with versionning
=====================================================

![](https://raw.githubusercontent.com/adlytaibi/ss/master/removeversiondbucket/removeversiondbucket.gif)

Whether you want to understand how to build and destroy a bucket with versionning or simply testing a few scenarios.
This is a simple bash script that will go through the following workflow:
- Create bucket
- Enable versionning on the newly created bucket
- Create N-test files and PUT
- Update every file and PUT to create a new version ID
- List and delete all files in the bucket
- List and delete all files versions
- List and delete all delete markers
- Delete the bucket
- Delete the N-test files
 
### WARNING: The script will **DELETE** the bucket at the end. Don't use an existing bucket unless you don't care for it.

Pre-requisites
--------------

* aws-cli
* jq 
* bash (>=v4)

Installation
------------

1. Make sure `aws-cli` is installed and configured to something like this:

   ```bash
   $ cat ~/.aws/config 
   [default]
   region = us-east-1
   output = json
   $ cat ~/.aws/credentials 
   [default]
   aws_access_key_id = ACCESS_KEY
   aws_secret_access_key = SECRET_KEY
   ```

2. Copy the script or clone this:

   ```bash
   git clone https://github.com/adlytaibi/removeversiondbucket
   cd removeversiondbucket
   chmod u+x removeversiondbucket
   ```

3. To suit your environment and need, change the variables `a` the endpoint to your load-balancer or storage node, `b` the bucket you want test with and `c` the number of files to upload and generate a second version for each. Save the script and execute.

   ```bash
   a='aws --endpoint-url https://webscaledemo.netapp.com'
   b=bucket
   c=3
   ```

Building and destroying an S3 bucket with versioning
====================================================

![](https://raw.githubusercontent.com/adlytaibi/ss/master/removeversiondbucket/removeversiondbucket.gif)

Whether you want to understand how to build and destroy a bucket with versioning or simply testing a few scenarios. A default number parallel operations is set by a `governor` variable.
This is a simple bash script that will go through the following workflow:
- Create bucket
- Check and enable versioning on the newly created or existing bucket
- Create C-times test files and PUT
- Delete the C-times test files
- Update every file and PUT to create a new version of each file D-times
- List and delete all files in the bucket
- List and delete all files versions
- List and delete all delete markers
- Delete the bucket
 
### WARNING: The script will **DELETE** the bucket at the end. Don't use an existing bucket unless you don't care for it.

Pre-requisites
--------------

* aws-cli
* bash (>=v3)
* jq 
* awk 
* ps 

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

3. To suit your environment and need, change the variables `a` the endpoint to your load-balancer or storage node, `b` the bucket you want test with and `c` the number of files to upload and generate a `d` times versions for each. Save the script and execute.

   ```bash
   a='aws --endpoint-url https://webscaledemo.netapp.com'
   b=bucket
   c=3
   d=2
   ```
   * Internally signed certs, you can do something like this:
   ```bash
   a='aws --endpoint-url https://s3.demo.netapp.com:8082 --ca chain.pem'
   ```

   * **_Note:_** the script will not work for self-signed certificates.

4. The switchboard is a section of variables that lets you turn on or off a phase of the workflow.

   ```bash
   # Switchboard options, set 1 to enable
   enableversioning=1
   enablefileuploads=1
   #
   prelistobjects=1
   deleteobjects=1
   postlistobjects=1
   #
   prelistversions=1
   deleteversions=1
   postlistversions=1
   #
   prelistdeletemarkers=1
   deletedeletemarkers=1
   postlistdeletemarkers=1
   #
   removebucket=1
   #
   ```

5. Other options like setting a `governor` value will limit the number of PUTs and DELETEs running in parallel. `showcounters` lets you hide the counters during the said parallel operations
   ```bash
   # Limit the number of parallel PUT and DELETE calls, set 0 for unlimited
   governor=20
   #
   # Display Counters, set 1 to display
   showcounters=1
   #
   ```

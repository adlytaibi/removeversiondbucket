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

3. Execute the script with `-h` or `--help` option to display the arguments documentation. When providing awscli options, do not add `aws` to the text.

   ```bash
   ./removeversiondbucket -a='--endpoint-url https://webscaledemo.netapp.com'
   ```
   * Internally signed certs, you can do something like this:
   ```bash
   ./removeversiondbucket -a='--endpoint-url https://s3.demo.netapp.com:8082 --ca chain.pem'
   ```

   * **_Note:_** the script will not work for self-signed certificates.

Usage
-----

   ```bash
   [1mUSAGE[0m
	   Building and destroying an S3 bucket with versioning
   
   [1mSYNOPSIS[0m
	   [1mremoveversiondbucket[0m [[1m-h[0m|[1m--help[0m]
	   [[[1m-a[0m|[1m--awscliopts[0m]=OPTIONS] [[[1m-b[0m|[1m--bucket[0m]=NAME] [[[1m-c[0m|[1m--numfiles[0m]=VALUE] [[[1m-d[0m|[1m--numvers[0m]=VALUE]
	   [[[1m-v[0m|[1m--donotenableversioning[0m] | [[1m+v[0m|[1m--enableversioning[0m]]
	   [[[1m-f[0m|[1m--disablefileuploads[0m] | [[1m+f[0m|[1m--enablefileuploads[0m]]
	   [[[1m-rb[0m|[1m--removebucket[0m] | [[1m-kb[0m|[1m--keepbucket[0m]]
	   [[[1m-g[0m|[1m--governor[0m]=VALUE] [[1m-s[0m|[1m--hidecounters[0m]
	   [[1m-r[0m|[1m--showonly[0m] [[1m-sr[0m|[1m--showrun[0m]
	   [[[1m-sb[0m|[1m--switchboard[0m]=VALUE]
   
   
   [1mDESCRIPTION[0m
	   [1m-a=[0mOPTIONS, [1m--awscliopts=[0m"OPTIONS"	([1mdefault:[0m "--endpoint-url https://s3.demo.netapp.com:8082 --ca chain.pem")
		   Refer to aws help pages. Do not add aws at the beginning of the options, it's already taken care of.
   
	   [1m-b=[0mNAME, [1m--bucket=[0mNAME	([1mdefault:[0m bucket)
		   Provide a bucket name for existing or to be created.
   
	   [1m-c=[0mVALUE, [1m--numfiles=[0mVALUE	([1mdefault:[0m 100)
		   Number of test files that will be generated and PUT into bucket.
   
	   [1m-d=[0mVALUE, [1m--numvers=[0mVALUE	([1mdefault:[0m 2) 
		   Number of versions per file.
   
	   [1m-v[0m, [1m--donotenableversioning[0m, [1m+v[0m, [1m--enableversioning[0m	[1m[0m	([1mdefault:[0m Enabled)
		   Enable or don't enable versioning on the bucket.
   
	   [1m-f[0m, [1m--disablefileuploads[0m, [1m+f[0m, [1m--enablefileuploads[0m	([1mdefault:[0m Enabled)
		   Create and update (PUT) files.
   
	   [1m-rb[0m, [1m--removebucket[0m, [1m-kb[0m, [1m--keepbucket[0m	([1mdefault:[0m Delete bucket)
		   Keep or delete the bucket. This delete command will fail if the bucket is not empty.
   
	   [1m-g[0m=VALUE, [1m--governor[0m=VALUE	([1mdefault:[0m 20)
		   Throttle the number of parallel PUT or DELETE operations. Set to 0 for unlimited.
		   Set this a value you're comfortable with depending how powerful your machine is.
   
	   [1m-s[0m, [1m--hidecounters[0m	([1mdefault:[0m Disabled)
		   Set this switch to hide counters from being printed. Counters are shown by default.
   
	   [1m-r[0m, [1m--showonly[0m
		   This option will only show the parameters and not execute the program.
		   This is a great way to check the parameters before launching what could be sometimes a long running operations.
   
	   [1m-sr[0m, [1m--showrun[0m
		   This option will show the parameters and execute the program.
   
	   [1m-sb[0m=VALUE, [1m--switchboard[0m=VALUE	([1mdefault:[0m 777)
		   In order to reduce the number of options to set for the following 9 parameters. We'll be using the octal numbers similar to *nix style file permissions.
		   There are three set of phases the program goes through [1mObject[0m, [1mFile versions[0m and [1mDelete markers[0m.
		   Each phase has three sets of parameters [1mpre-delete list[0m, [1mdelete operation[0m and [1mpost-delete list[0m.
		   The pre and post listing steps are only for printing and pretty much noise. The delete operation is what's important.
   
		   The 3 phases have been assigned a digit location in the [1mswitchboard[0m option.
		   The [1mleft[0m digit has been assigned to the [1mObject[0m phase.
		   The [1mmiddle[0m digit has been assigned to the [1mFile versions[0m phase.
		   The [1mright[0m digit has been assigned to the [1mDelete markers[0m phase.
   
		   Each phase's digit value is the addition of the following options' values.
		   The [1mpre-delete list[0m options have been assigned a value of [1m4[0m to enable and a [1m0[0m to disable.
		   The [1mdelete operation[0m options have been assigned a value of [1m2[0m to enable and a [1m0[0m to disable.
		   The [1mpost-delete list[0m options have been assigned a value of [1m1[0m to enable and a [1m0[0m to disable.
   
		   [4mFor example:[0m
			   1- Enabling all options for all phases would the addition of 4,2,1 which adds up to 7,7,7 put together would form a [1mswitchboard[0m option of [1m777[0m.
   
			   2- Enabling only pre-delete listing for all phases is a 4 for each phase and put together forms a [1mswitchboard[0m option of [1m444[0m.
   
			   3- Performing the delete operations and post-delete list for [1mFile versions[0m and [1mDelete markers[0m phases only,
			     the [1mObject[0m phase would score a [1m0[0m and the other two phases would score a [1m3[0m each, so the [1mswitchboard[0m option value would be [1m033[0m.
   
   [1mEXAMPLES[0m
	   The following command will show the parameters then executes:
   
	   $ removeversiondbucket [1m-sr[0m [1m-a=[0m"--endpoint-url https://s3.demo.netapp.com:8082 --ca chain.pem" [1m-b=[0mmybucket [1m-c=[0m5000 [1m-d=[0m5 [1m-kb [1m-g=[0m30 [1m-sb=[0m222 [1m-rb[0m
   
	   aws cli extra options (-a): [1maws --endpoint-url https://s3.demo.netapp.com:8082 --ca chain.pem[0m
	   Bucket name (-b): [1mmybucket[0m
	   Number of files to create (-c): [1m5000[0m
	   Number of versions per file to create (-d): [1m5[0m
	   Enable versioning (-v,+v): [1;32mEnabled[0m
	   Enable file uploads (-f,+f): [1;32mEnabled[0m
	   Delete bucket (-rb,-kb): [1;32mEnabled[0m
	   Throttle parallel (-g): [1m30[0m
	   Show counters (-s): [1;32mEnabled[0m
	   Execute after show (-sr): [1;32mEnabled[0m
	   Switchboard setting (-sb): [1m222[0m
	   ====================== Object phase ======================
	   Pre-Delete object list, objects: [1;31mDisabled[0m
	      DELETE all objects: [1;32mEnabled[0m
	   Post Delete object, list objects: [1;31mDisabled[0m
	   ================== File versions phase ==================
	   Pre-Delete file versions, list versions: [1;31mDisabled[0m
	      DELETE all files' versions: [1;32mEnabled[0m
	   Post Delete file versions, list versions:: [1;31mDisabled[0m
	   ================== Delete markers phase ==================
	   Pre-Delete delete markers, list delete markers: [1;31mDisabled[0m
	      DELETE all delete markers: [1;32mEnabled[0m
	   Post Delete delete markers, list delete markers: [1;31mDisabled[0m
	   ...<Truncated xecution output>...
   
   [1mAUTHOR[0m
	   Written by Adly Taibi.
   
   [1mCOPYRIGHT[0m
	   License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
	   This is free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent permitted by law.
   ```

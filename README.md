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
   Internally signed certs, you can do something like this:
   ```bash
   ./removeversiondbucket -a='--endpoint-url https://s3.demo.netapp.com:8082 --ca chain.pem'
   ```

   * **_Note:_** the script will not work for self-signed certificates.

Usage
-----

   ```bash
   ~ $ removeversiondbucket --help
   USAGE
	   Building and destroying an S3 bucket with versioning
   
   SYNOPSIS
	   removeversiondbucket [-h|--help]
	   [[-a|--awscliopts]=OPTIONS] [[-b|--bucket]=NAME] [[-c|--numfiles]=VALUE] [[-d|--numvers]=VALUE]
	   [[-v|--donotenableversioning] | [+v|--enableversioning]]
	   [[-f|--disablefileuploads] | [+f|--enablefileuploads]]
	   [[-rb|--removebucket] | [-kb|--keepbucket]]
	   [[-g|--governor]=VALUE] [-s|--hidecounters]
	   [-r|--showonly] [-sr|--showrun]
	   [[-sb|--switchboard]=VALUE]
   
   
   DESCRIPTION
	   -a=OPTIONS, --awscliopts="OPTIONS"	(default: "--endpoint-url https://s3.demo.netapp.com:8082 --ca chain.pem")
		   Refer to aws help pages. Do not add aws at the beginning of the options, it's already taken care of.
   
	   -b=NAME, --bucket=NAME	(default: bucket)
		   Provide a bucket name for existing or to be created.
   
	   -c=VALUE, --numfiles=VALUE	(default: 100)
		   Number of test files that will be generated and PUT into bucket.
   
	   -d=VALUE, --numvers=VALUE	(default: 2) 
		   Number of versions per file.
   
	   -v, --donotenableversioning, +v, --enableversioning		(default: Enabled)
		   Enable or don't enable versioning on the bucket.
   
	   -f, --disablefileuploads, +f, --enablefileuploads	(default: Enabled)
		   Create and update (PUT) files.
   
	   -rb, --removebucket, -kb, --keepbucket	(default: Delete bucket)
		   Keep or delete the bucket. This delete command will fail if the bucket is not empty.
   
	   -g=VALUE, --governor=VALUE	(default: 20)
		   Throttle the number of parallel PUT or DELETE operations. Set to 0 for unlimited.
		   Set this a value you're comfortable with depending how powerful your machine is.
   
	   -s, --hidecounters	(default: Disabled)
		   Set this switch to hide counters from being printed. Counters are shown by default.
   
	   -r, --showonly
		   This option will only show the parameters and not execute the program.
		   This is a great way to check the parameters before launching what could be sometimes a long running operations.
   
	   -sr, --showrun
		   This option will show the parameters and execute the program.
   
	   -sb=VALUE, --switchboard=VALUE	(default: 777)
		   In order to reduce the number of options to set for the following 9 parameters. We'll be using the octal numbers similar to *nix style file permissions.
		   There are three set of phases the program goes through Object, File versions and Delete markers.
		   Each phase has three sets of parameters pre-delete list, delete operation and post-delete list.
		   The pre and post listing steps are only for printing and pretty much noise. The delete operation is what's important.
   
		   The 3 phases have been assigned a digit location in the switchboard option.
		   The left digit has been assigned to the Object phase.
		   The middle digit has been assigned to the File versions phase.
		   The right digit has been assigned to the Delete markers phase.
   
		   Each phase's digit value is the addition of the following options' values.
		   The pre-delete list options have been assigned a value of 4 to enable and a 0 to disable.
		   The delete operation options have been assigned a value of 2 to enable and a 0 to disable.
		   The post-delete list options have been assigned a value of 1 to enable and a 0 to disable.
   
		   For example:
			   1- Enabling all options for all phases would the addition of 4,2,1 which adds up to 7,7,7 put together would form a switchboard option of 777.
   
			   2- Enabling only pre-delete listing for all phases is a 4 for each phase and put together forms a switchboard option of 444.
   
			   3- Performing the delete operations and post-delete list for File versions and Delete markers phases only,
			     the Object phase would score a 0 and the other two phases would score a 3 each, so the switchboard option value would be 033.
   
   EXAMPLES
	   The following command will show the parameters then executes:
   
	   $ removeversiondbucket -sr -a="--endpoint-url https://s3.demo.netapp.com:8082 --ca chain.pem" -b=mybucket -c=5000 -d=5 -kb -g=30 -sb=222 -rb
   
	   aws cli extra options (-a): aws --endpoint-url https://s3.demo.netapp.com:8082 --ca chain.pem
	   Bucket name (-b): mybucket
	   Number of files to create (-c): 5000
	   Number of versions per file to create (-d): 5
	   Enable versioning (-v,+v): Enabled
	   Enable file uploads (-f,+f): Enabled
	   Delete bucket (-rb,-kb): Enabled
	   Throttle parallel (-g): 30
	   Show counters (-s): Enabled
	   Execute after show (-sr): Enabled
	   Switchboard setting (-sb): 222
	   ====================== Object phase ======================
	   Pre-Delete object list, objects: Disabled
	      DELETE all objects: Enabled
	   Post Delete object, list objects: Disabled
	   ================== File versions phase ==================
	   Pre-Delete file versions, list versions: Disabled
	      DELETE all files' versions: Enabled
	   Post Delete file versions, list versions:: Disabled
	   ================== Delete markers phase ==================
	   Pre-Delete delete markers, list delete markers: Disabled
	      DELETE all delete markers: Enabled
	   Post Delete delete markers, list delete markers: Disabled
	   ...<Truncated execution output>...
   
   AUTHOR
	   Written by Adly Taibi.
   
   COPYRIGHT
	   License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
	   This is free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent permitted by law.
   ```

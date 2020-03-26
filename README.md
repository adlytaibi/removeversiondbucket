Custom workflows for S3 bucket with versioning
==============================================

![](https://raw.githubusercontent.com/adlytaibi/ss/master/removeversiondbucket/removeversiondbucket.gif)

This tool helps whether you want to understand how to build and destroy a bucket with versioning or simply testing a few scenarios and workflows. A default number parallel operations is set by a `governor` variable.
This is a highly customizable bash script that will go through any or all of the following workflows:
- Create a bucket if it doesn't exist
- Check and enable or suspend versioning on the newly created or existing bucket
- Create C-times test files and upload (PUT) to the bucket
- Clean-up the C-times test files from the local file system
- Update every file and PUT to create a new version of each file D-times
- List and/or delete `all files` in the bucket
- List and/or delete `all files versions` in the bucket
- List and/or delete `all delete markers` in the bucket
- Keep or Delete the bucket
 
### WARNING: In some workflows, the script will **DELETE** the bucket at the end. Unless `-kb` or `--keepbucket` switch is used.

Pre-requisites
--------------

* aws-cli
* bash (>=v3)
* jq
* awk
* sed
* ps
* bc

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

Safe Example
------------

In this example, `10 files` are uploaded with `2 versions`, all files in the bucket are deleted, only `delete markers` are deleted and the bucket is kept. Which means restoring the deleted files or an undelete.
* **_Note:_** For an existing bucket with files, `all` files are deleted and restored, the `10 files` with their `2 versions` and any file that existed in the bucket prior to enabling versioning.

```bash
$ removeversiondbucket -a="--endpoint-url https://webscaledemo.netapp.com" \
-c=10 -g=20 -b=restore -sb=202 -kb -sr
aws cli extra options (-a): aws --endpoint-url https://webscaledemo.netapp.com
Bucket name (-b): restore
Number of files to create (-c): 10
Number of versions per file to create (-d): 2
Enable versioning (-v,+v): Enabled
Enable file uploads (-f,+f): Enabled
Delete bucket (-rb,-kb): Disabled
Throttle parallel (-g): 20
Show counters (-s): Enabled
Execute after show (-sr): Enabled
Switchboard setting (-sb): 202
====================== Object phase ======================
Pre-Delete object list, objects: Disabled
   DELETE all objects: Enabled
Post Delete object, list objects: Disabled
================== File versions phase ==================
Pre-Delete file versions, list versions: Disabled
   DELETE all files' versions: Disabled
Post Delete file versions, list versions:: Disabled
================== Delete markers phase ==================
Pre-Delete delete markers, list delete markers: Disabled
   DELETE all delete markers: Enabled
Post Delete delete markers, list delete markers: Disabled
########## Check for bucket "restore" ##########
Bucket named "restore" is available
########## Creating bucket "restore" ##########
make_bucket: restore
########## Check versioning on bucket "restore" ##########
########## Enabling versioning on bucket "restore" ##########
########## Creating 10 files and 2 version(s) ##########
Q0RFMDBGM0YtNkYyRS0xMUVBLTg5QjgtQUNDNzAwQkExNTQ5 file 1/10 version 1/2
Q0RFMTk1RTItNkYyRS0xMUVBLTg3RDItOEMxNDAwQkExNTQ5 file 2/10 version 2/2
Q0RFNTNGNjUtNkYyRS0xMUVBLThGMjItQUMxNTAwQkExNTQ5 file 2/10 version 1/2
Q0RFNjUwRDgtNkYyRS0xMUVBLTgxNjYtRkI0NjAwQkExNTQ5 file 1/10 version 2/2
Q0RGNUUxM0ItNkYyRS0xMUVBLTlDRjAtNEQ4QTAwQkExNTQ5 file 3/10 version 1/2
Q0UwQzlEOEUtNkYyRS0xMUVBLTkyQzYtNUNEMDAwQkExNTQ5 file 4/10 version 2/2
Q0UwREQ2MTEtNkYyRS0xMUVBLThDNzctMTYzNjAwQkExNTQ5 file 3/10 version 2/2
Q0U0MURFNjQtNkYyRS0xMUVBLTg0NDQtODJDNjAwQkExNTQ5 file 5/10 version 2/2
Q0U0M0IzMjctNkYyRS0xMUVBLTlFNDgtMjUwODAwQkExNTQ5 file 4/10 version 1/2
Q0U1MDVENUEtNkYyRS0xMUVBLTkxQTktN0I2NDAwQkExNTQ5 file 6/10 version 2/2
Q0U2NEY2RTEtNkYyRS0xMUVBLThBNjMtNEExOTAwQkExNTQ5 file 5/10 version 1/2
Q0VBNzdFMjQtNkYyRS0xMUVBLThDRDgtNDBDNzAwQkExNTQ5 file 7/10 version 2/2
Q0VBOUExMDctNkYyRS0xMUVBLTk2MDktODhFQjAwQkExNTQ5 file 6/10 version 1/2
Q0VCMzE2RUQtNkYyRS0xMUVBLThBM0ItQjkwRTAwQkExNTQ5 file 9/10 version 2/2
Q0VCMzE2RUUtNkYyRS0xMUVBLTg3RTYtRUJEMTAwQkExNTQ5 file 8/10 version 2/2
Q0VCNDAxNTMtNkYyRS0xMUVBLTg5QjctRDBBNTAwQkExNTQ5 file 7/10 version 1/2
Q0VCMkVGREEtNkYyRS0xMUVBLTlEMkMtNkI2RjAwQkExNTQ5 file 10/10 version 2/2
Q0VCNDI4NjYtNkYyRS0xMUVBLTkwQzItMTFFRjAwQkExNTQ5 file 8/10 version 1/2
Q0VCOTU4ODktNkYyRS0xMUVBLTg4MzItMEJDMDAwQkExNTQ5 file 9/10 version 1/2
Q0VCQTFCREMtNkYyRS0xMUVBLTlGNzYtNzQ4NTAwQkExNTQ5 file 10/10 version 1/2
########## Cleaning up local files ##########
########## Deleting all 10 files in bucket "restore" ##########
Q0ZENTRGRjMtNkYyRS0xMUVBLTlGNUUtODNCMTAwQkExNTQ5 Object 1/10
Q0ZENTlFMTQtNkYyRS0xMUVBLTlFNDUtNzQ5NjAwQkExNTQ5 Object 4/10
Q0ZFMTBGQzUtNkYyRS0xMUVBLThCOUQtQ0U3RTAwQkExNTQ5 Object 5/10
Q0ZFMzU5QjYtNkYyRS0xMUVBLThBRUUtRkM0MzAwQkExNTQ5 Object 2/10
Q0ZFM0E3RDktNkYyRS0xMUVBLTk2NDktRENGMDAwQkExNTQ5 Object 3/10
Q0ZFMzgwQzctNkYyRS0xMUVBLThGODgtQkEyNDAwQkExNTQ5 Object 8/10
Q0ZFMzgwQzgtNkYyRS0xMUVBLThDRTEtMTQzMDAwQkExNTQ5 Object 7/10
Q0ZFNUEzQUEtNkYyRS0xMUVBLTk2NDktQzg3NDAwQkExNTQ5 Object 9/10
Q0ZFNkRDMkItNkYyRS0xMUVBLTk4QUQtRkZEMjAwQkExNTQ5 Object 6/10
Q0ZFRjQwOUMtNkYyRS0xMUVBLTgwNzMtQjNGRjAwQkExNTQ5 Object 10/10
########## Deleting all 10 delete markers in bucket "restore" ##########
Q0ZENTlFMTQtNkYyRS0xMUVBLTlFNDUtNzQ5NjAwQkExNTQ5 Delete Marker 4/10
Q0ZFM0E3RDktNkYyRS0xMUVBLTk2NDktRENGMDAwQkExNTQ5 Delete Marker 3/10
Q0ZENTRGRjMtNkYyRS0xMUVBLTlGNUUtODNCMTAwQkExNTQ5 Delete Marker 1/10
Q0ZFMzgwQzgtNkYyRS0xMUVBLThDRTEtMTQzMDAwQkExNTQ5 Delete Marker 7/10
Q0ZFMTBGQzUtNkYyRS0xMUVBLThCOUQtQ0U3RTAwQkExNTQ5 Delete Marker 5/10
Q0ZFNkRDMkItNkYyRS0xMUVBLTk4QUQtRkZEMjAwQkExNTQ5 Delete Marker 6/10
Q0ZFMzgwQzctNkYyRS0xMUVBLThGODgtQkEyNDAwQkExNTQ5 Delete Marker 8/10
Q0ZFMzU5QjYtNkYyRS0xMUVBLThBRUUtRkM0MzAwQkExNTQ5 Delete Marker 2/10
Q0ZFNUEzQUEtNkYyRS0xMUVBLTk2NDktQzg3NDAwQkExNTQ5 Delete Marker 9/10
Q0ZFRjQwOUMtNkYyRS0xMUVBLTgwNzMtQjNGRjAwQkExNTQ5 Delete Marker 10/10
```

You can then only list the files to show that they have been restored.
```bash
$ removeversiondbucket -a="--endpoint-url https://webscaledemo.netapp.com" \
-b=restore -sb=400 -f -kb -sr
aws cli extra options (-a): aws --endpoint-url https://webscaledemo.netapp.com
Bucket name (-b): restore
Number of files to create (-c): 10
Number of versions per file to create (-d): 2
Enable versioning (-v,+v): Enabled
Enable file uploads (-f,+f): Disabled
Delete bucket (-rb,-kb): Disabled
Throttle parallel (-g): 20
Show counters (-s): Enabled
Execute after show (-sr): Enabled
Switchboard setting (-sb): 400
====================== Object phase ======================
Pre-Delete object list, objects: Enabled
   DELETE all objects: Disabled
Post Delete object, list objects: Disabled
================== File versions phase ==================
Pre-Delete file versions, list versions: Disabled
   DELETE all files' versions: Disabled
Post Delete file versions, list versions:: Disabled
================== Delete markers phase ==================
Pre-Delete delete markers, list delete markers: Disabled
   DELETE all delete markers: Disabled
Post Delete delete markers, list delete markers: Disabled
########## Check for bucket "restore" ##########
Bucket "restore" already exists.
########## Check versioning on bucket "restore" ##########
Enabled
.......... PRE List of objects ..........
vers/test1
vers/test10
vers/test2
vers/test3
vers/test4
vers/test5
vers/test6
vers/test7
vers/test8
vers/test9
```

Usage
-----

   ```bash
   ~ $ removeversiondbucket --help
   USAGE
     Custom workflows for S3 bucket with versioning
   
   SYNOPSIS
     removeversiondbucket [-h|--help]
     [[-a|--awscliopts]=OPTIONS] [[-b|--bucket]=NAME] [[-c|--numfiles]=VALUE] [[-d|--numvers]=VALUE]
     [[-v|--suspendversioning] | [+v|--enableversioning]]
     [[-f|--disablefileuploads] | [+f|--enablefileuploads]]
     [[-rb|--removebucket] | [-kb|--keepbucket]]
     [[-g|--governor]=VALUE] [-s|--hidecounters]
     [-r|--showonly] [-sr|--showrun] [-et|--elapsedtime]
     [[-sb|--switchboard]=VALUE]
   
   
   DESCRIPTION
     -a=OPTIONS, --awscliopts="OPTIONS"  (default: "--endpoint-url https://s3.demo.netapp.com:8082 --ca chain.pem")
       Refer to aws help pages. Do not add aws at the beginning of the options, it's already taken care of.
   
     -b=NAME, --bucket=NAME  (default: Randomly Generated with rbv prefix)
       Provide a bucket name for existing or to be created.
   
     -c=VALUE, --numfiles=VALUE  (default: 100)
       Number of test files that will be generated and PUT into bucket.
   
     -d=VALUE, --numvers=VALUE  (default: 2) 
       Number of versions per file.
   
     -v, --suspendversioning, +v, --enableversioning    (default: Enabled)
       Enable or suspend versioning on the bucket.
   
     -f, --disablefileuploads, +f, --enablefileuploads  (default: Enabled)
       Create and update (PUT) files.
   
     -rb, --removebucket, -kb, --keepbucket  (default: Delete bucket)
       Keep or delete the bucket. This delete command will fail if the bucket is not empty.
   
     -g=VALUE, --governor=VALUE  (default: 20)
       Throttle the number of parallel PUT or DELETE operations. Set to 0 for unlimited.
       Set this a value you're comfortable with depending how powerful your machine is.
   
     -s, --hidecounters  (default: Disabled)
       Set this switch to hide counters from being printed. Counters are shown by default.
   
     -r, --showonly
       This option will only show the parameters and not execute the program.
       This is a great way to check the parameters before launching what could be sometimes a long running operations.
   
     -sr, --showrun
       This option will show the parameters and execute the program.

     -et, --elapsedtime
       This option will show the elapsed time for operations in format of HH:MM:SS (don't do days).
   
     -sb=VALUE, --switchboard=VALUE  (default: 777)
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
     Show elapsed time (-et): Disabled
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

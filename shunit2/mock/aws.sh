slow=.05
case "aws $*" in
'aws --endpoint-url https://webscaledemo.netapp.com s3api head-bucket --bucket bversion') (echo "An error occurred (404) when calling the HeadBucket operation: Not Found";exit 255) ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3 mb s3://bversion') echo 'make_bucket: bversion' ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api get-bucket-versioning --bucket bversion') true ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api put-bucket-versioning --bucket bversion --versioning-configuration Status=Enabled') true ;;
"aws --endpoint-url https://webscaledemo.netapp.com s3api put-object --bucket bversion --key vers/test1 --body $tmpdir/test1")
sleep $slow
  cat <<'EOF'
{
    "ETag": "\"b44fe6a9c2513fd69cf4b66d3c48c6c4\"",
    "VersionId": "RjFDNTgzOTktNzM1OS0xMUVBLThCQzEtMjJERjAwQzMyQkUx"
}
EOF

  ;;
"aws --endpoint-url https://webscaledemo.netapp.com s3api put-object --bucket bversion --key vers/test1 --body $tmpdir/test1")
sleep $slow
  cat <<'EOF'
{
    "ETag": "\"e68cf7a9601094753430c359a5eecffc\"",
    "VersionId": "RjIzNEU3M0MtNzM1OS0xMUVBLTlGNDEtMDk2ODAwQzMyQkUx"
}
EOF

  ;;
"aws --endpoint-url https://webscaledemo.netapp.com s3api put-object --bucket bversion --key vers/test2 --body $tmpdir/test2")
sleep $slow
  cat <<'EOF'
{
    "ETag": "\"ee0a455bab1ad2cad485116581adb2ca\"",
    "VersionId": "RjJBRTBFREYtNzM1OS0xMUVBLTlGRjgtRTk0RDAwQzMyQkUx"
}
EOF

  ;;
"aws --endpoint-url https://webscaledemo.netapp.com s3api put-object --bucket bversion --key vers/test2 --body $tmpdir/test2")
sleep $slow
  cat <<'EOF'
{
    "ETag": "\"ee0a455bab1ad2cad485116581adb2ca\"",
    "VersionId": "RjM0NzFBOTItNzM1OS0xMUVBLTk5RTQtMEYyMTAwQzMyQkUx"
}
EOF

  ;;
"aws --endpoint-url https://webscaledemo.netapp.com s3api put-object --bucket bversion --key vers/test3 --body $tmpdir/test3")
sleep $slow
  cat <<'EOF'
{
    "ETag": "\"3c68807c976fb11b2e9b47675bad7715\"",
    "VersionId": "RjNCNzhGQTUtNzM1OS0xMUVBLThGMzYtMzBFMjAwQzMyQkUx"
}
EOF

  ;;
"aws --endpoint-url https://webscaledemo.netapp.com s3api put-object --bucket bversion --key vers/test3 --body $tmpdir/test3")
sleep $slow
  cat <<'EOF'
{
    "ETag": "\"fc6a18e06af37af25d194819265822f3\"",
    "VersionId": "RjQzMjNERTgtNzM1OS0xMUVBLTkyMzMtN0Y1QzAwQzMyQkUx"
}
EOF

  ;;
"aws --endpoint-url https://webscaledemo.netapp.com s3api put-object --bucket bversion --key vers/test4 --body $tmpdir/test4")
sleep $slow
  cat <<'EOF'
{
    "ETag": "\"261cf36b75e82cc176fbeafe6f580719\"",
    "VersionId": "RjRBNjM1NkItNzM1OS0xMUVBLThEM0MtN0VDRjAwQzMyQkUx"
}
EOF

  ;;
"aws --endpoint-url https://webscaledemo.netapp.com s3api put-object --bucket bversion --key vers/test4 --body $tmpdir/test4")
sleep $slow
  cat <<'EOF'
{
    "ETag": "\"79b877fbd1f866b3e175f2a41328edc2\"",
    "VersionId": "RjUxQzI4QkUtNzM1OS0xMUVBLTlCOTYtRTZCQzAwQzMyQkUx"
}
EOF

  ;;
"aws --endpoint-url https://webscaledemo.netapp.com s3api put-object --bucket bversion --key vers/test5 --body $tmpdir/test5")
sleep $slow
  cat <<'EOF'
{
    "ETag": "\"ff7a5e5d141f56125ef9fb7f5d76c729\"",
    "VersionId": "RjVBQzgxRTEtNzM1OS0xMUVBLTkwNUUtNzYwRDAwQzMyQkUx"
}
EOF

  ;;
"aws --endpoint-url https://webscaledemo.netapp.com s3api put-object --bucket bversion --key vers/test5 --body $tmpdir/test5")
sleep $slow
  cat <<'EOF'
{
    "ETag": "\"ff7a5e5d141f56125ef9fb7f5d76c729\"",
    "VersionId": "RjYxREUxNTQtNzM1OS0xMUVBLTlDQTUtMzkyNDAwQzMyQkUx"
}
EOF

  ;;
"aws --endpoint-url https://webscaledemo.netapp.com s3api put-object --bucket bversion --key vers/test6 --body $tmpdir/test6")
sleep $slow
  cat <<'EOF'
{
    "ETag": "\"631a090847c238e8166bee79291ce169\"",
    "VersionId": "RjZBNjI0MjctNzM1OS0xMUVBLTgzRjktNzM2MTAwQzMyQkUx"
}
EOF

  ;;
"aws --endpoint-url https://webscaledemo.netapp.com s3api put-object --bucket bversion --key vers/test6 --body $tmpdir/test6")
sleep $slow
  cat <<'EOF'
{
    "ETag": "\"6f6c2c3b8ef6533b0504165389f723bb\"",
    "VersionId": "RjczM0U1M0EtNzM1OS0xMUVBLTlEOEEtRUUyODAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api list-objects --bucket bversion')
  if [[ ! -f /tmp/.list-objects ]];then
  touch /tmp/.list-objects
  cat <<'EOF'
{
    "Contents": [
        {
            "Key": "vers/test1",
            "LastModified": "2020-03-31T14:14:34.105Z",
            "ETag": "\"e68cf7a9601094753430c359a5eecffc\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        },
        {
            "Key": "vers/test2",
            "LastModified": "2020-03-31T14:14:35.902Z",
            "ETag": "\"ee0a455bab1ad2cad485116581adb2ca\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        },
        {
            "Key": "vers/test3",
            "LastModified": "2020-03-31T14:14:37.443Z",
            "ETag": "\"fc6a18e06af37af25d194819265822f3\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        },
        {
            "Key": "vers/test4",
            "LastModified": "2020-03-31T14:14:38.976Z",
            "ETag": "\"79b877fbd1f866b3e175f2a41328edc2\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        },
        {
            "Key": "vers/test5",
            "LastModified": "2020-03-31T14:14:40.665Z",
            "ETag": "\"ff7a5e5d141f56125ef9fb7f5d76c729\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        },
        {
            "Key": "vers/test6",
            "LastModified": "2020-03-31T14:14:42.487Z",
            "ETag": "\"6f6c2c3b8ef6533b0504165389f723bb\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        }
    ]
}
EOF
else
  true
fi
  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test1')
  cat <<'EOF'
{
    "DeleteMarker": true,
    "VersionId": "RjgxMEQ3QkQtNzM1OS0xMUVBLTlCRjQtRkJDQjAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test2')
  cat <<'EOF'
{
    "DeleteMarker": true,
    "VersionId": "Rjg3RDJFMUUtNzM1OS0xMUVBLTk4MEQtQUZERjAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test3')
  cat <<'EOF'
{
    "DeleteMarker": true,
    "VersionId": "RjhGNkYxRkYtNzM1OS0xMUVBLTg4NzgtQ0FDNzAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test4')
  cat <<'EOF'
{
    "DeleteMarker": true,
    "VersionId": "Rjk1Rjc3RDAtNzM1OS0xMUVBLThFRkEtQzdEMDAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test5')
  cat <<'EOF'
{
    "DeleteMarker": true,
    "VersionId": "RjlEODJBNDEtNzM1OS0xMUVBLTkzMTUtNUJBNTAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test6')
  cat <<'EOF'
{
    "DeleteMarker": true,
    "VersionId": "RkE1QkIyMjItNzM1OS0xMUVBLTlERjItNzU4NjAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api list-object-versions --bucket bversion')
# file version phase
  if [[ ! -f /tmp/.list-object-versions ]];then
  touch /tmp/.list-object-versions
  cat <<'EOF'
{
    "Versions": [
        {
            "ETag": "\"e68cf7a9601094753430c359a5eecffc\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Key": "vers/test1",
            "VersionId": "RjIzNEU3M0MtNzM1OS0xMUVBLTlGNDEtMDk2ODAwQzMyQkUx",
            "IsLatest": false,
            "LastModified": "2020-03-31T14:14:34.105Z",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        },
        {
            "ETag": "\"b44fe6a9c2513fd69cf4b66d3c48c6c4\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Key": "vers/test1",
            "VersionId": "RjFDNTgzOTktNzM1OS0xMUVBLThCQzEtMjJERjAwQzMyQkUx",
            "IsLatest": false,
            "LastModified": "2020-03-31T14:14:33.375Z",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        },
        {
            "ETag": "\"ee0a455bab1ad2cad485116581adb2ca\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Key": "vers/test2",
            "VersionId": "RjM0NzFBOTItNzM1OS0xMUVBLTk5RTQtMEYyMTAwQzMyQkUx",
            "IsLatest": false,
            "LastModified": "2020-03-31T14:14:35.902Z",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        },
        {
            "ETag": "\"ee0a455bab1ad2cad485116581adb2ca\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Key": "vers/test2",
            "VersionId": "RjJBRTBFREYtNzM1OS0xMUVBLTlGRjgtRTk0RDAwQzMyQkUx",
            "IsLatest": false,
            "LastModified": "2020-03-31T14:14:34.899Z",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        },
        {
            "ETag": "\"fc6a18e06af37af25d194819265822f3\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Key": "vers/test3",
            "VersionId": "RjQzMjNERTgtNzM1OS0xMUVBLTkyMzMtN0Y1QzAwQzMyQkUx",
            "IsLatest": false,
            "LastModified": "2020-03-31T14:14:37.443Z",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        },
        {
            "ETag": "\"3c68807c976fb11b2e9b47675bad7715\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Key": "vers/test3",
            "VersionId": "RjNCNzhGQTUtNzM1OS0xMUVBLThGMzYtMzBFMjAwQzMyQkUx",
            "IsLatest": false,
            "LastModified": "2020-03-31T14:14:36.639Z",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        },
        {
            "ETag": "\"79b877fbd1f866b3e175f2a41328edc2\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Key": "vers/test4",
            "VersionId": "RjUxQzI4QkUtNzM1OS0xMUVBLTlCOTYtRTZCQzAwQzMyQkUx",
            "IsLatest": false,
            "LastModified": "2020-03-31T14:14:38.976Z",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        },
        {
            "ETag": "\"261cf36b75e82cc176fbeafe6f580719\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Key": "vers/test4",
            "VersionId": "RjRBNjM1NkItNzM1OS0xMUVBLThEM0MtN0VDRjAwQzMyQkUx",
            "IsLatest": false,
            "LastModified": "2020-03-31T14:14:38.203Z",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        },
        {
            "ETag": "\"ff7a5e5d141f56125ef9fb7f5d76c729\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Key": "vers/test5",
            "VersionId": "RjYxREUxNTQtNzM1OS0xMUVBLTlDQTUtMzkyNDAwQzMyQkUx",
            "IsLatest": false,
            "LastModified": "2020-03-31T14:14:40.665Z",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        },
        {
            "ETag": "\"ff7a5e5d141f56125ef9fb7f5d76c729\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Key": "vers/test5",
            "VersionId": "RjVBQzgxRTEtNzM1OS0xMUVBLTkwNUUtNzYwRDAwQzMyQkUx",
            "IsLatest": false,
            "LastModified": "2020-03-31T14:14:39.922Z",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        },
        {
            "ETag": "\"6f6c2c3b8ef6533b0504165389f723bb\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Key": "vers/test6",
            "VersionId": "RjczM0U1M0EtNzM1OS0xMUVBLTlEOEEtRUUyODAwQzMyQkUx",
            "IsLatest": false,
            "LastModified": "2020-03-31T14:14:42.487Z",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        },
        {
            "ETag": "\"631a090847c238e8166bee79291ce169\"",
            "Size": 29,
            "StorageClass": "STANDARD",
            "Key": "vers/test6",
            "VersionId": "RjZBNjI0MjctNzM1OS0xMUVBLTgzRjktNzM2MTAwQzMyQkUx",
            "IsLatest": false,
            "LastModified": "2020-03-31T14:14:41.558Z",
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            }
        }
    ],
    "DeleteMarkers": [
        {
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            },
            "Key": "vers/test1",
            "VersionId": "RjgxMEQ3QkQtNzM1OS0xMUVBLTlCRjQtRkJDQjAwQzMyQkUx",
            "IsLatest": true,
            "LastModified": "2020-03-31T14:14:43.935Z"
        },
        {
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            },
            "Key": "vers/test2",
            "VersionId": "Rjg3RDJFMUUtNzM1OS0xMUVBLTk4MEQtQUZERjAwQzMyQkUx",
            "IsLatest": true,
            "LastModified": "2020-03-31T14:14:44.645Z"
        },
        {
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            },
            "Key": "vers/test3",
            "VersionId": "RjhGNkYxRkYtNzM1OS0xMUVBLTg4NzgtQ0FDNzAwQzMyQkUx",
            "IsLatest": true,
            "LastModified": "2020-03-31T14:14:45.443Z"
        },
        {
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            },
            "Key": "vers/test4",
            "VersionId": "Rjk1Rjc3RDAtNzM1OS0xMUVBLThFRkEtQzdEMDAwQzMyQkUx",
            "IsLatest": true,
            "LastModified": "2020-03-31T14:14:46.128Z"
        },
        {
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            },
            "Key": "vers/test5",
            "VersionId": "RjlEODJBNDEtNzM1OS0xMUVBLTkzMTUtNUJBNTAwQzMyQkUx",
            "IsLatest": true,
            "LastModified": "2020-03-31T14:14:46.919Z"
        },
        {
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            },
            "Key": "vers/test6",
            "VersionId": "RkE1QkIyMjItNzM1OS0xMUVBLTlERjItNzU4NjAwQzMyQkUx",
            "IsLatest": true,
            "LastModified": "2020-03-31T14:14:47.781Z"
        }
    ]
}
EOF
else
# delete marker phase
  if [[ ! -f /tmp/.list-object-versions-dmarkers ]];then
  touch /tmp/.list-object-versions-dmarkers
  cat <<'EOF'
{
    "DeleteMarkers": [
        {
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            },
            "Key": "vers/test1",
            "VersionId": "RjgxMEQ3QkQtNzM1OS0xMUVBLTlCRjQtRkJDQjAwQzMyQkUx",
            "IsLatest": true,
            "LastModified": "2020-03-31T14:14:43.935Z"
        },
        {
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            },
            "Key": "vers/test2",
            "VersionId": "Rjg3RDJFMUUtNzM1OS0xMUVBLTk4MEQtQUZERjAwQzMyQkUx",
            "IsLatest": true,
            "LastModified": "2020-03-31T14:14:44.645Z"
        },
        {
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            },
            "Key": "vers/test3",
            "VersionId": "RjhGNkYxRkYtNzM1OS0xMUVBLTg4NzgtQ0FDNzAwQzMyQkUx",
            "IsLatest": true,
            "LastModified": "2020-03-31T14:14:45.443Z"
        },
        {
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            },
            "Key": "vers/test4",
            "VersionId": "Rjk1Rjc3RDAtNzM1OS0xMUVBLThFRkEtQzdEMDAwQzMyQkUx",
            "IsLatest": true,
            "LastModified": "2020-03-31T14:14:46.128Z"
        },
        {
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            },
            "Key": "vers/test5",
            "VersionId": "RjlEODJBNDEtNzM1OS0xMUVBLTkzMTUtNUJBNTAwQzMyQkUx",
            "IsLatest": true,
            "LastModified": "2020-03-31T14:14:46.919Z"
        },
        {
            "Owner": {
                "DisplayName": "Adly Taibi",
                "ID": "XXXXXXXXXXXXXXXXXXXX"
            },
            "Key": "vers/test6",
            "VersionId": "RkE1QkIyMjItNzM1OS0xMUVBLTlERjItNzU4NjAwQzMyQkUx",
            "IsLatest": true,
            "LastModified": "2020-03-31T14:14:47.781Z"
        }
    ]
}
EOF
fi
fi
[[ $ov == 3 ]] && true
ov+=1
  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test1 --version-id RjIzNEU3M0MtNzM1OS0xMUVBLTlGNDEtMDk2ODAwQzMyQkUx')
  cat <<'EOF'
{
    "VersionId": "RjIzNEU3M0MtNzM1OS0xMUVBLTlGNDEtMDk2ODAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test1 --version-id RjFDNTgzOTktNzM1OS0xMUVBLThCQzEtMjJERjAwQzMyQkUx')
  cat <<'EOF'
{
    "VersionId": "RjFDNTgzOTktNzM1OS0xMUVBLThCQzEtMjJERjAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test2 --version-id RjM0NzFBOTItNzM1OS0xMUVBLTk5RTQtMEYyMTAwQzMyQkUx')
  cat <<'EOF'
{
    "VersionId": "RjM0NzFBOTItNzM1OS0xMUVBLTk5RTQtMEYyMTAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test2 --version-id RjJBRTBFREYtNzM1OS0xMUVBLTlGRjgtRTk0RDAwQzMyQkUx')
  cat <<'EOF'
{
    "VersionId": "RjJBRTBFREYtNzM1OS0xMUVBLTlGRjgtRTk0RDAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test3 --version-id RjQzMjNERTgtNzM1OS0xMUVBLTkyMzMtN0Y1QzAwQzMyQkUx')
  cat <<'EOF'
{
    "VersionId": "RjQzMjNERTgtNzM1OS0xMUVBLTkyMzMtN0Y1QzAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test3 --version-id RjNCNzhGQTUtNzM1OS0xMUVBLThGMzYtMzBFMjAwQzMyQkUx')
  cat <<'EOF'
{
    "VersionId": "RjNCNzhGQTUtNzM1OS0xMUVBLThGMzYtMzBFMjAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test4 --version-id RjUxQzI4QkUtNzM1OS0xMUVBLTlCOTYtRTZCQzAwQzMyQkUx')
  cat <<'EOF'
{
    "VersionId": "RjUxQzI4QkUtNzM1OS0xMUVBLTlCOTYtRTZCQzAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test4 --version-id RjRBNjM1NkItNzM1OS0xMUVBLThEM0MtN0VDRjAwQzMyQkUx')
  cat <<'EOF'
{
    "VersionId": "RjRBNjM1NkItNzM1OS0xMUVBLThEM0MtN0VDRjAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test5 --version-id RjYxREUxNTQtNzM1OS0xMUVBLTlDQTUtMzkyNDAwQzMyQkUx')
  cat <<'EOF'
{
    "VersionId": "RjYxREUxNTQtNzM1OS0xMUVBLTlDQTUtMzkyNDAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test5 --version-id RjVBQzgxRTEtNzM1OS0xMUVBLTkwNUUtNzYwRDAwQzMyQkUx')
  cat <<'EOF'
{
    "VersionId": "RjVBQzgxRTEtNzM1OS0xMUVBLTkwNUUtNzYwRDAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test6 --version-id RjczM0U1M0EtNzM1OS0xMUVBLTlEOEEtRUUyODAwQzMyQkUx')
  cat <<'EOF'
{
    "VersionId": "RjczM0U1M0EtNzM1OS0xMUVBLTlEOEEtRUUyODAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test6 --version-id RjZBNjI0MjctNzM1OS0xMUVBLTgzRjktNzM2MTAwQzMyQkUx')
  cat <<'EOF'
{
    "VersionId": "RjZBNjI0MjctNzM1OS0xMUVBLTgzRjktNzM2MTAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test1 --version-id RjgxMEQ3QkQtNzM1OS0xMUVBLTlCRjQtRkJDQjAwQzMyQkUx')
  cat <<'EOF'
{
    "DeleteMarker": true,
    "VersionId": "RjgxMEQ3QkQtNzM1OS0xMUVBLTlCRjQtRkJDQjAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test2 --version-id Rjg3RDJFMUUtNzM1OS0xMUVBLTk4MEQtQUZERjAwQzMyQkUx')
  cat <<'EOF'
{
    "DeleteMarker": true,
    "VersionId": "Rjg3RDJFMUUtNzM1OS0xMUVBLTk4MEQtQUZERjAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test3 --version-id RjhGNkYxRkYtNzM1OS0xMUVBLTg4NzgtQ0FDNzAwQzMyQkUx')
  cat <<'EOF'
{
    "DeleteMarker": true,
    "VersionId": "RjhGNkYxRkYtNzM1OS0xMUVBLTg4NzgtQ0FDNzAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test4 --version-id Rjk1Rjc3RDAtNzM1OS0xMUVBLThFRkEtQzdEMDAwQzMyQkUx')
  cat <<'EOF'
{
    "DeleteMarker": true,
    "VersionId": "Rjk1Rjc3RDAtNzM1OS0xMUVBLThFRkEtQzdEMDAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test5 --version-id RjlEODJBNDEtNzM1OS0xMUVBLTkzMTUtNUJBNTAwQzMyQkUx')
  cat <<'EOF'
{
    "DeleteMarker": true,
    "VersionId": "RjlEODJBNDEtNzM1OS0xMUVBLTkzMTUtNUJBNTAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3api delete-object --bucket bversion --key vers/test6 --version-id RkE1QkIyMjItNzM1OS0xMUVBLTlERjItNzU4NjAwQzMyQkUx')
  cat <<'EOF'
{
    "DeleteMarker": true,
    "VersionId": "RkE1QkIyMjItNzM1OS0xMUVBLTlERjItNzU4NjAwQzMyQkUx"
}
EOF

  ;;
'aws --endpoint-url https://webscaledemo.netapp.com s3 rb s3://bversion') echo 'remove_bucket: bversion' ;;
*)
  echo "No responses for: aws $*" | tee -a unknown_commands
  ;;
esac

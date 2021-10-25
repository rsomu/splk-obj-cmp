# splk-obj-cmp
  Tool to compare the Splunk objects in a Splunk Multisite SmartStore setup with two FlashBlades

  This repository contains the main script

    objdiff.sh - Reports the object counts and size at every Splunk index level in a csv format for both the source and target FBs

## Who should be using this toolkit?

  If you are a Splunk Multisite SmartStore customer in an on-prem setup with two FlashBlades setup in an asynchronous replication at a bucket level and are looking to compare the object details between the source and target FB 

## How to use this toolkit?

  Follow the steps given below to run the objdiff.sh script which will provide two CSV files.

```
   objects_<date+time>.csv will show the object counts and sizes of all indexes without receipt.json across both source and target FBs
   receipts_<date+time>.csv will show the counts and sizes of all receipt.json across both source and target FBs
```

## Build the docker image
  Make sure the shell scripts are in the same directory as the Dockerfile is.

Usage
```
  docker build -t splk-obj-cmp .
```

## Prerequisites to run the scripts
```
  1. Create a credentials file in the following format with the details of the source and target FlashBlade.

     [source]
     aws_access_key_id=xxxxxx
     aws_secret_access_key=xxxxxx

     [target]
     aws_access_key_id=xxxxx
     aws_secret_access_key=xxxxxxx
  
  2. Create an environment file named objsync.conf with following information.
 
     srccreds=<name from credentials>
     dstcreds=<name from credentials>
     srcvip=http://<source data vip>
     dstvip=http://<target data vip>
     srcbucket=<source bucket name>
     dstbucket=<target bucket name>

  3. Create a directory named pure which will hold the runtime files and log files.
     Note: Make sure to have enough storage space for this pure directory depending on the excessive object counts.

  4. Make sure the directory you are running the script from has the following files/dir.

     credentials
     objcmp.conf
     pure (directory)

```

## Running the scripts

Usage
```
  To get the count and size at every Splunk index level across both FBs in a csv file

  docker run --rm -v `pwd`/credentials:/root/.aws/credentials --env-file=`pwd`/objcmp.conf --mount type=bind,source=`pwd`/pure,target=/pure splk-obj-cmp objdiff.sh

```

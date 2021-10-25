#!/bin/bash
# Tool creates a csv file showing the count of objects and total space usage at Splunk index level from both source and target FBs
# objects_<date+time>.csv will show the object counts and sizes of all indexes without receipt.json across both source and target FBs
# receipts_<date+time>.csv will show the counts and sizes of all receipt.json across both source and target FBs

# Usage: objdiff.sh 

ts=`date +%Y%m%d-%H%M%S`
(AWS_PROFILE=$srccreds s5cmd --endpoint-url $srcvip ls 's3://'"$srcbucket"'/*' |grep -v receipt | awk ' {print "SRC/"$3"/"$4}'; AWS_PROFILE=$dstcreds s5cmd --endpoint-url $dstvip ls 's3://'"$dstbucket"'/*' |grep -v receipt |awk ' {print "DST/"$3"/"$4}') | awk -F/ '{ arr[$3"-"$1] += $2; ct[$3"-"$1]+=1} END { for (i in arr) {print i ","ct[i] "," arr[i] }}' |sort  > /pure/objects_${ts}.csv
(AWS_PROFILE=$srccreds s5cmd --endpoint-url $srcvip ls 's3://'"$srcbucket"'/*' |grep receipt | awk ' {print "SRC/"$3"/"$4}'; AWS_PROFILE=$dstcreds s5cmd --endpoint-url $dstvip ls 's3://'"$dstbucket"'/*' |grep receipt |awk ' {print "DST/"$3"/"$4}') | awk -F/ '{ arr[$3"-"$1] += $2; ct[$3"-"$1]+=1} END { for (i in arr) {print i ","ct[i] "," arr[i] }}' |sort  > /pure/receipts_${ts}.csv


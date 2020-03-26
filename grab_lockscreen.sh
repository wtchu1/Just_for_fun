#!/bin/bash

lock_pic_dir="/mnt/c/Users/wc11/AppData/Local/Packages/Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy/LocalState/Assets"
tmp_dir="/mnt/c/Users/wc11/Pictures/Desktop_Backgrounds/tmp_dir"

echo "lockscreen dir: $lock_pic_dir"
echo "tmp_dir: $tmp_dir"
list1=`ls -s $lock_pic_dir`

#Create temp dir
if [ ! -d $tmp_dir ]; then
    mkdir $tmp_dir
else
    echo "777Warning: Temp dir already exists"
fi
#ls -s $lock_pic_dir

#echo "${list1}"
n=1
flag_next="no"
for i in ${list1[@]}; do
    #Skip the first two outputs of ls
    if [ "$n" -lt "2" ]; then
        echo ""
    #Every even input (file size)
    elif [ $(( n % 2 )) == 0 ]; then
        #If the file size has been flagged as big enough
        if [ $flag_next == "yes" ]; then
            #output file name
            echo " $i"
            #and copy to the temp folder
            cp $lock_pic_dir/$i $tmp_dir/tmp${n}.jpg
            flag_next="no"
        fi
    else
        #if the file size is larger than the threshold
        if [ "$i" -gt "200" ]; then
            echo -n $i
            flag_next="yes" #flag the next input for filename output
        fi
    fi
    n=$(( n + 1 ))
done



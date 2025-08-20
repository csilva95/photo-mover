#!/bin/bash

helpFunction()
{
    echo ""
    echo "Example: $0 -f ~/iphone/DCIM -t /my/usb/drive -d iphone -r 1 -u 1"
    echo -e "\t-f FROM folder (where the photos are coming from)"
    echo -e "\t\t if iphone then type: ~/iphone/DCIM"
    echo -e "\t-t TO folder   (where the photos will go)"
    echo -e "\t-d DEVICE      (device with original FROM folder)"
    echo -e "\t\t if iphone then type: iphone"
    echo -e "\t-r REVERSE (default=1)"
    echo -e "\t\t1=transfer newest photos first"
    echo -e "\t\t0=transfer oldest photos first"
    echo -e "\t-u UPDATE (default=1)"
    echo -e "\t\t1=script ends once it reaches a photo it's already transferred before"
    echo -e "\t\t0=script will end once it attempts to transfer all photos"
    exit
}

while getopts "f:t:d:r:u:" opt
do
    case "$opt" in
        f ) from_dir="$OPTARG" ;;
        t ) to_dir="$OPTARG" ;;
        d ) device="$OPTARG" ;;
        r ) reverse="$OPTARG" ;;
        u ) update="$OPTARG" ;;
        ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
    esac
done

reverse=1
update=1

# Print helpFunction in case parameters are empty
if [ -z "$from_dir" ] || [ -z "$to_dir" ] || [ -z "$device" ] ; then
   echo "Some or all of the parameters are empty:"
   helpFunction
fi

function getDate {
    image=${1}
    
    search1="Date Created"
    search2="Create Date"
    search3="Creation Date"
    
    exiftool $image > ~/tmp.txt
    
    year=$(cat ~/tmp.txt | grep -E "${search1}|${search2}|${search3}" | tr -d '\n' | cut -b 35-38)
    month=$(cat ~/tmp.txt | grep -E "${search1}|${search2}|${search3}" | tr -d '\n' | cut -b 40-41)
    day=$(cat ~/tmp.txt | grep -E "${search1}|${search2}|${search3}" | tr -d '\n' | cut -b 43-44)

    if [[ -z "$day" ]] ; then
        year=$(cat ~/tmp.txt | grep "File Modification Date/Time" | tr -d '\n' | cut -b 35-38)
        month=$(cat ~/tmp.txt | grep "File Modification Date/Time" | tr -d '\n' | cut -b 40-41)
        day=$(cat ~/tmp.txt | grep "File Modification Date/Time" | tr -d '\n' | cut -b 43-44)
    fi

    if [ $year == "0000" ] ; then
        year=$(cat ~/tmp.txt | grep "File Modification Date/Time" | tr -d '\n' | cut -b 35-38)
        month=$(cat ~/tmp.txt | grep "File Modification Date/Time" | tr -d '\n' | cut -b 40-41)
        day=$(cat ~/tmp.txt | grep "File Modification Date/Time" | tr -d '\n' | cut -b 43-44)
    fi
  
    case $month in
        01)
            month=01-jan ;;
        02)
            month=02-feb ;;
        03)
            month=03-mar ;;
        04)
            month=04-april ;;
        05)
            month=05-may ;;
        06)
            month=06-june ;;
        07)
            month=07-july ;;
        08)
            month=08-aug ;;
        09)
            month=09-sept ;;
        10)
            month=10-oct ;;
        11)
            month=11-nov ;;
        12)
            month=12-dec ;;
    esac 
    
    echo "Image Info:"
    echo "    Year  = $year"
    echo "    Month = $month"
    echo "    Day   = $day"
    echo ""  
}

while [ $device == "iphone" ] ; do
    echo "Open and unlock iphone to pair. Trying to pair with iphone..."
    idevicepair pair
    if [ $? -eq 0 ] ; then
        break
    fi
    tput cuu 2
done

if [ $device == "iphone" ] ; then
    echo ""
    echo "Pairing to iphone was successful! Keep phone on and unlocked!!!!"
    echo "Creating iphone directory"
    mkdir ~/iphone
    ifuse ~/iphone
    echo ""
fi

echo "======================================"
echo "From Location = $from_dir"
echo "======================================"
echo "Contents:"
echo "---------"
ls $from_dir
if [ $? -ne 0 ] ; then
    echo "ERROR: $from_dir Location does not exist!!!"    
    exit
fi
echo ""

echo "======================================"
echo "To   Location = $to_dir"
echo "======================================"
echo "Contents:"
echo "---------"
ls $to_dir
if [ $? -ne 0 ] ; then
    echo "ERROR: $to_dir Location does not exist!!!"    
    exit
fi
echo ""

echo "Are these locations correct? (y/n)"
read ans

if [ $ans != "y" ] ; then
    echo "Exiting Script. Please try again with correct locations"
    exit
fi

cd ${from_dir}
folders=($(ls -d *))

echo "Creating initial to folder..."
if [ -d "${to_dir}/${device}" ]; then
    echo "${to_dir}/${device} exists."
else
    mkdir ${to_dir}/${device}
fi

if [ $reverse -eq 1 ] ; then
    length=${#folders[@]}
    for (( i=0, j=$length-1; i<j; i++, j-- )); do
        temp="${folders[i]}"
        folders[i]="${folders[j]}"
        folders[j]="$temp"
    done
fi

for folder in "${folders[@]}"; do
    echo "==========================================================="
    echo "Going into ${from_dir}/${folder}"
    echo "==========================================================="
    cd ${from_dir}/${folder}
    
    images=($(ls -d *))
    
    if [ $reverse -eq 1 ] ; then
        length=${#images[@]}
        for (( i=0, j=$length-1; i<j; i++, j-- )); do
            temp="${images[i]}"
            images[i]="${images[j]}"
            images[j]="$temp"
        done
    fi
    
    for image in "${images[@]}"; do
        echo "--------------------------"
        echo "Gather data on ${image}..."
        getDate $image
        
        if [ -f "${to_dir}/${device}/${year}/${month}/DAY${day}-${image}" ]; then
            echo "${to_dir}/${device}/${year}/${month}/DAY${day}-${image} already exists :)"
            if [ $update -eq 1 ] ; then
                echo "--------------------------"
                echo "Update complete!"
                exit
            fi
        else
            echo "Creating New Folder here: ${to_dir}/${device}/${year}/${month}"
            
            if [ -d "${to_dir}/${device}/${year}" ]; then
                echo "${to_dir}/${device}/${year} exists."
            else
                mkdir ${to_dir}/${device}/${year}
            fi

            if [ -d "${to_dir}/${device}/${year}/${month}" ]; then
                echo "${to_dir}/${device}/${year}/${month} exists."
            else
                mkdir ${to_dir}/${device}/${year}/${month}
            fi
            echo ""
            
            echo "Copying $image to ${to_dir}/${device}/${year}/${month}/DAY${day}-${image}"
            cp $image ${to_dir}/${device}/${year}/${month}/DAY${day}-${image}
        fi
        echo "--------------------------"
    done
done

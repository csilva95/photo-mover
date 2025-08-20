# photo-mover

DESCRIPTION:
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
Easily move your photos from your camera to a different storage device! (linux environment only) <br/>
This script will use the photos metadata to organize your photos by year, month, and date when transferring to your storage device. <br/>
Expect a folder structure like this: <br/>
  /my <br/>
    /usb <br/>
      /drive <br/>
        /iphone <br/>
          /2025 <br/>
            /01-jan <br/>
              /DAY01-IMG_1234.JPG <br/>
              ... <br/>
              /DAY31-IMG_5678.JPG <br/>
            /02-feb <br/>
            ... <br/>
            /12-dec <br/>
<br/>
<br/>
DEPENDENCIES:
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
  For everyone: <br/>
    exiftool     (https://www.geeksforgeeks.org/linux-unix/installing-and-using-exiftool-on-linux/) <br/>
  <br/>
  For iphone users: <br/>
    idevicepair  (sudo apt-get install libimobiledevice-utils) <br/>
    ifuse        (https://github.com/libimobiledevice/ifuse) <br/>
<br/>
<br/>
INSTRUCTIONS:
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
Download the photo-mover.sh script <br/>
<br/>
Run script example: <br/>
  ./photo-mover.sh -f '~/iphone/DCIM' -t '/my/usb/drive' -d iphone -r 1 -u 0 <br/>
<br/>
Script input arguments: <br/>
  -f FROM folder (where the photos are coming from) <br/>
      if iphone then you *MUST* type: '~/iphone/DCIM' <br/>
      THIS FIELD IS NECESSARY <br/>
  -t TO folder   (where the photos will go) <br/>
      if you've ran this script before then name the folder the same name as you originally used so the photos are transferred to the same place <br/>
      THIS FIELD IS NECESSARY <br/>
  -d DEVICE      (device with original FROM folder) <br/>
      if iphone then you *MUST* type: iphone <br/>
      THIS FIELD IS NECESSARY <br/>
  -r REVERSE     (default=1) <br/>
      1=transfer newest photos first <br/>
      0=transfer oldest photos first <br/>
      THIS FIELD IS *NOT* NECESSARY <br/>
  -u UPDATE      (default=1) <br/>
      1=script ends once it reaches a photo it's already transferred before <br/>
      0=script will end once it attempts to transfer all photos <br/>
      THIS FIELD IS *NOT* NECESSARY <br/>
<br/>
If you ever forget then you can always run: <br/>
  ./photo-mover.sh -h <br/>

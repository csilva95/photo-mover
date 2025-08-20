# photo-mover

DESCRIPTION:
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
Easily move your photos from your camera to a different storage device! (linux environment only) <br/>
This script will use the photos metadata to organize your photos by year, month, and date when transferring to your storage device.
Expect a folder structure like this:
  /my
    /usb
      /drive
        /iphone
          /2025
            /01-jan
              /DAY01-IMG_1234.JPG
              ...
              /DAY31-IMG_5678.JPG
            /02-feb
            ...
            /12-dec


DEPENDENCIES:
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
  For everyone:
    exiftool     (https://www.geeksforgeeks.org/linux-unix/installing-and-using-exiftool-on-linux/)
  
  For iphone users:
    idevicepair  (sudo apt-get install libimobiledevice-utils)
    ifuse        (https://github.com/libimobiledevice/ifuse)

INSTRUCTIONS:
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
Download the photo-mover.sh script

Run script example: 
  ./photo-mover.sh -f '~/iphone/DCIM' -t '/my/usb/drive' -d iphone -r 1 -u 0

Script input arguments:
  -f FROM folder (where the photos are coming from)
      if iphone then you *MUST* type: '~/iphone/DCIM'
      THIS FIELD IS NECESSARY
  -t TO folder   (where the photos will go)
      if you've ran this script before then name the folder the same name as you originally used so the photos are transferred to the same place
      THIS FIELD IS NECESSARY
  -d DEVICE      (device with original FROM folder)
      if iphone then you *MUST* type: iphone
      THIS FIELD IS NECESSARY
  -r REVERSE     (default=1)
      1=transfer newest photos first
      0=transfer oldest photos first
      THIS FIELD IS *NOT* NECESSARY
  -u UPDATE      (default=1)
      1=script ends once it reaches a photo it's already transferred before
      0=script will end once it attempts to transfer all photos
      THIS FIELD IS *NOT* NECESSARY

If you ever forget then you can always run:
  ./photo-mover.sh -h

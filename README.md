# photo-mover

DESCRIPTION:
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
Easily move your photos from your camera (WORKS WITH IPHONE) to a different storage device! 

This script will use the photos metadata to organize your photos by year, month, and date when transferring to your storage device. (linux environment only)

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


Run script examples: 
    
    ./photo-mover.sh -f '~/iphone/DCIM' -t '/my/usb/drive' -d iphone
    ./photo-mover.sh -f '/my/camera/DCIM' -t '/my/usb/drive' -d a7c -r 0 -u 0

Script input arguments: 

    -f FROM folder (THIS FIELD IS NECESSARY) 
        path of the camera photos
        if iphone then you *MUST* type: '~/iphone/DCIM' 
        
      
    -t TO folder   (THIS FIELD IS NECESSARY) 
        path of the storage device
      
    -d DEVICE      (THIS FIELD IS NECESSARY) 
        if iphone then you *MUST* type: iphone
        if you've ran this script before then:
                name the device the same name as you originally used so the photos are transferred to the same place
      
    -r REVERSE     (THIS FIELD IS *NOT* NECESSARY) 
        default=1
        1=transfer newest photos first 
        0=transfer oldest photos first 
        
      
    -u UPDATE      (THIS FIELD IS *NOT* NECESSARY) 
        default=1
        1=script ends once it reaches a photo it's already transferred before
        0=script will end once it attempts to transfer all photos

If you ever forget then you can always run:

    ./photo-mover.sh -h 

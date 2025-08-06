#! /bin/sh

if [ "$#" -lt 1 ]
    then echo ' '
         echo " -------------------------------------------------------------"
         echo "  deblank: Turns multiple blank lines into single blank lines"
         echo " -------------------------------------------------------------"
         echo ' '
         echo " Needed a filename (and only one filename) to convert!"
         echo " If more than one filename is given, the second and" 
         echo " succeeding files will be ignored. (You may, however, redirect" 
         echo " the output to a file)."
         echo ' '
         echo "     Usage:"
         echo "           deblank [filename]"
         echo ' '
    exit 1

fi

if perl -ne 'exit 1 if /[^\x00-\x7F]/' "$1"
  then 
  sed '/^$/{ 
	N 
	/^\n$/D 
      }' $1
else
         echo ' '
         echo " -------------------------------------------------------------"
         echo "  deblank: Turns multiple blank lines into single blank lines"
         echo " -------------------------------------------------------------"
         echo ' '
         echo " But it only works on ASCII text files! (Deblank thinks the"
         echo " filename you gave it is a binary file)."
         echo ' '
    exit 1
fi

#Katie O'Mahony
#@aforestsomewhere
#07/04/2024
#Double check all .pod5 (or other format of choice) files were transferred correctly

#On local disk containing the files, obtain list of the files. 
#If command prompt is available, happy days!
#Otherwise e.g. on Windows 10, select all, and "copy path"
#Navigate to the HPC folder where you have (hopefully) copied all files
emacs file_list.txt
#Paste these paths to a text editor and save
#Remove trailing path
sed -i 's#E:\\project_folder\\pod5\\##g' file_list.txt
#Also remove errant quotes
sed -i 's/"//g' file_list.txt
#Finally cross reference with files in current dir
grep -vxFf <(ls) file_list.txt

#If any files are missing, they will be written to stdout

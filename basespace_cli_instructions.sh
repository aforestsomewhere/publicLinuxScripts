# Instructions for BaseSpace CLI
# Authors: Original scripting by Messr. W. Barton, adapted and updated by Katie O'Mahony
# Tested and working 09/12/24
# The BaseSpace CLI is a tool from Illumina that lets you interact with data and projects on the BaseSpace Sequence Hub using the command line.
# 0. Create an account: https://my.illumina.com/welcome. You can then accept the invitation from the sequencing platform to association the sequencing project to your account

# 1. Install It
# #Illumina maintain binaries of the BaseSpace CLI, which you will need to download
# First set the variable var_BS to the location you desire for the BaseSpace binary
var_BS=/path/to/my_software_folder/bs
#Local install of newest version, -O = software location
wget "https://launch.basespace.illumina.com/CLI/latest/amd64-linux/bs" -O $var_BS
chmod u+x $var_BS

# 2. Log In
# Before running any commands that need access to BaseSpace, you’ll need to log in and generate a validated config for the relevant api server.
$var_BS auth -c us_server --api-server https://api.basespace.illumina.com
#This will open a browser window: log into your BaseSpace account and give the CLI permission to access your gear (i.e. projects).

# 3. Load relevant config. Let's use the US one (it should have been generated to the users' home folder/.basespace by the previous command:
eval $( $var_BS load config us_server )

# 4. See Your Projects
# To get a list of all your projects, run:
$var_BS list project
# You should see something along the lines of the below printed to the terminal:
#+----------------------------+-----------+--------------+
#|            Name            |    Id     |  TotalSize   |
#+----------------------------+-----------+--------------+
#| myrun1                     | 412345678 | million      |
#| myrun2                     | 423456789 | billion      |
#| myrun3                     | 434567890 | trillion     |
#+----------------------------+-----------+--------------+
# Note the ProjectID number in the "Id" column - we will use this to download the data for the relevant sequencing run

# 5. Check Samples in a Project
# To see all the samples in a specific project, use:
$var_BS list project -p [ProjectID]

#5. Download Data
#To download all basecalled data for a ProjectID to the desired path, first set the path variable then execute:
var_dir_DL=/path/to/my_analysis_directory/myrun1
mkdir -p $var_dir_DL
$var_BS download project -i 412345678 -o $var_dir_DL

#6. Uploading data
var_dir_UL=/path/to/my_analysis_directory/myrun2
$var_BS upload run -n 20241202_myrun2 -t NovaSeq6000 $var_dir_UL

# 7. Troubleshooting
# If you successfully auth your account and can see the sequencing projects in the BaseSpace webbrowser, but they do not appear when using the bs list project command, you may be auth'd to a different server. 
# As of Dec 24 the us_server is the relevant one. However, this could change in the future. To check the current server:
$var_BS whoami
# To auth to the EU server (adding --force to overwrite existing config):
$var_BS auth -c eu_server --api-server https://api.euc1.sh.basespace.illumina.com --force
# For details on additional Illumina servers see: https://knowledge.illumina.com/software/cloud-software/software-cloud-software-reference_material-list/000005560

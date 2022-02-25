# DemOn_Autouploader

This coding pipeline develops upon and would not have been possible without BTO_data_upload developed by Joel Pick which can be found here: https://github.com/joelpick/BTO_data_upload?fbclid=IwAR3so_8G5g8XHb6WCYA-XsazCs6wioFH9jNaOA6AudX0VYLthRKd4Bi3RCI

This code allows for bulk upload of ringing records to the BTO DemOn database. As Joel states for his pipeline, I can give no guarantee that this will faithfully or successfully upload records.
This version builds upon Joel's version by expanding the available fields for data entry, incorporating efficiency changes which should speed up upload of large datasets, and has a new function specifically aimed at upload of sightings.

Whilst this method requires significant set-up, once the system is in place data entry can automated and save significant time.

## Getting started instructions

You will need a few programs installed:
1. R (https://www.r-project.org/)
2. RStudio (https://www.rstudio.com/products/rstudio/download/#download)
3. Docker (https://www.docker.com/products/docker-desktop)

Once all are installed on your system, make sure Docker is open and running. You will not have to do anything inside Docker itself.

Download the folder of files here onto your system - click the green ```Code``` drop down menu then select ```Download ZIP```. Then unzip this folder.

Open up ```RStudio``` (you never have to open R itself but needs to be installed) and then open up the ```DemOn_Autouploader.R``` file into RStudio (file -> Open File...). Then set your working directory to the folder you downloaded from GitHub (Session -> Set Working Directory -> Choose Directory...)

In the bottom left of ```RStudio``` go to the ```Terminal``` tab. In the terminal run the following (it will ask you for a password, when you type it in nothing will appear in the terminal but this is expected - it is just hidden. Enter your computer password and hit enter.):

To get latest version of Firefox into docker:
```sudo docker pull selenium/standalone-firefox```

Open a port for RSelenium:
```sudo docker run -d -p 4445:4444 selenium/standalone-firefox```

Then run the R code in ```DemOn Autouploader.R```. This file has further detailed explanations on usage. It should take 6-7 seconds per record, but likely not all records will be imported on first try.

NOTE: Data needs to be in a strict format - see attached csv files. Formatting of tiem and date data is the most likely cause for issues and must strictly follow the format you see in the attached CSV files. Times need to be formatted as 08:45 and date as 28/05/2018. Order you have your columns within your CSV upload file is not important but DO NOT change column headings. You must also code your data as you would enter it into DemOn (e.g. fat score B0 not  just 0, Location must precisely match how it is on DemOn entry, etc.)

## Routine running instructions

Make sure you have ```Docker``` up and running.

Open up ```RStudio```, set your working directory to the folder containing the ```DemOn_Autouploader_functions.R``` file. 

Open up the ```DemOn_Autouploader.R``` file. 

In RStudio run the following code in the Terminal (if Docker is still running from a previous run of the Auto uploader then you don't need to re-run these terminal commands):

To get latest version of Firefox into docker:
```sudo docker pull selenium/standalone-firefox```

Open a port for RSelenium:
```sudo docker run -d -p 4445:4444 selenium/standalone-firefox```

Run the R code in ```DemOn_Autouploader.R```.

## Troubleshooting

#### BTO_webpage() is returning Error in .self$value[[1]] : subscript out of bounds 

Go into ```Docker``` and stop the running container and then delete it. Then start from fresh in the Terminal tab of ```Rstudio``` with:
```sudo docker pull selenium/standalone-firefox```

And then run:
```sudo docker run -d -p 4445:4444 selenium/standalone-firefox```

Now go back into ```DemOn_Autouploader.R``` and run the script.


#### I want data entry columns that aren't included in the data templates

Gett in contact with me and I can get these lesser used data entry columns added for you into the template.

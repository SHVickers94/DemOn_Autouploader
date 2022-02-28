# DemOn_Autouploader

This coding pipeline develops upon and would not have been possible without ```BTO_data_upload``` developed by Joel Pick, which can be found here: https://github.com/joelpick/BTO_data_upload?fbclid=IwAR3so_8G5g8XHb6WCYA-XsazCs6wioFH9jNaOA6AudX0VYLthRKd4Bi3RCI

This code allows for bulk upload of ringing records to the BTO DemOn database. As Joel states for his pipeline, I can give no guarantee that this will faithfully or successfully upload records.
This version builds upon Joel's version by expanding the available fields for data entry, some small efficiency changes which should speed up upload of large datasets, and has a new function specifically aimed at upload of sightings.

Whilst this method requires significant set-up, once the system is in place data entry can be automated and save significant time.

## Getting started instructions

A video guide to using the system for Mac users can be found here: https://youtu.be/xbWlgE5vwv8. Please also read this document.

You will need a few programs installed:
1. R (https://www.r-project.org/)
2. RStudio (https://www.rstudio.com/products/rstudio/download/#download)
3. Docker (https://www.docker.com/products/docker-desktop)

Please note: ```Docker``` installation on Windows PC is more complex. Please follow this guide: https://docs.docker.com/desktop/windows/install/ and follow the instructions for ```WSL 2 backend```.

Once all are installed on your system, make sure Docker is open and running. You will not have to do anything inside ```Docker``` itself.

Download the folder of files here onto your system - click the green ```Code``` drop down menu then select ```Download ZIP```. Then unzip this folder.

Open up ```RStudio``` (you never have to open ```R``` itself but it needs to be installed) and then open up the ```DemOn_Autouploader.R``` file into RStudio (file -> Open File...). Then set your working directory to the folder you downloaded from GitHub (Session -> Set Working Directory -> Choose Directory...)

In the bottom left of ```RStudio``` go to the ```Terminal``` tab. In the terminal run the following (it will ask you for a password, when you type it in nothing will appear in the terminal but this is expected - it is just hidden. Enter your system password and hit enter):

Please note: Windows PC users do not need the 'sudo' prefix to these commands.

1. To get latest version of Firefox into docker:
```sudo docker pull selenium/standalone-firefox```

2. Open a port for RSelenium:
```sudo docker run -d -p 4445:4444 selenium/standalone-firefox```

Then in the console tab run the R code in ```DemOn Autouploader.R```. This file has further detailed explanations on usage. It should take 6-7 seconds per record, but likely not all records will be imported on first try.

NOTE: Data needs to be in a strict format - see attached csv files. Formatting of time and date data is the most likely cause for issues and must strictly follow the format you see in the attached CSV files. Times need to be formatted as 08:45 and date as 28/05/2018. The order you have your columns within your CSV upload file is not important but DO NOT change column headings. You must also code your data as you would enter it into DemOn (e.g. fat score B0 not just 0, Location must precisely match how it is on DemOn entry, etc.)

## Routine running instructions

1. Make sure you have ```Docker``` up and running.

2. Open up ```RStudio```, set your working directory to the folder containing the ```DemOn_Autouploader_functions.R``` file. 

3. Open up the ```DemOn_Autouploader.R``` file. 

4. In ```RStudio``` run the following code in the Terminal:

Please note: Windows PC users do not need the 'sudo' prefix to these commands.

    To get latest version of Firefox into docker:
    ```sudo docker pull selenium/standalone-firefox```

    Open a port for RSelenium:
    ```sudo docker run -d -p 4445:4444 selenium/standalone-firefox```

5. Run the R code in ```DemOn_Autouploader.R```.

## Troubleshooting

### - This is all way too complicated for me

This is a (hopefully) short-term solution to the lack of batch upload on DemOn. Eventually this process will be obsolete. Until then, IPMR still allows batch uypload or the following video may help walk you through the process: https://youtu.be/xbWlgE5vwv8

### - BTO_webpage() is returning 'Error in .self$value[[1]] : subscript out of bounds'

Go into ```Docker``` and stop the running container and then delete it. Then start from fresh in the Terminal tab of ```Rstudio``` with:
```sudo docker pull selenium/standalone-firefox```

And then run:
```sudo docker run -d -p 4445:4444 selenium/standalone-firefox```

Now go back into ```DemOn_Autouploader.R``` and run the script.

### - remDr$open() is returning 'Error in checkError(res) :Undefined error in httr call. httr output: Failed to connect to localhost port 4445: Connection refused'

Setup of ```Docker``` has failed. The best solution to this I have found is to remove the current container on Docker and obtain a new one by running ```sudo docker run -d -p 4445:4444 selenium/standalone-firefox``` in the Terminal. Then re-run ```DemOn_Autouploader.R```.

### - remDr$open() is returning 'Error in checkError(res) : Undefined error in httr call. httr output: Empty reply from server'

This tends to happen to me when my connection has timed out overnight or between sesssions. Starting a new container on ```Docker``` and running the ```Terminal``` commands sometimes doesn't fix the issue. In this scenario I restart ```RStudio```, delete the current container on ```Docker```, and start fresh.

### - I want data entry columns that aren't included in the data templates

Get in contact with me and I can get these lesser-used data entry columns added for you into the template.

### - None of my submitted records are appearing on DemOn

The most likely causes for this are missing required data that DemOn needs to submit, your data throwing warning or error messages in DemOn (e.g. a wing length otuside of what is expected), and faulty formatting of date or time data across your dataset. Make sure to double check your data and follow the template document formats precisely.

### - I'm using a PC (rather than a Mac) and I can't get this to work

I developed my code on a Mac, as did Joel. This code is untested on PC and may be a platofrm specific issue. Get in touch and I can try to fix it.

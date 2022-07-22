# DemOn Autouploader R scripts.

# Run lines of code by clicking on the line you want to run and then pressing run

rm(list=ls()) # clear the environment

# Instal RSeleniumk if you don't have it, otherwise just load library
if(!require('RSelenium'))install.packages('RSelenium');library(RSelenium)

# Set working directory for where R code and data are. Can be done in code or by Session menu at top
# setwd("...") 

# Import data to upload
BTO_data <- read.csv(file.choose()) # upload your .csv file of data to be uploaded
nrow(BTO_data) # check dataset is as expected
head(BTO_data)
BTO_data[BTO_data==""]<-NA # Replace missing data with NAs

# Import functions to interact with BTO webpage 
source("DemOn_Autouploader_functions.R")

# Start remote driver - this is starting a remote web browser in the background. 
remDr <- remoteDriver(remoteServerAddr = 'localhost', port = 4445L, browserName = 'firefox')

remDr$open() # This may be very slow - wait until red stop sign in top right of console is gone and '>' has appeared in bottom left. 

# Open BTO webpage - an image of this will be shown in bottom right. If the image does not appear, re-run remRd$open()
BTO_webpage()

# Log in with your username and password - replace the ... but retain inverted commas
USERNAME <- 'USERNAME' # Replace with yours
PASSWORD <- 'PASSWORD' # Replace with yours
BTO_login(username = USERNAME, password = PASSWORD)

# Navigate to ringing entry page (will take a few seconds). An image will appear in bottom right
BTO_ringing_page()

# The three steps above can be done with a single function, but username and password must be set first
USERNAME <- 'USERNAME' # Replace with yours
PASSWORD <- 'PASSWORD' # Replace with yours
BTO_complete()

# At any time, you can refresh the current page with:
Refresh_page()

# Start upload of all data - counter of records submitted will tcik, up but thsis DOES NOT mean those records have been successfully uplaoded. By default an image will appear after each record is submitted. Hopefully you will see 'Record Saved!', but you may see warning or error messages in DemOn where they require comments - these records will not be submitted and will be skipped. You need to correct data mistakes and re-submit records here, or enter these manually on DemOn.
# If you don't want thes eimages appearing for each record, set 'display=F'

# To upload ringing and retrap records (record type N or S) use:
# Please note: entry of records that are not record type N or S are NOT supported here
BTO_ringing_upload(BTO_data, rowStart = 1, display=T)

# To upload sightings use:
# Please note: only record type F works here
BTO_sightings_upload(BTO_data, rowStart = 1, display=T)


# On large data entry submissions, Docker and your connection may drop or time out and you will get an error here. If that happens, re-establish your connection and re-start your submission from the point it failed - to do this set 'startRow = ' to the record number that failed. Records up to that point should be on DemOn.


# Check whether what has been imported matches the records we tried to import
### Manually log into website, go to 'Explore Data' Menu, chose 'Ringing', then search for the period of ringing, and then select to export all data. This will save a csv to the downloads folder

## import saved file (whatever you've called it)
imported <- read.csv(file.choose())

# Ensure dates are formatted identically. Previous issue here with 01/1/2022 not matching 01/01/2022
original <- BTO_data
original$Visit_Date <- as.POSIXct(original$Visit_Date, format='%d/%m/%y')
imported$visit_date <- as.POSIXct(imported$visit_date, format='%d/%m/%y')

## list of not-imported records
imported_list <- with(imported, paste(ring_no, visit_date, capture_time))
BTO_data_list <- with(original, paste(Ring_No, Visit_Date, Capture_Time))

## dataframe of not-imported records
BTO_data2 <- BTO_data[!BTO_data_list %in% imported_list,]
paste(BTO_data[!BTO_data_list %in% imported_list, "Ring_No"],collapse=",")
nrow(BTO_data2)

# Tidyr version

bto_demon <- read.csv(file.choose()) 

BTO_data <- BTO_data %>% mutate(Capture_Time = case_when(Capture_Time == '' ~ '00:00',
                                                         TRUE ~ Capture_Time))

bto_demon2 <- bto_demon %>% unite('record', c(ring_no, visit_date, capture_time), remove = F, sep='_')
bto_submit2 <- BTO_data %>% unite('record', c(Ring_No, Visit_Date, Capture_Time), remove = F, sep='_')

submitted <- bto_submit2 %>% filter(record %in% bto_demon2$record)
notsubmitted <- bto_submit2 %>% filter(!record %in% bto_demon2$record)

## check still logged on. - otherwise use functions above to log back in
remDr$screenshot(display = TRUE)

## upload missing records
BTO_ringing_upload(BTO_data2, rowStart = 1, display=T)

BTO_sightings_upload(BTO_data2, rowStart = 1, display=T)

remDr$screenshot(display = TRUE)

## repeat this process until all are uploaded!!!!
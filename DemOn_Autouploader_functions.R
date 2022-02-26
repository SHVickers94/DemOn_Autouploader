BTO_webpage <- function(){
  ## go to BTO DemOn login page
  remDr$navigate("https://app.bto.org/demography/bto/public/login.jsp")
  
  ## brings up screenshot of the webpage so you can check whats going on
  remDr$screenshot(display = TRUE)
}

BTO_login <- function(username,password){
  # enter username and password and login
  # first you have to find the CSS of the box (I used selectorgadget in chrome), then enter text into it
  username_box <- remDr$findElement(using = 'css selector', "#username")
  username_box$sendKeysToElement(list(username))
  
  password_box <- remDr$findElement(using = 'css selector', "#password")
  password_box$sendKeysToElement(list(password))
  
  ## find login button and click it
  login_button <- remDr$findElement(using = 'css selector', ".btn-block")
  login_button$clickElement()
  
  remDr$screenshot(display = TRUE)
}

BTO_ringing_page <- function(){
  ## navigate to enter ringing data
  ringing_button <- remDr$findElement(using = 'css selector', ".buttonReportRate")
  ringing_button$clickElement()
  
  Sys.sleep(2)
  
  Settings  <- remDr$findElement(using = 'css selector', ".col-md-1 .pull-right")
  Settings$clickElement()
  Field_Setup  <- remDr$findElement(using = 'css selector', ".col-sm-8:nth-child(2) .form-control option[value='2675']")
  Field_Setup$clickElement()
  
  Sys.sleep(1)
  
  BTO_webpage()
  ringing_button <- remDr$findElement(using = 'css selector', ".buttonReportRate")
  ringing_button$clickElement()

  # pause R 
  Sys.sleep(2)
  remDr$screenshot(display = TRUE)
}

BTO_ringing_upload <- function(data, display=FALSE){
  for(i in 1:nrow(data)){
    remDr$refresh()
    Sys.sleep(2)
    if(display) remDr$screenshot(display = TRUE)
    
    # define box and enter data into it
    Record_type_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(3) .dataInput")
    Record_type_box$sendKeysToElement(list(data$Record_Type[i]))
    
    Ring_no_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(4) .dataInput")
    Ring_no_box$clearElement()
    Ring_no_box$sendKeysToElement(list(data$Ring_No[i]))
    
    ## this is a way of choosing from a dropdown list - use 'option' in the CSS to indicate the value and then 'click' it
    Scheme_box  <- remDr$findElement(using = 'css selector', paste0(".chosenFieldSetup:nth-child(5) .dataInput option[value='",data$Scheme[i],"']"))
    Scheme_box$clickElement()
    
    
    Species_box  <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(8) .ui-autocomplete-input")
    Species_box$clearElement()
    Species_box$sendKeysToElement(list(data$Species_Name[i], key = "enter"))
    
    Age_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(9) .dataInput")
    Age_box$sendKeysToElement(list(as.character(data$Age[i])))
    
    if(!is.na(data$Pulli_Ringed[i])){
      Pulli_ringed_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(10) .dataInput")
      Pulli_ringed_box$sendKeysToElement(list(as.character(data$Pulli_Ringed[i])))
    }
    
    if(!is.na(data$Pulli_Alive[i])){
      Pulli_alive_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(11) .dataInput")
      Pulli_alive_box$sendKeysToElement(list(as.character(data$Pulli_Alive[i])))
    }
    
    Sex_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(12) .noRepeat")
    if(!is.na(data$Sex[i]))Sex_box$sendKeysToElement(list(data$Sex[i]))
    
    Sexing_method_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(13) .noRepeat")
    if(!is.na(data$Sexing_Method[i]))Sexing_method_box$sendKeysToElement(list(data$Sexing_Method[i]))
    
  
    Moult_Code_box  <- remDr$findElement(using = 'css selector', paste0(".chosenFieldSetup:nth-child(30) .dataInput option[value='",data$Moult_Code[i],"']"))
    Moult_Code_box$clickElement()
    
    Breeding_condition_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(15) .noRepeat")
    if(!is.na(data$Breeding_Condition[i]))Breeding_condition_box$sendKeysToElement(list(data$Breeding_Condition[i]))
    
    Visit_date_box <- remDr$findElement(using = 'css selector', ".hasDatepicker")
    Visit_date_box$clickElement()
    Visit_date_box$clearElement()
    Visit_date_box$sendKeysToElement(list(data$Visit_Date[i]))
    
    
    Capture_time_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(17) .dataInput")
    Capture_time_box$clickElement()
    if(!is.na(data$Capture_Time[i]))Capture_time_box$sendKeysToElement(list(data$Capture_Time[i], key = "enter"))
    
    Time_Measured_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(28) .dataInput")
    Time_Measured_box$clickElement()
    if(!is.na(data$Time_Measured[i]))Time_Measured_box$sendKeysToElement(list(data$Time_Measured[i], key = "enter"))
    
    
    if(!is.na(data$Alula[i]))Alula_box  <- remDr$findElement(using = 'css selector', paste0(".chosenFieldSetup:nth-child(31) .dataInput option[value='",data$Alula[i],"']"))
    if(!is.na(data$Alula[i]))Alula_box$clickElement()
    
    
    Old_Greater_Coverts_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(32) .noRepeat")
    if(!is.na(data$Old_Greater_Coverts[i]))Old_Greater_Coverts_box$sendKeysToElement(list(data$Old_Greater_Coverts[i]))
    
    Primary_Moult_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(33) .noRepeat")
    if(!is.na(data$Primary_Moult[i]))Primary_Moult_box$sendKeysToElement(list(data$Primary_Moult[i]))
    
    Location_box1 <- remDr$findElement(using = 'css selector', ".select2-default")
    Location_box1$clickElement()
    
    Location_box2 <- remDr$findElement(using = 'css selector', "#s2id_autogen8_search")
    Location_box2$sendKeysToElement(list(data$Location[i], key = "enter"))
    
    ##	only enter Wing length is record is not NA
    Wing_length_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(25) .noRepeat")
    Wing_length_box$clearElement()
    if(!is.na(data$Wing_Length[i])) Wing_length_box$sendKeysToElement(list(as.character(data$Wing_Length[i])))
    
    ##	only enter Weight is record is not NA, also round to 1d.p. as instructed
    Weight_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(26) .noRepeat")
    Weight_box$clearElement()
    if(!is.na(data$Weight[i]))	Weight_box$sendKeysToElement(list(as.character(round(data$Weight[i],1))))
    
    Fat_box  <- remDr$findElement(using = 'css selector', paste0(".chosenFieldSetup:nth-child(47) .dataInput option[value='",data$Fat[i],"']"))
    Fat_box$clickElement()
    
    Pectoral_Muscle_box  <- remDr$findElement(using = 'css selector', paste0(".chosenFieldSetup:nth-child(48) .dataInput option[value='",data$Pectoral_Muscle[i],"']"))
    Pectoral_Muscle_box$clickElement()
    
    Capture_method_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(38) .dataInput")
    Capture_method_box$sendKeysToElement(list(data$Capture_Method[i]))
    
    if(data$Record_Type[i]=="N"){
      Ringer_initials_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(40) .ui-autocomplete-input")
      Ringer_initials_box$clearElement()
      Ringer_initials_box$sendKeysToElement(list(data$Ringer_Initials[i]))
    }
    
    Processor_initials_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(42) .ui-autocomplete-input")
    Processor_initials_box$clearElement()
    if(!is.na(data$Processor_Initials[i]))Processor_initials_box$sendKeysToElement(list(data$Processor_Initials[i]))
    
    Colour_mark_info_box <- remDr$findElement(using = 'css selector', "td:nth-child(45) .dataInput")
    if(!is.na(data$Colour_Mark_Info[i]))Colour_mark_info_box$sendKeysToElement(list(data$Colour_Mark_Info[i]))
    
    Left_Leg_Below_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(76) .dataInput")
    Left_Leg_Below_box$clearElement()
    if(!is.na(data$Left_Leg_Below[i]))Left_Leg_Below_box$sendKeysToElement(list(data$Left_Leg_Below[i]))
    
    Right_Leg_Below_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(77) .dataInput")
    Right_Leg_Below_box$clearElement()
    if(!is.na(data$Right_Leg_Below[i]))Right_Leg_Below_box$sendKeysToElement(list(data$Right_Leg_Below[i]))
    
    Left_Leg_Above_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(78) .dataInput")
    Left_Leg_Above_box$clearElement()
    if(!is.na(data$Left_Leg_Above[i]))Left_Leg_Above_box$sendKeysToElement(list(data$Left_Leg_Above[i]))
    
    Right_Leg_Above_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(79) .dataInput")
    Right_Leg_Above_box$clearElement()
    if(!is.na(data$Right_Leg_Above[i]))Right_Leg_Above_box$sendKeysToElement(list(data$Right_Leg_Above[i]))
    
    Neck_Collar_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(80) .dataInput")
    Neck_Collar_box$clearElement()
    if(!is.na(data$Neck_Collar[i]))Neck_Collar_box$sendKeysToElement(list(data$Neck_Collar[i]))
    
    Left_Wing_Tag_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(81) .dataInput")
    Left_Wing_Tag_box$clearElement()
    if(!is.na(data$Left_Wing_Tag[i]))Left_Wing_Tag_box$sendKeysToElement(list(data$Left_Wing_Tag[i]))
    
    Right_Wing_Tag_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(82) .dataInput")
    Right_Wing_Tag_box$clearElement()
    if(!is.na(data$Right_Wing_Tag[i]))Right_Wing_Tag_box$sendKeysToElement(list(data$Right_Wing_Tag[i]))
    
    Nasal_Saddle_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(83) .dataInput")
    Nasal_Saddle_box$clearElement()
    if(!is.na(data$Nasal_Saddle[i]))Nasal_Saddle_box$sendKeysToElement(list(data$Nasal_Saddle[i]))
    
    save_button <- remDr$findElement(using = 'css selector', ".col-xs-12:nth-child(2) .btn-primary") 
    save_button$clickElement()
    
    Sys.sleep(2)
    if(display) remDr$screenshot(display = TRUE)		
    
    message('\r',paste0(i, ' records submitted. ',round(i/nrow(data)*100,2),'% complete      '), appendLF = F)
      
  }
}

BTO_sightings_upload <- function(data, display=FALSE){
  for(i in 1:nrow(data)){
    remDr$refresh()
    Sys.sleep(2)
    if(display) remDr$screenshot(display = TRUE)
    
    data$Record_Type <- 'F'

    # define box and enter data into it
    Record_type_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(3) .dataInput")
    Record_type_box$sendKeysToElement(list(as.character(data$Record_Type)[i]))
    
    Ring_no_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(4) .dataInput")
    Ring_no_box$clearElement()
    Ring_no_box$sendKeysToElement(list(data$Ring_No[i]))
    
    ## this is a way of choosing from a dropdown list - use 'option' in the CSS to indicate the value and then 'click' it
    Scheme_box  <- remDr$findElement(using = 'css selector', paste0(".chosenFieldSetup:nth-child(5) .dataInput option[value='",data$Scheme[i],"']"))
    Scheme_box$clickElement()
    
    Species_box  <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(8) .ui-autocomplete-input")
    Species_box$clearElement()
    Species_box$sendKeysToElement(list(data$Species_Name[i], key = "enter"))
    
    Age_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(9) .dataInput")
    Age_box$sendKeysToElement(list(as.character(data$Age[i])))
    
    Sex_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(12) .noRepeat")
    if(!is.na(data$Sex[i]))Sex_box$sendKeysToElement(list(data$Sex[i]))
    
    Sexing_method_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(13) .noRepeat")
    if(!is.na(data$Sexing_Method[i]))Sexing_method_box$sendKeysToElement(list(data$Sexing_Method[i]))
    
    Visit_date_box <- remDr$findElement(using = 'css selector', ".hasDatepicker")
    Visit_date_box$clickElement()
    Visit_date_box$clearElement()
    Visit_date_box$sendKeysToElement(list(data$Visit_Date[i]))
    
    
    Capture_time_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(17) .dataInput")
    Capture_time_box$clickElement()
    Capture_time_box$sendKeysToElement(list(data$Capture_Time[i], key = "enter"))
    
    Location_box1 <- remDr$findElement(using = 'css selector', ".select2-default")
    Location_box1$clickElement()
    
    Location_box2 <- remDr$findElement(using = 'css selector', "#s2id_autogen8_search")
    Location_box2$sendKeysToElement(list(data$Location[i], key = "enter"))
    
    
    ## this is a way of choosing from a dropdown list - use 'option' in the CSS to indicate the value and then 'click' it
    Finding_Condition_box  <- remDr$findElement(using = 'css selector', paste0(".chosenFieldSetup:nth-child(36) .dataInput option[value='",data$Finding_Condition[i],"']"))
    Finding_Condition_box$clickElement()
    
    Finding_Circumstances_box  <- remDr$findElement(using = 'css selector', paste0(".chosenFieldSetup:nth-child(37) .dataInput option[value='",data$Finding_Circumstances[i],"']"))
    Finding_Circumstances_box$clickElement()
    

    
    Processor_initials_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(42) .ui-autocomplete-input")
    Processor_initials_box$clearElement()
    if(!is.na(data$Processor_Initials[i]))Processor_initials_box$sendKeysToElement(list(data$Processor_Initials[i]))
    
    
    
    Extra_Text_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(74) .dataInput")
    Extra_Text_box$clearElement()
    if(!is.na(data$Extra_Text[i]))Extra_Text_box$sendKeysToElement(list(data$Extra_Text[i]))
    
    
    Left_Leg_Below_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(76) .dataInput")
    Left_Leg_Below_box$clearElement()
    if(!is.na(data$Left_Leg_Below[i]))Left_Leg_Below_box$sendKeysToElement(list(data$Left_Leg_Below[i]))
    
    Right_Leg_Below_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(77) .dataInput")
    Right_Leg_Below_box$clearElement()
    if(!is.na(data$Right_Leg_Below[i]))Right_Leg_Below_box$sendKeysToElement(list(data$Right_Leg_Below[i]))
    
    Left_Leg_Above_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(78) .dataInput")
    Left_Leg_Above_box$clearElement()
    if(!is.na(data$Left_Leg_Above[i]))Left_Leg_Above_box$sendKeysToElement(list(data$Left_Leg_Above[i]))
    
    
    Right_Leg_Above_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(79) .dataInput")
    Right_Leg_Above_box$clearElement()
    if(!is.na(data$Right_Leg_Above[i]))Right_Leg_Above_box$sendKeysToElement(list(data$Right_Leg_Above[i]))
    
    Neck_Collar_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(80) .dataInput")
    Neck_Collar_box$clearElement()
    if(!is.na(data$Neck_Collar[i]))Neck_Collar_box$sendKeysToElement(list(data$Neck_Collar[i]))
    
    Left_Wing_Tag_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(81) .dataInput")
    Left_Wing_Tag_box$clearElement()
    if(!is.na(data$Left_Wing_Tag[i]))Left_Wing_Tag_box$sendKeysToElement(list(data$Left_Wing_Tag[i]))
    
    Right_Wing_Tag_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(82) .dataInput")
    Right_Wing_Tag_box$clearElement()
    if(!is.na(data$Right_Wing_Tag[i]))Right_Wing_Tag_box$sendKeysToElement(list(data$Right_Wing_Tag[i]))
    
    Nasal_Saddle_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(83) .dataInput")
    Nasal_Saddle_box$clearElement()
    if(!is.na(data$Nasal_Saddle[i]))Nasal_Saddle_box$sendKeysToElement(list(data$Nasal_Saddle[i]))
    
    Finder_Name_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(86) .dataInput")
    Finder_Name_box$clearElement()
    if(!is.na(data$Finder_Name[i]))Finder_Name_box$sendKeysToElement(list(data$Finder_Name[i]))
    
    
    Email_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(91) .dataInput")
    Email_box$clearElement()
    if(!is.na(data$Email[i]))Email_box$sendKeysToElement(list(data$Email[i]))
    
    
    save_button <- remDr$findElement(using = 'css selector', ".col-xs-12:nth-child(2) .btn-primary") 
    save_button$clickElement()
    
    Sys.sleep(2)
    if(display) remDr$screenshot(display = TRUE)		
    message('\r',paste0(i, ' records submitted. ',round(i/nrow(data)*100,2),'% complete      '), appendLF = F)
    
  }
}

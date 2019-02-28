###############################################################################
##############                Data Management I:                 ##############
##############  Data Import, Tidying, and Wrangling (tidyverse)  ##############
##############                By: Zach Laubach                   ##############
##############             last updated: 12 Feb 2018             ##############
###############################################################################

  ### PURPOSE: This code is desingned to provide an introduction to data
  ### data management in program R. We will begin by configuring our 
  ### workspace including loading a numuber of R packages, which primarily
  ### have been developed by Hadley Wickham. Then we will import data into R 
  ### and explore the ways in which data can be cleaned, organized and
  ### manipulated. Here, and throughout we will follow the R Style Guide in 
  ### order to improve the consistency and readability of our code.

  ### This tutorial is based on online, opensource resources and follows
  ### a data management philosophy championed by Hadley Wickham.
    
    # R for Data Science, © 2017 Garrett Grolemund and Hadley Wickham


  # Code Blocks
    # 1: Configure workspace
    # 2: Importing data
    # 3: Tidy data with tidyr
    # 4: Data wrangling with dplyr
    # 5: Exporting data
    # 6: More useful R resources



###############################################################################
##############              1. Configure workspace               ##############
###############################################################################

  
  ### 1.1 R Version and Session Info
    R.Version()
    sessionInfo()
    
    # Developed in:   
    # R version 3.4.3 (2017-11-30)
    # Platform: x86_64-apple-darwin15.6.0 (64-bit)
    # Running under: macOS Sierra 10.12.4
    
  
  ### 1.2 Clear Workspace
    # start with an empty workspace / environment
    rm(list = ls())
    
  
  ### 1.3 Set working directory
      # this will tell R what folder you are using, i.e. where you are storing
      # data and where you will put your output
    
    ## a) MAC - setwd
      setwd(paste('~/Documents/teaching/courses/',
                  'data_mngmnt_analysis_for_biologist/2_R_data_manage_I',
                  sep = ''))
      
    ## b) PC - setwd
     # setwd("c:\harddrive\users\username\desktop\2_R_data_manage_I")

      
  ### 1.4 Install Packages
    ## a) dplyr is a package for data management
      install.packages('dplyr') # install package to save it locally (done once
                                # per computer)
      library(dplyr) # load package in current R session (done everytime you
                     # you start a new R session)
    
    ## b) gridExtra is a package that can be used to export tables as pdf   
      install.packages("gridExtra") 
      library(gridExtra)
      
    ## c) tidyverse is a bundle of packages useful for data managenment
      install.packages('tidyverse')
      library(tidyverse)
      

    
###############################################################################
##############                 2. Importing data                 ##############
###############################################################################

  ### 2.1 Import Data 
      # As a general rule, I would suggest storing raw data as .csv or .txt
      # files as opposed to Excel files, which has a tendency to re-format
      # variables and is version dependent.
  
    ## a) Import .csv to dataframe using base R
      tblDarting <- read.csv  ('./data/tblDarting.csv',
                             header = T)
      
      tblHyenas <- read.csv  ('./data/tblHyenas.csv',
                               header = T)
      
    ## b) Import .csv to tibble (better data frame) using readr from tidyverse
      tblDarting_tib <- read_csv  ('./data/tblDarting.csv', na = '')
      
      tblHyenas_tib <- read_csv  ('./data/tblHyenas.csv',
                              na = '') 
      
      
  ## 2.2 Explore data frames
    ## a) Data frame strucure
      str(tblDarting) # the structure of our data frame and class of each 
                      # variable
      
    ## b) View data frames
      # View data entire data frame
      View(tblDarting_tib)
      # View first 6 rows of data frame
      head(tblHyenas_tib)
      # use dplyr to view data
      glimpse(tblHyenas_tib)
      
      

###############################################################################
##############              3. Tidy data with tidyr              ##############
###############################################################################
      
  ### 3.1  Tidy data philosophy
      
    # “Happy families are all alike; every unhappy family is unhappy in its 
    #  own way.” –– Leo Tolstoy
      
    # “Tidy datasets are all alike, but every messy dataset is messy in its 
    #  own way.” –– Hadley Wickham
      
    # Three rules of tidy data (H. Wickham):
        # Each variable must have its own column.
        # Each observation must have its own row.
        # Each value must have its own cell.
    
    # Rationale for tidy data (H. Wickham):
        # Tidy data complements R’s vectorized operations. 
      
        # R will automatically preserve observations as you manipulate 
        # variables.
      
    
  ### 3.2 Using tidyr to make tidy data frames
    ## a) Create a smaller data set by subsetting tblDarting  
      tidy_df_test <- arrange(tblDarting_tib, id)
      tidy_df_test <- tidy_df_test [2:41, c(2:4, 12:14, 17, 21:22)]
        
    ## b) a wide format data frame (40 x 16)
      tidy_df_wide <- spread(tidy_df_test, clan, id)
        # spread function (df, variable to split into new variable names, 
                          # vairable containing values to poulate new variables)
        # levels of a single variale are used to create multiple varialbes
      
    ## c) a long format data frame (80 x 9)
      tidy_df_long <- gather(tidy_df_test, dart.variable, dart.value, 3,5)
        # gather function (df, new.var.1, new.var.2, columns to combine under 
                          # new variables)
        # mulitple variables combined into single variable; 
        # values from observations are repeated 
      
    ## d) Check your understanding of tidy data
      # Has the data itself changed between these versions of tblDarting?
      
      # Which data frame is tidy?
      
      # Can you convert an untidy data frame back to a tidy one? Try it here.
    


###############################################################################
##############            4. Data wrangling with dplyr           ##############
###############################################################################      
  
  ### 4.1 Indexing data frames
    ## a) Indexing elements from a data frame
      tblDarting[2,2]  # dataframes can be indexed with square brackets
      tblDarting$id[2] # dataframes can be indexed with dollar signs and 
                       # brackets
      
    ## b) Indexing variables
      id_mass <- tblDarting[ , c(2, 21)] # select 2nd and 21st columns
      kaycode_ear <- tblDarting[ , c("kay.code", "ear.length")]
      
    ## b) Indexing rows
      ath <- tblDarting[2, ] # select 2nd row
      
      cous <- tblDarting["cous", ] # why doesn't this work
      cous <- tblDarting[tblDarting$id == "cous", ]
      
      heavy <- tblDarting[tblDarting$mass > 75, ] # select hyenas by row that
                                                  # weigh more than me
      
      
  ### 4.2 Subsetting data frames with dplyr
    ## a) Subset by variables (columns)
      select(tidy_df_test, id, sex, mass) # select variables from tidy_df_test
      
      tidy_df_test %>%        # the same variable selection using piping
        select(id, sex, mass)
    
    ## b) Subset by observations (rows)  
      tidy_df_test %>%            # select rows where sex is female
        filter(grepl('^m$', sex)) # use grepl for pattern recognition
   
         
  ### 4.3 Simple functions for variable manipulation
    ## a) Make new variables  
      # we can add variables to the dataframe, like a variable of 0s and 1s
      tblDarting$new.var <- rep_len(c(0,1), length.out = length(tblDarting$id))
    
    ## b) Make new variable with mutate in dplyr
      # add categorical variable based on quartiles of continous mass
      tblDarting <- mutate (tblDarting, mass.quart = ntile(mass, 4))
 
      
  ### 4.4 Simple data summaries and dealing with NAs  
    ## a) Calculate the mean of ear length
      mean(tblDarting$ear.length) # We can do statistics on dataframes, 
                                  # like calculate mean..but wait! Notice what 
                                  # happened here...we get NA
      
      mean(tblDarting$ear.length, na.rm = T) # After removing the NA's we can 
                                             # now calculate the mean
      
    ## b) Remove all rows that contain any NA  
      tblDarting_omit <- na.omit(tblDaring) # Removes all rows with missing 
      # data. Be careful with this as rows of data may be removed for
      # missing data that are not vital for an analysis
     
       
  ### 4.5 Combine data frames
    ## a) Joins, a left join
      # we can join two data frames based on a shared varibale identifier
      tidy_df_join <- left_join(tidy_df_test, tblHyenas, by = 'id')
    
    ## b) Bind rows together 
      row_bind <- bind_rows(tidy_df_test, tidy_df_long) # be careful variables
                                                        # are the same in both
    
    ## c) Bind columns together
      col_bind <- bind_cols(id_mass, kaycode_ear) # be careful the observations
                                                  # match, same number and 
                                                  # arrangement of observations
       
         
  ### 4.6 Split, apply, combine 
    ## a) Univariate descriptive stats
      # calculate n, mean, median and standard deviation with no grouping
        univar_mass <- tblDarting %>%
                            summarize (N = sum(!is.na(mass)),
                                       avg = mean(mass, na.rm = T),
                                       median =  quantile(mass, c(.5), 
                                                          na.rm = T),
                                       sd = sd(mass, na.rm = T))
        
      ## b) bivariate descriptive stats
        # calculate n, mean, median and standard deviation grouped by sex
        bivar_mass <- tblDarting %>%
          group_by(sex) %>%
          summarize (N = sum(!is.na(mass)),
                     avg = mean(mass, na.rm = T),
                     median =  quantile(mass, c(.5), 
                                        na.rm = T),
                     sd = sd(mass, na.rm = T))    
        
      ## c) clean bivariate descriptive stats
        # calculate n, mean, median and standard deviation grouped by sex
        clean_bivar_mass <- tblDarting %>%
          filter(sex == "m" | sex == "f") %>%
          group_by(sex) %>%
          summarize (N = sum(!is.na(mass)),
                     avg = mean(mass, na.rm = T),
                     median =  quantile(mass, c(.5), 
                                        na.rm = T),
                     sd = sd(mass, na.rm = T))  
        
        
 
###############################################################################
##############                 5. Exporting data                 ##############
###############################################################################          
    
  ### 5.1 Export data to a pdf          
    ## a) save the data frame of summary stats out as a pdf into output file
        pdf("output/bivariate_stats.pdf", height = 6, width = 7)
        grid.table(clean_bivar_mass)
        dev.off()
   
        
  ### 5.2 Export to csv     
      # Save and export tables as a .cvs spreadsheet and named with today's
      # date. Files are saved in the 'output' folder in the working directory.
        
    ## a) Set up date parameters
        # print today's date
        today <- Sys.Date()
        date <- format(today, format="%d%b%Y")
        
    ## b) Generate File Names
        # For each table that will be saved as a .csv file, first generate a 
        # file name to save each table
        # here, we paste the folder path, followed by the file name 
        csv.file.name.bivar <- paste ("./output/", "bivariate_mass",
                                     date, ".csv", sep= "")   
        
    ## c) Save Tables 
        # Save each data frame as a .csv file (a spreadsheet/table) into the 
        # output data folder in the working directory.
        write.csv (clean_bivar_mass, file = csv.file.name.bivar)
        

               
###############################################################################
##############            6. More useful R resources             ##############
###############################################################################
  
  # tidy data theory - http://www.jstatsoft.org/v59/i10/paper
  # split apply combine theory - https://www.jstatsoft.org/article/view/v040i01
      
  ### 6.1 Data management in R resources
      # http://r4ds.had.co.nz/data-import.html  - data import
      # http://r4ds.had.co.nz/tidy-data.html  - tidy data
      # http://dplyr.tidyverse.org/  - tidyr
      # https://blog.rstudio.com/2014/07/22/introducing-tidyr/  - tidyr
      # http://seananderson.ca/2013/12/01/plyr.html  - split, apply, combine
        
        
  ### 6.2 Data management online courses
      # https://www.datacamp.com/courses/  - search 
          # dplyr-data-manipulation-r-tutorial under Data Analyst with R
      # https://ramnathv.github.io/pycon2014-r/
  
  
  ### 6.3 Papers on R data management
      # http://www.jstatsoft.org/v59/i10/paper  - tidy data theory 
      # https://www.jstatsoft.org/article/view/v040i01  - split, apply, combine
        
        
  ### 6.4 R community resources
      # https://www.r-bloggers.com
      # https://stackoverflow.com/questions/tagged/r
      
         
  

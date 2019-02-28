###############################################################################
##############            Basic Statisical Models in R:          ##############
##############               Family of Linear Models             ##############
##############                By: Zach Laubach                   ##############
##############            last updated: 10 April 2018            ##############
###############################################################################

  ### PURPOSE: This code aims to provide an introduction to basic linear
  ### models in program R. As before, we will begin by configuring our 
  ### workspace including loading a numuber of R packages. Then we will 
  ### import data into R and explore how to parameterize and interpret models.
  ### Here, and throughout we will follow the R Style Guide in order to  
  ### improve the consistency and readability of our code.

  ### This tutorial is based on online, opensource resources in addition to
  ### some copyrighted material, all of which are cited at this script's end.
    


  # Code Blocks
    # 1: Configure workspace
    # 2: Import data
    # 3: Tidy data 
    # 4: Data exploration and univariate analysis
    # 5: Bi-variate analysis
    # 6: Models
    # 7: Model visualation
    # 8: Resources for models in R



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
                  'data_mngmnt_analysis_for_biologist/',
                  '5_R_basic_statistical_models',
                  sep = ''))
      
    ## b) PC - setwd
     # setwd("c:\harddrive\users\username\desktop\5_R_basic_statistical_models")

      
  ### 1.4 Install Packages
  
    
    ## a) gridExtra is a package that can be used to export tables as pdf   
      install.packages("gridExtra") 
      library(gridExtra)
      
    ## b) arm is a package for regression modeling by Gelman
      install.packages('arm')
      library(arm)
      
    ## c) sjPlot is a graphing package
      install.packages('sjPlot')
      library(sjPlot)
      
    ## d) dplyr is a package for data management
      install.packages('dplyr') # install package to save it locally (done once
      # per computer)
      library(dplyr) # load package in current R session (done everytime you
      # you start a new R session)  
      
    ## e) tidyverse is a bundle of packages useful for data managenment
      install.packages('tidyverse')
      library(tidyverse)
      
  
    
###############################################################################
##############                   2. Import data                  ##############
###############################################################################

  ### 2.1 Import Data 
      # As a general rule, I would suggest storing raw data as .csv or .txt
      # files as opposed to Excel files, which has a tendency to re-format
      # variables and is version dependent.
  
    ## a) Import .csv to dataframe using base R
      tblDarting <- read.csv  ('./data/tblDarting.csv',
                             header = T)

      
      
  ## 2.2 Explore data frames
    ## a) Data frame strucure
      str(tblDarting) # the structure of our data frame and class of each 
                      # variable

      
      

###############################################################################
##############                    3. Tidy data                   ##############
###############################################################################
 
  ### 3.1 Subset data frame
    ## a) Subset by variables (columns)
      tblDarting <- tblDarting %>%  # the same variable selection using piping
        dplyr::select(id, sex, age, clan, mass, telazol.dose,
               ht.at.shoulder, age.at.darting.days)

      
  ### 3.2 Create a new variable    
    ## a) Make new variable with mutate in dplyr
      # add categorical variable based on quartiles of continous mass
      tblDarting <- mutate (tblDarting, 
                            ht.shoulder.quart = ntile(ht.at.shoulder, 4))  
  
  
  ### 3.3 Remove missing data
    ## a) Remove all rows that contain any NA  
      tblDarting <- na.omit(tblDarting) # Removes all rows with missing 
      # data. Be careful with this as rows of data may be removed for
      # missing data that are not vital for an analysis
      
    ## b) Remove rows where age.at.darting.days is 0
      tblDarting <-tblDarting %>%
        filter(!grepl('^0$', age.at.darting.days)) # use grepl
      
    ## c) Remove rows where age is adult
      tblDarting_cub_sub <-tblDarting %>%
        filter(!grepl('^adult$', age)) # use grepl 
    
    ## d) Remove rows where clan is like emarti or serena    
      tblDarting_cub_sub <-tblDarting_cub_sub %>%
        filter(!grepl('emarti|serena', clan)) # use grepl
      # remove ghost levels of clan variable
      tblDarting_cub_sub$clan <- as.factor(as.character
                                          (tblDarting_cub_sub$clan))
      
    ## e) Keep on rows where sex is known
      tblDarting_cub_sub <-tblDarting_cub_sub %>%
        filter(sex == "m" | sex == "f") 
      # remove ghost levels of sex variable
      tblDarting_cub_sub$sex <- as.factor(as.character
                                          (tblDarting_cub_sub$sex))
  
      
  ### 3.4 Add a variable to simplifly our predictor variable
    ## a) make a new variable of clan.bin
      tblDarting_cub_sub <- mutate (tblDarting_cub_sub, 
                            clan.bin = ifelse(tblDarting_cub_sub$clan=="talek",
                                                      "talek", "other"))
    ## b) convert clan.bin to factor
      tblDarting_cub_sub$clan.bin <- as.factor(tblDarting_cub_sub$clan.bin)
    
      
      
###############################################################################
##############    4. Data exploration and univariate analysis    ##############
###############################################################################      
  
  ### 4.1 Objectives of our linear model
    ## From Gelman and Hill, Chpt 3 ##
    ## Linear regression aims to summarize data as the change in a numerical
    ## response variable that is a functiion of linear predictors. This is 
    ## is a comparision of averages (in our response) between levels or
    ## values of our pridictor variables
     
       
  ### 4.2 Develop questions/hypotheses and predictions
    ## a)  We hypothesize that membership in social group is associated with 
           # body size.
    
    ## b) We predict that there will be differences in shoulder height that 
          # are associated with a hyena's clan independent of their age and sex
      
  
  ### 4.3 Data exploration of resposne variable 
    ## a) Use ggplot, a powerful graphic package in R, to make a histogram of
      # of our response variable, ht.at.shoulder
      ggplot(data=tblDarting, aes(x=ht.at.shoulder, y = ..density..)) + 
        geom_histogram(breaks=seq(45, 90, by = 0.5), 
                       col="black",
                       aes(fill = ..count..)) +
        scale_fill_gradient("Count", low = "light green", high = 
                              "dark blue") +
        geom_density() +
        xlim(c(40,90)) +
        labs(title="Histogram for Hyena Shoulder Height (cm)") +
        labs(x="shoulder height (cm)", y="Frequency")
      
      
    ## b) Use ggplot, a powerful graphic package in R, to make a histogram of
      # of our response variable, ht.at.shoulder, now on only cubs and subs
      ggplot(data=tblDarting_cub_sub, aes(x=ht.at.shoulder, y = ..density..)) + 
        geom_histogram(breaks=seq(45, 90, by = 0.5), 
                       col="black",
                       aes(fill = ..count..)) +
        scale_fill_gradient("Count", low = "light green", high = 
                              "dark blue") +
        geom_density() +
        xlim(c(40,90)) +
        labs(title="Histogram for Hyena Cub and Subadult Shoulder Height (cm)") +
        labs(x="shoulder height (cm)", y="Frequency")
      
      
  ### 4.4 Univariate analysis of resposne variable   
    # Univariate descriptive stats (just cubs and subadults)  
      # calculate n, mean, median and standard deviation with no grouping
        univar_shoulder_ht <- tblDarting_cub_sub %>%
                            summarize (N = sum(!is.na(ht.at.shoulder)),
                                       avg = mean(ht.at.shoulder, na.rm = T),
                                       median =  quantile(ht.at.shoulder, c(.5), 
                                                          na.rm = T),
                                       sd = sd(ht.at.shoulder, na.rm = T))
        
     
        
 
###############################################################################
##############              5. Bi-variate analysis               ##############
###############################################################################          
    
  ### 5.1 Bivariate analysis     
    ## a) Bivariate descriptive stats for sex
      # Use this version if you have missing data for grouping variable; 'sex'
      # calculate n, mean, median and standard deviation grouped by sex
        bivar_sex <- tblDarting_cub_sub %>%
          filter(sex == "m" | sex == "f") %>%
          group_by(sex) %>%
          summarize (N = sum(!is.na(ht.at.shoulder)),
                     avg = mean(ht.at.shoulder, na.rm = T),
                     median =  quantile(ht.at.shoulder, c(.5), 
                                        na.rm = T),
                     sd = sd(ht.at.shoulder, na.rm = T))  
        
    ## b) Bivariate descriptive stats for clan.bin
      # calculate n, mean, median and standard deviation grouped by sex
        bivar_clan <- tblDarting_cub_sub %>%
          group_by(clan.bin) %>%
          summarize (N = sum(!is.na(ht.at.shoulder)),
                     avg = mean(ht.at.shoulder, na.rm = T),
                     median =  quantile(ht.at.shoulder, c(.5), 
                                        na.rm = T),
                     sd = sd(ht.at.shoulder, na.rm = T))  
        
    ## c) Combine bivariate stats into single table
        bivar_clan <- rename(bivar_clan,  predictor = clan.bin)
        bivar_sex <- rename(bivar_sex,  predictor = sex)
        bivar_stats <- rbind(bivar_clan, bivar_sex)
    
        
  ### 5.2 Export data to a pdf          
    ## a) save the data frame of summary stats out as a pdf into output file
        pdf("output/bivariate_stats.pdf", height = 6, width = 7)
        grid.table(bivar_stats)
        dev.off()
   
        
  ### 5.3 Export to csv     
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
        csv.file.name.bivar <- paste ("./output/", "bivariate_stats",
                                     date, ".csv", sep= "")   
        
    ## c) Save Tables 
        # Save each data frame as a .csv file (a spreadsheet/table) into the 
        # output data folder in the working directory.
        write.csv (bivar_stats, file = csv.file.name.bivar)
        
        
  ### 5.4 Plot boxplots with ggplot2
    ## a) Plot shoulder height by clan.bin
        # graph of raw data for percent global DNA methylaiton by maternal rank
        ggplot(data = tblDarting_cub_sub,
               aes (x = clan.bin, y = ht.at.shoulder,
                    color = clan.bin)) +
          geom_boxplot() +
          theme(text = element_text(size=20))+
          scale_colour_hue(l = 50) + # Use a slightly darker palette than normal
          labs (title = "Shoulder height among cubs and 
subadult hyeans by clan membership") +
          ylab ("shoulder height (cm)") +
          xlab ("clan membership")
        
    ## b) Save Plot
      # use ggsave to save the boxplot
        ggsave("shoulder_by_clan_plot.pdf", plot = last_plot(), device = NULL,
               path = "./output", scale = 1, width = 8,
               height = 5,
               units = c("in"), dpi = 300, limitsize = TRUE)
        

               
###############################################################################
##############                      6. Models                    ##############
###############################################################################

  ### 6.1 Simple linear model with a numeric response and binary predictor
    # This model is also known as a t-test
    ## a) A view of the design matrix   
      model.matrix (with(tblDarting_cub_sub, ~ clan.bin -1))
        
    ## b) Linear model (note we can use lm where estimates are derived via 
        # Ordinary Least Squares (OLS) or glm function where estimates are 
        # derived from Maximum Likelihood Estimation (MLE))
        
        t_test_model <- lm(ht.at.shoulder ~ clan.bin, data = tblDarting_cub_sub) 
        
        t_test_model_mle <- glm(ht.at.shoulder ~ clan.bin,
                                family = "gaussian",
                                data = tblDarting_cub_sub)
        
        display(t_test_model)
        display(t_test_model_mle)
        summary(t_test_model)
        
    ## c) Model interpretation
        # Intercept is the mean should height of the reference group, here
        # hyeans from the 'other' clan group. The estimate is the difference 
        # between the Talek and other group means.
        
        
  ### 6.2 Simple linear model with a numeric response and numeric predictor
    # This model is also known as a simple linear regression
    ## a) A view of the design matrix   
        model.matrix (~ mass -1, 
                      data = tblDarting_cub_sub)
        
    ## b) Linear model 
        simp_reg_model <- lm(ht.at.shoulder ~ mass, 
                                data = tblDarting_cub_sub)
        
        summary(simp_reg_model)     
        
    ## c) Model interpretation
        # The estimate is the 1 unit change in y (response) for every one unit
        # change in x (predicotr) or the slope of the line. This is read as
        # a 0.6 cm increase in height for every 1 kg increase in mass. 
        # Here, the intercept is not meaningful unless we center our data...
        # i.e. the shoulder height of a hyena that has 0 kg mass makes no
        # sense.     
        
  
  ### 6.4 A linear model with a numeric response and 3 or more level categorical 
      # predictor variable. This model is also known as an ANOVA.
    ## a) A view of the design matrix   
        model.matrix (~ clan -1, data = tblDarting_cub_sub)
        
    ## b) Linear model (note we can use lm where estimates are derived via 
        # Ordinary Least Squares (OLS) or glm function where estimates are 
        # derived from Maximum Likelihood Estimation (MLE))
        
        anova_model <- lm(ht.at.shoulder ~ clan, 
                                data = tblDarting_cub_sub)
        
        display(anova_model)
        
    ## c) Model interpretation
        # Intercept is the mean should height of the reference group, here
        # hyeans from the 'other' clan group. The estimate is the difference 
        # between the Talek and other group means.
  
        
  ### 6.5 Multiple variable linear model with a numeric response and two or 
      # more categorical predictor variables. 
        
    ## a) A view of the design matrix   
        model.matrix (~ clan.bin + sex -1, 
                      data = tblDarting_cub_sub)
        
    ## b) Linear model (note we can use lm where estimates are derived via 
        # Ordinary Least Squares (OLS) or glm function where estimates are 
        # derived from Maximum Likelihood Estimation (MLE))
        
        control_sex_model <- lm(ht.at.shoulder ~ clan.bin + sex, 
                                data = tblDarting_cub_sub)
        
        display(control_sex_model)
        
        
    ## c) Model interpretation
        # Intercept - 
        # clan.bintalek (coef. est) - 
        # sexm (coef. est) - 
        
        
  ### 6.5 Multiple variable linear model with a numeric response and two or 
        # more categorical predictor variables. 
        
    ## a) A view of the design matrix   
        model.matrix (~ clan.bin + sex + age.at.darting.days -1, 
                      data = tblDarting_cub_sub)
        
    ## b) Linear model (note we can use lm where estimates are derived via 
        # Ordinary Least Squares (OLS) or glm function where estimates are 
        # derived from Maximum Likelihood Estimation (MLE))
        
        fully_adjust_model <- lm(ht.at.shoulder ~ clan.bin + sex + 
                                   age.at.darting.days,
                                 data = tblDarting_cub_sub)
        
        display(fully_adjust_model)      
        
        
        
###############################################################################
##############              7. Model visualization               ##############
###############################################################################
    
  #### 7.1 Extract the beta estimates from the model
        coefs = as.data.frame(summary(fully_adjust_model)$coefficients[-1,1:3])
        names(coefs)[2] = "se" 
        coefs$vars = rownames(coefs)
  
  #### 7.2 Plot beta estimates with ggplot2      
        ggplot(coefs, aes(vars, Estimate)) + 
          geom_hline(yintercept=0, lty=2, lwd=1, colour="grey50") +
          geom_errorbar(aes(ymin=Estimate - 1.96*se, ymax=Estimate + 1.96*se), 
                        lwd=1, colour="grey75", width=0) +
          geom_errorbar(aes(ymin=Estimate - se, ymax=Estimate + se), 
                        lwd=2.5, colour="grey50", width=0) +
          geom_point(size=4, pch=21, fill="red") +
          labs (title = "Fully adjusted model beta estimates ± SE (thick grey bars) and 
95% CIs (thin grey bars) for cubs and subadult hyeans") +
          ylab ("Beta estimate for shoulder height (cm)") +
          xlab ("Predictor variables")
          theme_bw()

          
        
###############################################################################
##############           8. Resources for models in R            ##############
###############################################################################

  ### 8.1 Online linear modeling R resources
      # http://data.princeton.edu/R/linearModels.html  - basic linear models
      # http://data.princeton.edu/R/glms.html - generalized linear models
      # http://bbolker.github.io/mixedmodels-misc/glmmFAQ.html - mixed models
      # http://rpsychologist.com/r-guide-longitudinal-lme-lmer - longitudinal
      #                                                          models
        
        
  ### 8.2 Books on linear modeling (example code is in R)
        
      # Gelman, Andrew and Hill, Jennifer. 2007. Data analysis
      # using regression and multivariable/hierarchical models.
      # Cambridge University Press, New York.
        
      # Kéry, Marc. 2010. Introduction to WinBUGS for ecologists:
      # A Bayesian approach to regression, ANOVA, mixed models,
      # and related analyses. Academic Press, Boston.
  
  
  ### 8.3 R community resources - for specific questions and error resolution
      # https://www.r-bloggers.com
      # https://stackoverflow.com/questions/tagged/r
      
         
  

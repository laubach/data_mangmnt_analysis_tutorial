###############################################################################
##############             Introduction to Program R             ##############
##############                                                   ##############
##############                By: Zach Laubach                   ##############
##############             last updated: 29 Jan 2018             ##############
###############################################################################

  ### PURPOSE: This code is desingned to provide a brief overview of
  ### program R and an introduction some basic R utilities. We will use
  ### R Studio and some online resources to become familiar working with R.
  ### Here, and throughout we will follow the R Style Guide in order to 
  ### improve the consistency and readability of our code.

  ### This tutorial is based on a number of online, opensource resources
  ### as well as examples and organization that are based on some 
  ### copyrighted material.
    
    # The R Book, Michael J. Crawley, Copyright © 2013 JohneWiley & Sons, Ltd.
    # Advanced R, © Hadley Wickham
    # R Tutorial, Copyright © 2009 - 2018 Chi Yau All Rights Reserved
    # Quick-R, Copyright © 2017 Robert I. Kabacoff, Ph.D.


  # Code Blocks
    # 1: Getting R and R Studio
    # 2: R as a calculator
    # 3: Assigning variables and variable types
    # 4: Data structures and accessing data 
    # 5: Some useful R resources 



###############################################################################
##############             1.  Getting R and RStudio             ##############
###############################################################################

  ### 1.1 What is R
    # R is a free software environment for statistical computing and graphics. 
    # It compiles and runs on a wide variety of UNIX platforms, Windows and 
    # MacOS (per the r-project website). 

    # For more information on the development of R see the following website
    # https://www.r-project.org/about.html
  

  ### 1.2 Downloading R
    ## a)  Download R at https://cran.r-project.org

    ## b) A video tutorial for downloading R on Mac
      # https://www.youtube.com/watch?v=Icawuhf0Yqo&feature=youtu.be
  
    ## c) A video tutorial for downlading R on Windows
      # https://www.youtube.com/watch?v=mfGFv-iB724&feature=youtu.be


  ### 1.3 What is RStudio
    # RStudio is a set of integrated tools designed to help you be more 
    # productive with R. It includes a console, syntax-highlighting editor 
    # that supports direct code execution, and a variety of robust tools for 
    # plotting, viewing history, debugging and managing your workspace (per
    # the RStudio website).

    # For more information on the development of RStudio see the following 
    # website
   

  ### 1.4 Downloading RStudio
    ## a) Download RStudio at 
      # https://www.rstudio.com/products/rstudio/download/#download


  ### 1.5 Open R and RStudio
    ## a) Opening R
      # Open RStudio and new blank interface will open. 
      # Next, under File, Open File, you should navigate to this R script,
      # 'R_intro.R' and open it. 

    ## b) Some general syntax rules
      # To run code, highlight or place curser inline of code and hit 'run' or
      # keystrokes, 'command' 'enter'
    
      # Hashtags comment out lines of code, and are not run...use abundant 
      # commenting to explain code function


  ### 1.6 R Version and Session Info
    R.Version()
    sessionInfo()
    
    # Developed in:   
    # R version 3.4.3 (2017-11-30)
    # Platform: x86_64-apple-darwin15.6.0 (64-bit)
    # Running under: macOS Sierra 10.12.4


    
###############################################################################
##############                2.  R as a calcultor               ##############
###############################################################################

  ### 2.1 Basic calculator functions
  
    ## a) Arithmetic operators
      5 + 10 # addition
      5 - 10 # subtraction
      5 * 10 # multiplaction
      5 / 10 # division
      5 ^ 10 # exponentiation
      
    ## b) Relationanl and logical operators
      5 > 10 # greater than
      5 <= 10 # less than
      5 == 10 # is equal to
      5 != 10 # does not equal
    
    ## c) Slightly more advanced calculations
      pi # the value pi
      exp(5 + 10) # anti log (natural log)
      log(5 + 10) # natural log
      log10(5 + 10) # log base 10
      sqrt(5 + 10) # square root
      floor(5.5) # round down to nearest integer
      ceiling(5.5) # round up to nearest integer
      

    
###############################################################################
##############     3. Assigning variables and variable types     ##############
###############################################################################

  ### 3.1  Assigning variables
    ## a) Part of the goal of programming in R is to assign values to 
      # variables that can be stored and used in downstream calculations.
      
      # Some Rules:
        # Variable names are case sensitive
        # Variable names should not include, spaces, numbers, or special 
        # characters.
    
    ## b) Simple example
      x <- 5 # assign the number 5 to variable/object x
      x # print x
      
      z <- 10 # assign the number 10 to variable/object z
      z # print z
      
      y <- x + z # do some operation with stored variables and save the 
                 # the output to a new variable y
      y # print y
  
          
  ### 3.2  Checking and assiging variable types / class
    ## a) Check type / class of variable  
      class(y)
      
    ## b) Numeric - continous numbers 
      xnum <- 3.3
      class(xnum)
      znum <- 999
      class(znum)
      
    ## c) Integer - whole numbers 
      xint <- 3L
      class(xint)
      zint <- 999L
      class(zint)
      
    ## d) Character - strings of text  
      xchar <- "hi"
      class(xchar)
      zchar <- "can characters include numbers"
      class(zchar)  
      
    ## e) Logical - strings of text  
      xlog <- TRUE
      class(xlog)
      zlog <- F
      class(zlog) 
    
    ## f) Convert variables to a different class
      xint.to.num <- as.numeric(xint) # convert integer to numeric class
      class(xint.to.num)
      
      # Other conversions
        # as.integer
        # as.character
        # as.logical
        # as.factor
      
    ## g) Factors...these are categorical or ordinal variables...we'll 
      # come back to these.
        


###############################################################################
##############       4. Data structures and accessing data       ##############
###############################################################################      
  
  ### 4.1 Vectors and Lists
    ## a) Descriptions
      # Both are 1 dimensional
      # Vectors contain elements that are all the same class, use 'c' to 
        # construct vector
      # List are contain elements of mixed classes, use list 'list' to 
        # construct lists 
    
    ## b) Example vectors 
      vnum <- c(4, 5.5, 8, 2.3) # a numeric vector
      vint <- c(1L, 4L, 8L, 5L) # an integer vector
   
    ## c) Some useful functions for vectors
      length(vnum) # how many elements in the vector
      mean(vnum) # calculate mean of the vector
      median(vnum) # calculate the median
      min(vnum) # find minimum value in vector
      vnum.last <- vnum[3] # index an element within a vector by position
      
    ## d) Creating vectors
      vseq <- seq(from = 1.6, to = 19, by = 5) # create a vector sequence
    
    ## e) Arithmetic on vectors
      # R is vectorized, so it will operate on each element of vector
      vnum.add <- vnum + 5 # add 5 to each element of vector
      vnum.add.vseq <- vnum + vseq # if vectors are same length, add element by
                                   # element
  
    ## f) Example List  
      l <- list (2.5:5, "a list of mixed class", c(T,F,F), c(1L, 4L))
      str(l) # print the structure (class types) of the list
    
        
  ### 4.2 Factors - a special type of categorical or ordinal vector
    ## a) Factor variable
      vfact <- factor(c(1, 2, 3, 1, 1, 3)) # a factor of 3 levels: 1, 2, 3
      length(vfact) # how many elements are in this factor variable
      levels(vfact) # how many categories are in this factor variable
      
    ## b) 2-level color factor example using rep function 
      color.fact <- factor(c(rep("red", 15), c(rep("blue", 10))))
      color.fact
      
    ## c) Ordinal Variable - an ordered factor
      vord <- factor(vfact, levels = c(2, 3, 1)) 

        
  ### 4.3 Matrices and Dataframes
    ## a) Descriptions
      # Both are 2 dimensional
      # Matrices contain elements that are all the same class. Can be thought 
        # of as a collection of vectors of the same length
      # Dataframes have columns (or vairables) that are the same class within, 
        # but can be different classes between columns.  
      
    ## b) Example Matrix
      table.matr <- matrix(letters, nrow = 13, ncol = 2) # matrix (13 x 2) of
                                                         # lowercase letters
      length(table.matr) # number of elements in the matrix
      str(table.matr) # the row by column dimensions and element list
      
    ## c) Indexing a matrix 
      # use square brackets in the form of 'matrix[row, column]'
      table.matr[12, 2] # select element from 12th row, 2nd column
      table.matr[[25]] # select the 25th element
      length(table.matr[ ,1]) # number of rows in column 1
      length(table.matr[1, ]) # number of columns in row 1
      
    ## d) Example Dataframe
      # this creates a dataframe with 2 varibles, df.x is a numeric random, 
      # normal distribution, and df.y is two level repeating factor
      df <- data.frame(df.y = rnorm(n = 26, mean = 4.5, sd = 1), 
                       df.x = c("blue", "red"))  
      str(df) # the structure of our data frame
  
    ## e) Indexing and manipulating dataframes
      df[6,2] # dataframes can be indexed with square brackets
      df$df.x[2] # dataframes can be indexed with dollar signs and brackets
      length(df$df.y) # the number of rows in our dataframe
      colnames(df) <- c("number", "color") # variables can be renamed
      df$new.var <- as.integer(1:26) # we can add variables to the dataframe
      mean(df$number) # we can do statistics on dataframes, like calculate mean
   
    # Next time we'll spend time reading in dataframes from csv files and
    # and manipulating those dataframes in meaningful ways.
      
          
###############################################################################
##############            5. Some useful R resources             ##############
###############################################################################
    
  ### 5.1 Introduction to R resources
      # https://www.statmethods.net/index.html
      # http://www.r-tutor.com/
      # https://www.tutorialspoint.com/r/index.htm
      # http://www.cookbook-r.com/
  
      
  ### 5.2 R community resources
      # https://www.r-bloggers.com
      # https://stackoverflow.com/questions/tagged/r
      
         
  ### 5.3 Interactive R resources
      # http://swirlstats.com/students.html
      
      install.packages("swirl")
      library(swirl)
 

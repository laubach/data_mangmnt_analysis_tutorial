#############################################
#           R Lesson -  Control flow        #
#                                           #
#       AKA fancy programming stuff         #
#             By Eli Strauss                #
#                                           #
#############################################

# Before we get started with today's lesson, I want you to practice programming
# in a different context. 

# Go to https://www.google.com/doodles/celebrating-50-years-of-kids-coding
# and click on the doodle game and play it. 

# Great, now let's get started. First things first, let's load the some packages.

library(ggplot2)
library(dplyr)


# Today's lesson focuses on "control flow." This is the 
# term for the different commands you can use to control the way the computer
# processes the lines in your script. Until now, every line of code (not
# counting these comments) gets treated by the computer in the same
# way--that is, it processes each line once, in the order it is written in
# the script. However, what if you wanted to write some code that would only
# run under certain conditions? Or what if you want to do the same operation
# many times? Fortunately, control flow commands will allow us to efficiently
# do both of these things. These tools will allow us to tell the computer to
# treat certain lines of code specially, either by running them multiple times
# or running them only if some condition is true. Remember the loop in the bunny
# game? That allowed us to tell the computer to treat those simple
# 'move forward' and 'turn right' commands differently. We will be doing
# something very similar in class today.


# But before we start with loops, we will go over a different control flow tool:
# the *if statement*. The if statement is the most basic control flow tool.
# Here is the basic structure of an if statement:

if(conditional-statement){
  what-to-do-if-statement-is-true
}else{
  what-to-do-if-statement-is-false
}

# What is a conditional statement? It's a logical command that evaluates
# to TRUE or FALSE, or something equivalent. For example:

# does one equal one?
1 == 1
# does one equal two?
1 == 2
# is one a number?
is.numeric(1)
#is 'one' a number?
is.numeric('one')
#is 1 present in this seriese of numbers?
1 %in% c(1,2,3,4,5)

# As you can see, these conditional statements most often can be phrased as a
# question. So now let's make an if statement using a variable. Let's say we 
# want to know if the square of a number is greater than 200. Sure, we could do
# math, but it is easier to have the computer do it. 

your.number <- 12

if(your.number^2 > 200){
  print('Yes')
}else{
  print('No')
}

# Try changing your.number to be something different and rerunning the
# if statement. Do you understand what is happening? 

# We can also combine if statements to do different things under a few
# different conditions. Let's say we want to classify numbers now into small 
# (number squared is less than 100), medium (number squared is 100 or greater
# and less than 200), or large (number squared is at leats 200). Easy!

your.number <- 5

if(your.number^2 < 100){
  print('small')
}else if(your.number^2 < 200){
  print('medium')
}else{
  print('large')
}



# Let's take one more example: Suppose you have a giant number, 984980. 
# You don't know where it came from, but you have a burning desire to know if 
# it divisible by 17, your favorite number. 
# We can ask the computer to tell us that!

# Side note: The operator %% is called 'modulo' and returns the remainder after
# a division. So what the conditional statement below translates to is:
# Does giant number divided by 17 have a remainder that equals 0?

# Ok, back to it:
giant.number <- 984980

if(giant.number %% 17 == 0){
  print(paste0(giant.number, ' is divisible by 17!'))
}else{
  print(paste0(giant.number, ' is NOT divisible by 17!'))
}

# What you should see here is that the computer checks toe see if giant_number
# is divisible by 17, and if it is it does the first 'print..' line, and if it
# isn't, it does the second 'print..' line. You can further see how this works
# by running ONLY the print lines, one at a time. You should see that these
# lines work fine, but the if statement skips over them depending on the
# evaluation of the conditional statement. Try changing the value of giant_number
# to test what happens with other numbers. 

# Ok, that's enough of if statements now. They are really powerful, but they
# are most useful when used in conjunction with loops. A loop is exactly what
# it sounds like: a set of code lines that the computer runs iteratively (which
# is a fancy way of saying 'over and over'). We will focus on the for loop, 
# although there are other types as well. 

# Here is the basic format of a for loop. 

for(iterator in things-to-go-through){
  the-stuff-that-you-do
  ...
  ...
  you can put many lines of code inside these curly brackets
}

# Think back to the rabbit game. The orange loops surrounded some commands,
# and those commands were repeated. The number of times to repeat the commands
# was set by the number on the orange loop (and you could change that number). 

# Here are going to do the same thing, except to set the number of times to do
# something, we are going to have the iterator take on different values. Let's
# try making our 'bunny' hop four times.  

for(iterator in c(1,2,3,4)){
  print('bunny HOP!')
}

# The reason this happened 4 times is because the iterator took on 4 different
# values. Here is the same loop, but now it's also going to print out what
# the value of iterator is after each hop. 

for(iterator in c(1,2,3,4)){
  print(paste0('bunny HOP!...iterator is equal to ', iterator))
}

# Importantly, what matters here is the list of things we are going through is
# four items long, not the actual values in this case.
# I can change the items in the list and it will still do it four times.

for(iterator in c(10,20,30,40)){
  print(paste0('bunny HOP!...iterator is equal to ', iterator))
}

# Ok, last important, and somewhat confusing thing: the iterator is a variable
# that is created inside the parentheses when you define it. You can name it
# anything you want.

for(anything.you.want in c(1,2,3,4)){
  print(paste0('bunny HOP!...anything.you.want is equal to ', anything.you.want))
}

# Sometimes you just want to do things many times (like we just did). 
# Other times, you want to perform the same action on a bunch of different
# values. If this is the case, you can have your iterator go through each
# value you are interested in and do the action. Let's say that we want to know
# all the numbers divisible by 17 between 1 and 1000. Sounds hard? But,
# it isn't. 

# First, we need to make our sequence of numbers from one to one thousand.
numbers.to.check <- 1:1000

# Now we make our for loop. We want 'giant.number' to try every value in 
# numbers.to.check

for(giant.number in numbers.to.check){
  print(giant.number)
}

# Ok, now we are going to do some exercises with these tools. We are going
# to use them to learn about the history of the involvement of African nations
# in the Olympics. Read in the files I sent you.

summer <- read.csv('~/Documents/Teaching/R Vignettes/Control Flow/summer.csv')
african.nations <- read.csv('~/Documents/Teaching/R Vignettes/Control Flow/african_country_codes.csv',
                            header = FALSE)
names(african.nations) <- c('country', 'code.2', 'code.3', 'dot.code')

# Next, we are going to make the data frame that we will store the data in.
# We want to know how many medalists from Africa there were in each year at
# the summer games, broken down by gender.

all.years <- unique(summer$Year)

african.medals <- data.frame(year = rep(all.years, 2),
                             medals = NA,
                             gender = c(rep('male', length(all.years)),
                                        rep('female', length(all.years))))

# Let's plan it out step by step on the board. I will start. 

for(year in all.years){
  # step 1
  # subset the summer data base by:
  #   African nation
  #   gender
  #   year
  filter(summer, Country %in% african.nations$code.3 & Gender == 'Women'
         & Year == year)
  # step 2
  #   count the number of rows in the subset
  
}

ggplot(data = african.medals, aes(x = year, y = medals, col = gender))+
  geom_line(size = 2) +
  theme_classic()




# Additional owrk with variables
# variables are case sensitive

my_cup<-5 # Assogn value to variable and Run
my_cup2<-my_cup # what it mean?

my_cup==my_cup2 # to compare var
my_cup2 # to view the value

my_cup2<-"my cup" # reassigning with string=text

my_cup2 # to view the value
my_cup # to view the value

my_cup==my_cup2 # to compare var

rm(my_cup2) # to remvoe variable
my_cup == myu_cup2

# Load data from global Git Hub Repo

data<-read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-12-22/big-mac.csv')

# What's the error and why? Can you run next line of code?

data%>%head() # function to see first 6 lines

head(data$currency_code) # to see one column

messy_data<-relig_income

messy_data
messy_data%>%head() #function to see first 6 lines

head(messy_data$'<$10k') # to see one column
head(messy_data$'50-75k') # to see one column

# hint
# to install a package, use install.packages() function

install.packages("tidyverse") #don't run it everytime
library(tidyverse) 
data<-read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-12-22/big-mac.csv')

data%>%head()

head(data$currency_code)

messy_data<-relig_income

messy_data
messy_data%>%head()

head(messy_data$'<$10k')
head(messy_data$'$50-75k')


# Skeleton file 1 for Assignment 1 in BAN400. 
# -------------------------------------------

##############################
# Load required packages
library(tidyverse)
library(ggplot2)
##############################

##############################
# PROBLEM 2
##############################

# Comments below describes briefly a set of steps that solves Problem 1.

# Read the entire data file into memory using the readLines()-function. Use the
# URL direcly or read the data from the local file that is in the repository.
original_data <- readLines("http://www.sao.ru/lv/lvgdb/article/suites_dw_Table1.txt")

# Identify the line number L of the separator line between the column names and
# the rest of the data table.
L <- grep("^-+", original_data)
  
# Save the variable descriptions (i.e. the information in lines 1:(L-2)) in a
# text-file for future reference using the cat()-function
variable_descriptions <- original_data[1:(L-2)]
writeLines(variable_descriptions, "variable_descriptions.txt")

# Extract the variable names (i.e. line (L-1)), store the names in a vector.
variable_names <- trimws(strsplit(original_data[L-1], "\\s+\\|\\s+")[[1]])

# Read the data. One way to do this is to rewrite the data to a new .csv-file
# with comma-separators for instance using cat() again, with the variable names
# from the step above on the first line (see for instance paste() for collapsing
# that vector to a single string with commas as separators).
comma_separated_values <- 
  original_data[(L+1):length(original_data)] %>% 
  gsub("\\|", ",", .) %>% 
  gsub(" ", "", .)

comma_separated_values_with_names <- 
  c(paste(variable_names, collapse = ","),
    comma_separated_values)    

cat(comma_separated_values_with_names, file = "galaxies.csv", sep = "\n")

# Read the finished .csv back into R in the normal way.
galaxies <- read.csv("galaxies.csv")

##############################
# PROBLEM 3
##############################

# Create a histogram of the linear diameter a_26
ggplot(data = galaxies, aes(x = a_26)) +
  geom_histogram(binwidth = 0.5, fill = "black") +
  labs(x = "Linear Diameter (kpc)", y = "Frequency") +
  ggtitle("Distribution of Linear Diameter") +
  theme_minimal()

# The distribution of galaxy sizes in the catalog indicates a left-steep, 
# right-skewed pattern, suggesting a presence of many small galaxies but a 
# drop-off in the frequency of very tiny galaxies. This distribution implies 
# that the catalog may under-represent the smallest galaxies, potentially due 
# to limitations in detection capabilities or measurement accuracy. 
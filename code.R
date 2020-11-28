
# Loading packages, importing the file in R, viewing and inspecting it

library(tidyverse)
library(readxl)
library(ggplot2)
library(caret)

df <- read_excel("ENB2012_data.xlsx")


# 1. Inspecting the data table and providing descriptive statistics. Checking for NA's/duplicate values

head(df)

# Adding column names

col_names <- c('Relative_Compactness', 'Surface_Area','Wall_Area','Roof_Area','Overall_Height','Orientation','Glazing_Area',
               'Glazing_Area_Distribution','Heating_Load','Cooling_Load')

names(df) <- col_names

str(df)
summary(df)   
sum(is.na(df)) # Inspecting for any NA
is.null(df) # Inspecting for null values
sum(duplicated(df)) # Inspecting for any duplicate values



################################################################################

# 2. Describing  Heating Load and Cooling Load and inspecting them visually

# Y1 Heating Load

summary(df$Heating_Load)   
sd(df$Heating_Load)
mean(df$Heating_Load) + 3*sd(df$Heating_Load)    # Checking for any outliers using Empirical rule
mean(df$Heating_Load) - 3*sd(df$Heating_Load)


# Plotting Histogram. Heating Load is right skewed (also its mean > median)

ggplot(data = df) + 
  geom_histogram(mapping = aes(x = Heating_Load), 
                 fill  = "#1D76B5",
                 color = "white", 
                 binwidth = 5) + 
  ggtitle("Heating Load Histogram") +
  xlab("Heating Load values") +
  ylab("Frequency")


# Cooling Load

summary(df$Cooling_Load)
sd(df$Cooling_Load)
mean(df$Cooling_Load) + 3*sd(df$Cooling_Load)    # Checking for any outliers using Empirical rule
mean(df$Cooling_Load) - 3*sd(df$Cooling_Load)


# Plotting Histogram. Cooling Load is right skewed (also its mean > median)

ggplot(data = df) + 
  geom_histogram(mapping = aes(x = Cooling_Load), 
                 fill  = "#1D76B5",
                 color = "white", 
                 binwidth = 5) + 
  ggtitle("Cooling Load Histogram") +
  xlab("Cooling Load values") +
  ylab("Frequency")


# Box-plot for Heating and Cooling Load

boxplot(df$Heating_Load, df$Cooling_Load, 
        main = "Heating and Cooling load box-plots", names = c("Heating Load","Cooling Load"),
        col = c(4,5), xlab = "Values", horizontal = TRUE)


################################################################################

# 3. 

#Inspecting strength of relationship between the variables

round(cor(df),2)

#Inspecting scatter plots of predictor variables vs Heating load

ggplot(df, aes(x = Relative_Compactness, y = Heating_Load)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red")
  

ggplot(df, aes(x = Surface_Area, y = Heating_Load)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red")


ggplot(df, aes(x = Wall_Area, y = Heating_Load)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red")


ggplot(df, aes(x = Roof_Area, y = Heating_Load)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red")


ggplot(df, aes(x = Overall_Height, y = Heating_Load)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red")


ggplot(df, aes(x = Orientation, y = Heating_Load)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red")


ggplot(df, aes(x = Glazing_Area, y = Heating_Load)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red")


ggplot(df, aes(x = Glazing_Area_Distribution, y = Heating_Load)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red")



#Inspecting scatter plots of predictor variables vs Cooling load

ggplot(df, aes(x = Relative_Compactness, y = Cooling_Load)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red")


ggplot(df, aes(x = Surface_Area, y = Cooling_Load)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red")


ggplot(df, aes(x = Wall_Area, y = Cooling_Load)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red")


ggplot(df, aes(x = Roof_Area, y = Cooling_Load)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red")


ggplot(df, aes(x = Overall_Height, y = Cooling_Load)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red")


ggplot(df, aes(x = Orientation, y = Cooling_Load)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red")


ggplot(df, aes(x = Glazing_Area, y = Cooling_Load)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red")


ggplot(df, aes(x = Glazing_Area_Distribution, y = Cooling_Load)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red")


# ViewingPredictor Variable distributions via their histograms
par(mfrow = c(3,3))

hist(df$Relative_Compactness,xlab='Relative Compactness', main='')
hist(df$Surface_Area, xlab='Surface Area',main='')
hist(df$Wall_Area, xlab='Wall Area',main='')
hist(df$Roof_Area, xlab='Roof Area',main='')
hist(df$Overall_Height, xlab='Overall Height',main='')
hist(df$Orientation, xlab='Orienation',main='')
hist(df$Glazing_Area, xlab='Glazing Area',main='')
hist(df$Glazing_Area_Distribution, xlab='Glazing Area Distribution',main='')


################################################################################

# 4. Checking Multi-Collinearity between the independent variables (rounding to 2 decimal places).
# Relative_compactness with Surface_Area, Roof_Area, Overall_Height 
# Surface_Area with Roof_Area and Overall_Height
# Roof_Area with Overall_Height

round(cor(df),2)

#Dropping Relative_compactness 
#Re-checking Multi-Collinearity

round(cor(df[,c(-1)]),2)

#Dropping Surface_Area only and checking any changes to Multi-Collinearity table

round(cor(df[,c(-2)]),2)

# No changes noted
# Dropping Roof_Area and re-checking Multi-Collinearity

round(cor(df[,c(-1,-4)]),2)

#Dropping Surface_Area as well 

round(cor(df[,c(-1,-2,-4)]),2)


################################################################################

# 5. Dropping Relative_compactness, Surface_Area and Roof_Area
# Splitting data into training (80%) and testing sets (20%)

df1 <- df[,c(-1,-2,-4)]

set.seed(123)
s <- sample(2, nrow(df1), replace = TRUE, prob = c(0.8,0.2))
train_df1 <- df1[s == 1,] 
test_df1 <- df1[s == 2,]

################################################################################

# 6. Building model for Heating Load

m1 <- lm(Heating_Load ~., train_df1)
summary(m1)

# Model is stat. significant; R Sq is 0.92; Orientation is individually stat. insignificant
# Dropping Orientation and running a re-iteration

m1 <- lm(Heating_Load ~ Wall_Area + Overall_Height + Glazing_Area + Glazing_Area_Distribution, train_df1)
summary(m1)


# Model is stat. significant; R Sq is 0.91; All predictor variables are individually stat. significant


#Residual Analysis

# To check residuals distribution  - appear to be normally distributed
hist(m1$residuals,xlab='Residuals', main='')

# Checking Linearity and equal variance (no cone shape formations)
# Residuals are independent

plot(m1$residuals,ylab='residuals')
abline(a = 0, b = 0)


# Checking normal probaility plot - approximately a straight line

par(mfrow = c(2,2))  # To divide screen into 4 parts
plot(m1)              # residual plot   - linearity / equal variance assumption is met   



# Making predictions and checking RMSE and R-Sq to check the model's performance

pred_m1 <- predict(m1, test_df1)
R2(pred_m1,test_df1$Heating_Load) # Rsq
RMSE(pred_m1,test_df1$Heating_Load) # RMSE
RMSE(pred_m1,test_df1$Heating_Load)/mean(test_df1$Heating_Load) # Error rate

# R-Sq is 0.89, which means the observations and predicted values are highly correlated
# RMSE is 3.32 , representing an error rate of 14.2%
# Significant var. are wall area, overall height, glazing area and glazing area distribution.


################################################################################

# 7.Building model for Cooling Load

m2 <- lm(Cooling_Load ~., train_df1)
summary(m2)

# Model is stat. significant; R Sq is 0.88; Orientation and Glazing_Area_Distribution are individually stat. insignificant
# Dropping Orientation and running a re-iteration


m2 <- lm(Cooling_Load ~ Wall_Area + Overall_Height + Glazing_Area + Glazing_Area_Distribution , train_df1)
summary(m2)

# Dropping Glazing_Area_Distribution and running a re-iteration

m2 <- lm(Cooling_Load ~ Wall_Area + Overall_Height + Glazing_Area, train_df1)
summary(m2)

# Model is stat. significant; R Sq is 0.88; All IV are individually stat. significant

# Residual analysis

# To view residuals distribution  - appear to be normally distributed
hist(m2$residuals, xlab='Residuals', main='')


# Checking Linearity and equal variance (no cone shape formations)
# Residuals are independent

plot(m2$residuals, ylab='Residuals')
abline(a = 0, b = 0)

# Checking normal probaility plot - approximately a straight line

par(mfrow = c(2,2))  # To divide screen into 4 parts
plot(m2)    # residual plot   - linearity / equal var assumption is met   


# Making predictions and checking RMSE and R-Sq to check the model's performance


pred_m2 <- predict(m2, test_df1)
R2(pred_m2,test_df1$Cooling_Load)
RMSE(pred_m2,test_df1$Cooling_Load)
RMSE(pred_m2,test_df1$Cooling_Load)/mean(test_df1$Cooling_Load)

# R2 is 0.85, which means the observes and predicted values are highly correlated
# RMSE is 3.66 , representing an error rate of 14.3%
# Significant var. are wall area, overall height and glazing area.










# Loading packages, importing the file in R, viewing and inspecting it

library(tidyverse)
library(readxl)

df <- read_excel("ENB2012_data.xlsx")


# 1. Inspecting the data table and providing descriptive statistics. Checking for NA's

df
view(df)
str(df)
summary(df)   
sum(is.na(df))

################################################################################

# 2. Describing Y1 (Heating Load) and Y2 (Cooling Load) and inspecting them visually

# Y1 Heating Load

summary(df$Y1)   
sd(df$Y1)
mean(df$Y1) + 3*sd(df$Y1)    # Checking for any outliers using Empirical rule
mean(df$Y1) - 3*sd(df$Y1)


# Plotting Histogram. Y1 is right skewed (also its mean > median)

ggplot(data = df) + 
  geom_histogram(mapping = aes(x = Y1), 
                 fill  = "#1D76B5",
                 color = "white", 
                 binwidth = 5) + 
  ggtitle("Y1 Frequencies") +
  xlab("Y1 values") +
  ylab("Frequency")


# Y2 Cooling Load

summary(df$Y2)
sd(df$Y2)
mean(df$Y2) + 3*sd(df$Y2)    # Checking for any outliers using Empirical rule
mean(df$Y2) - 3*sd(df$Y2)


# Plotting Histogram. Y2 is right skewed (also its mean > median)

ggplot(data = df) + 
  geom_histogram(mapping = aes(x = Y2), 
                 fill  = "#1D76B5",
                 color = "white", 
                 binwidth = 5) + 
  ggtitle("Y2 Frequencies") +
  xlab("Y2 values") +
  ylab("Frequency")


# Box-plot for Y1 and Y2

boxplot(df$Y1, df$Y2, 
        main = "Y1 and Y2", names = c("Y1","Y2"),
        col = c(4,5), xlab = "Values", horizontal = TRUE)


################################################################################

# 3. Plotting scatter plots for all independent numerical variables with Y1 to visualize correlation
# Use pairs(df) for a single plot if viewing on larger screen
# Can also use library(psych) pairs.panels(df) for a single plot (also provides collinearity)

# Inspecting strength of relationship between IV and DV
round(cor(df),2)


ggplot(df, aes(x = X1, y = Y1)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red") 


ggplot(df, aes(x = X2, y = Y1)) +
  geom_point() +
  geom_smooth(method = lm , se = FALSE, color = "red") 


ggplot(df, aes(x = X3, y = Y1)) +
  geom_point() +
  geom_smooth(method = lm , se = FALSE, color = "red") 


ggplot(df, aes(x = X4, y = Y1)) +
  geom_point() +
  geom_smooth(method = lm , se = FALSE, color = "red") 


ggplot(df, aes(x = X5, y = Y1)) +
  geom_point() +
  geom_smooth(method = lm , se = FALSE, color = "red") 


ggplot(df, aes(x = X6, y = Y1)) +
  geom_point() +
  geom_smooth(method = lm , se = FALSE, color = "red") 


ggplot(df, aes(x = X7, y = Y1)) +
  geom_point() +
  geom_smooth(method = lm , se = FALSE, color = "red") 


ggplot(df, aes(x = X8, y = Y1)) +
  geom_point() +
  geom_smooth(method = lm , se = FALSE, color = "red") 

################################################################################

# Scatter plots for all independent variables with Y2 to visualize correlation


ggplot(df, aes(x = X1, y = Y2)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red") 


ggplot(df, aes(x = X2, y = Y2)) +
  geom_point() +
  geom_smooth(method = lm , se = FALSE, color = "red") 


ggplot(df, aes(x = X3, y = Y2)) +
  geom_point() +
  geom_smooth(method = lm ,se = FALSE, color = "red") 

ggplot(df, aes(x = X4, y = Y2)) +
  geom_point() +
  geom_smooth(method = lm ,se = FALSE, color = "red") 


ggplot(df, aes(x = X5, y = Y2)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red") 

ggplot(df, aes(x = X6, y = Y2)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red") 


ggplot(df, aes(x = X7, y = Y2)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red") 


ggplot(df, aes(x = X8, y = Y2)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red") 



# To view IV distributions
par(mfrow = c(3,3))
hist(df$X1)
hist(df$X2)
hist(df$X3)
hist(df$X4)
hist(df$X5)
hist(df$X6)
hist(df$X7)
hist(df$X8)

################################################################################

# 4. Checking Multi-Collinearity between the independent variables (rounding to 2 decimal places).
# X1 with X2, X4, X5 
# X2 with X4 and X5
# X4 with X5 

round(cor(df),2)

#dropping X1 and checking Multi-Collinearity

round(cor(df[,c(-1)]),2)

#dropping X2 only and checking any changes to Multi-Collinearity table

round(cor(df[,c(-2)]),2)

# No changes noted
# Dropping X4 and checking Multi-Collinearity

round(cor(df[,c(-1,-4)]),2)

#dropping X2 as well and checking Multi-Collinearity

round(cor(df[,c(-1,-2,-4)]),2)


################################################################################

# 5. Dropping X1, X2 and X4
# Splitting data into training (80%) and testing sets (20%)

df1 <- df[,c(-1,-2,-4)]
df1


set.seed(123)
s <- sample(2, nrow(df1), replace = TRUE, prob = c(0.8,0.2))
train_df1 <- df1[s == 1,] 
test_df1 <- df1[s == 2,]

################################################################################

# 6. Building model for Y1 - Heating Load


m1 <- lm(Y1 ~ X3 + X5 + X6 + X7 + X8, train_df1)
summary(m1)

# Model is stat. significant; R Sq is 0.92; X6 is individually stat. insignificant
# Dropping X6 and running a re-iteration

m1 <- lm(Y1 ~ X3 + X5 + X7 + X8, train_df1)
summary(m1)


# Model is stat. significant; R Sq is 0.91; All IV are individually stat. significant


#Residual Analysis

# To check residuals distribution  - appear to be normally distributed
hist(m1$residuals)

# Checking Linearity and equal variance (no cone shape formations)
# Residuals are independent

plot(m1$residuals)
abline(a = 0, b = 0)


# Checking normal probaility plot - approximately a straight line

par(mfrow = c(2,2))  # To divide screen into 4 parts
plot(m1)              # residual plot   - linearity / equal var assumption is met   



# Making predictions and checking RMSE and R-Sq to check the model's performance

library(caret)

pred_m1 <- predict(m1, test_df1)
RMSE(pred_m1,test_df1$Y1)
R2(pred_m1,test_df1$Y1)
RMSE(pred_m1,test_df1$Y1)/mean(test_df1$Y1)

# R2 is 0.89, which means the observations and predicted values are highly correlated
# RMSE is 3.32 , representing an error rate of 14.2%
# Significant var. are wall area, overall height, glazing area and glazing area distribution.


################################################################################

# 7.Building model for Y2 - Cooling Load

m2 <- lm(Y2 ~ X3 + X5 + X6 + X7 + X8, train_df1)
summary(m2)

# Model is stat. significant; R Sq is 0.88; X6 and X8 is individually stat. insignificant
# Dropping X6 and running a re-iteration

m2 <- lm(Y2 ~ X3 + X5 + X7 + X8, train_df1)
summary(m2)

# Dropping X8 and running a re-iteration

m2 <- lm(Y2 ~ X3 + X5 + X7, train_df1)
summary(m2)

# Model is stat. significant; R Sq is 0.88; All IV are individually stat. significant

# Residual analysis

# To view residuals distribution  - appear to be normally distributed
hist(m2$residuals)


# Checking Linearity and equal variance (no cone shape formations)
# Residuals are independent

plot(m2$residuals)
abline(a = 0, b = 0)

# Checking normal probaility plot - approximately a straight line

par(mfrow = c(2,2))  # To divide screen into 4 parts
plot(m2)    # residual plot   - linearity / equal var assumption is met   


# Making predictions and checking RMSE and R-Sq to check the model's performance

library(caret)

pred_m2 <- predict(m2, test_df1)
RMSE(pred_m2,test_df1$Y2)
R2(pred_m2,test_df1$Y2)
RMSE(pred_m2,test_df1$Y2)/mean(test_df1$Y2)

# R2 is 0.85, which means the observes and predicted values are highly correlated
# RMSE is 3.66 , representing an error rate of 14.3%
# Significant var. are wall area, overall height and glazing area.









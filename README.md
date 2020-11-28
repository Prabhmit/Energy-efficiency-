# Table of Contents

1. Installations and package requirement
2. Project Motivation
3. File Descriptions
4. Analysis
5. Results
6. Licensing, Authors and Acknowledgments

# 1. Installations and package requirement

The code is in R. The additional libraries that have been used are tidyverse, readxl, ggplot and caret.

# 2. Project Motivation

Energy efficiency Data Set contains eight numerical features and two numerical targets variables. The dataset has 768 observations. 
The aim of this exercise is to use the eight features to build Multiple Linear Regression models to predict each of the two responses. 

# File Descriptions

The dataset is contained in a Microsoft Excel Worksheet named 'ENB2012_data'. It can also be accessed from:
Energy efficiency Data Set, UCI - Machine Learning Repository <https://archive.ics.uci.edu/ml/datasets/Energy+efficiency>

# Analysis

## Inspecting the data table and providing descriptive statistics including checking for any NA's/null or duplicate rows

The eight feature are:

X1 	Relative Compactness <br>
X2 	Surface Area <br>
X3 	Wall Area <br>
X4 	Roof Area <br>
X5 	Overall Height <br>
X6 	Orientation <br>
X7 	Glazing Area <br>
X8 	Glazing Area Distribution <br>

The two targets are:

Y1 	Heating Load <br>
Y2 	Cooling Load <br>

Attribute characteristics: Numeric (double)
Count (sample size): 768 <br>
No NA/null values or duplicate rows were identified. 

## Describing Heating Load and Cooling Load

Histogram for Heating Load and its mean (22.31) which is greater than its median (18.95) indicates its distribution is right skewed. Application of Empirical rule indicates no outliers. Its maximum and minimum values are 6.01 and 43.10 respectively.

Histogram for Cooling Load and its mean (24.59) which is greater than its median (22.08) indicates its distribution is right skewed. Application of Empirical rule indicates no outliers. Its maximum and minimum values are 10.90 and 48.03 respectively. Box plots for Heating and Cooling loads were also view to inspect their distributions.

## Inspecting correlation between the independent variables and dependent variables and inspecting multi-collinearity between the independent variables.

The following criterion has been applied to measure correlation and collinearity. Correlation > 0.8 = strong relation; Correlation < 0.4 = weak relation; else moderate

## Heating Load

Relative_Compactness: moderate positive linear relation <br>
Surface_Area: moderate negative linear relation <br>
Wall_Area: moderate positive linear relation <br>
Roof_Area: strong negative linear relation <br>
Overall_Height: strong positive linear relation <br>
Orientation: no linear relation <br>
Glazing_Area: weak positive linear relation <br>
Glazing_Area_Distribution: weak positive linear relation <br>

## Cooling Load

Relative_Compactness: moderate positive linear relation <br>
Surface_Area: moderate negative linear relation <br>
Wall_Area: moderate positive linear relation <br>
Roof_Area: strong negative linear relation <br>
Overall_Height: strong positive linear relation <br>
Orientation: no linear relation <br>
Glazing_Area: weak positive linear relation <br>
Glazing_Area_Distribution: weak positive linear relation <br>

As per the histograms for the distribution for all independent variables is uniform except Wall Area and Roof_Area which appear to be normal and left skewed respectively.

## Inspecting collinearity

The following variables have collinearity. The pairs with highest collinearity were dealt first:

Relative_Compactness, Surface_Area (-0.99)  
Both variables have strong correlation and have opposing influence on dependent variables. Surface_Area appears to have marginally stronger correlation with Heating_Load and Cooling_Load than Relative_Compactness. Therefore, dropping Relative_Compactness

Roof_Area, Overall_Height (-0.97)   
Both variables have strong correlation and appear to be opposite of each other. Overall_Height appears to have marginally stronger correlation with Heating_Load and Cooling_Load than Roof_Area. Therefore, dropping Roof_Area.

Relative_Compactness, Roof_Area (-0.87)

Relative_Compactness, Overall_Height (0.83)

Surface_Area, Roof_Area (0.88)

Surface_Area, Overall_Height (-0.86)

Relative_Compactness and Roof_Area were removed due to high collinearity with Surface_Area and Overall_Height respectively. Surface_Area and Overall_Height have stronger relation with the target variables and therefore were retained. However Surface_Area and Overall_Height also have high collinearity between them. As Overall_Height appears to have stronger correlation with Heating_Load and Cooling_Load than Surface_Area, Surface_Area has been dropped.

# Results

## Building model for Heating Load

The datset was split into training (80%) and testing sets (20%). After two iterations (dropping Orienation), the significant variables are Wall_Area, Overall_Height, Glazing_Area and Glazing_Area_Distribution. The model is overall statistically significant at 5% significance (p-value < 0.05) and the independent variables are individually statistically significant at 5% significance (p-value < 0.05). R-square is 0.92 which means approximately 92% of variation in Y1 can be explained by the variation in all the independent variables.

The Muiltiple Linear Regression model for predicting Heating_Load is:  Heating_Load = -24.23 + 0.051 * Wall_Area + 4.76 * Overall_Height + 19.25 * Glazing_Area + 0.24 * Glazing_Area_Distribution. 

## Residual Analysis

The residual plot indicates constant spread across the horizontal axis with no cone shape formations confirming residual linearity and equal variance. The residual histogram also indicates residuals appear to be normally distributed. The error terms across the horizontal axis do not appear to be related confirming independence of errors assumption is met. The normal probability plot is approximately a straight-line indicating errors are normally distributed.

## Making predictions and checking RMSE, error rate and R-square to check the model's performance on the test set

RMSE is 3.32 representing an error rate of 14.2%. R-square is 0.89, which means the observations and predicted values are highly correlated. Residual standard error of the model is 2.94, which means the actual Heating_Load values in the model deviate from the true regression line by approximately 2.94 units.


## Building model for Cooling Load

After three iterations (dropping Orientation and Glazing Area Distribution), the significant variables are Wall_Area, Overall_Height and Glazing_Area. The model is overall statistically significant at 5% significance (p-value < 0.05) and the independent variables are individually statistically significant at 5% significance (p-value < 0.05). R-square is 0.88 which means approximately 88% of variation in Cooling_Load can be explained by the variation in all the independent variables.

The final model for predicting Cooling_Load is: Cooling_Load = -15.84 + 0.04 * Wall_Area + 4.6 * Overall_Height + 14.8 * Glazing_Area 

## Residual Analysis

The residual plot indicates constant spread across the horizontal axis with no cone shape formations confirming residual linearity and equal variance. The residual histogram also indicates residuals appear to be normally distributed. The error terms across the horizontal axis do not appear to be related confirming independence of errors assumption is met. The normal probability plot is approximately a straight-line indicating errors are normally distributed.

## Making predictions and checking RMSE, error rate and R-square to check the model's performance on the test set.

RMSE is 3.66 representing an error rate of 14.3%. R-square is 0.85, which means the observations and predicted values are highly correlated. Residual standard error of the model is 3.22, which means the actual Cooling_Load values in the model deviate from the true regression line by approximately 3.22 units.

# Licensing, Authors and Acknowledgments
Energy efficiency Data Set, UCI - Machine Learning Repository <https://archive.ics.uci.edu/ml/datasets/Energy+efficiency>

James, Gareth, Daniela Witten, Trevor Hastie, and Robert Tibshirani. 2014. An Introduction to Statistical Learning: With Applications in R. Springer Publishing Company, Incorporated.

A. Tsanas, A. Xifara: 'Accurate quantitative estimation of energy performance of residential buildings using statistical machine learning tools', Energy and Buildings, Vol. 49, pp. 560-567, 2012

A. Tsanas, 'Accurate telemonitoring of Parkinsons disease symptom severity using nonlinear speech signal processing and statistical machine learning', D.Phil. thesis, University of Oxford, 2012 (which can be accessed from [Web Link])

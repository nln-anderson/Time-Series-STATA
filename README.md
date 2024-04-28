# Time Series Regression for Determining Company Sales
Knowing how to work with time series data is important skill for many forecasting models. My goal with this project was to learn time series techniques, like introducing lags, and familiarize myself with issue presented in time series models, such as serial correlation and spurios correlation. The research question for this model was "Does industry-wide sales have a signicicant impact on company sales over a 20-year time period?"

# Dataset
The dataset came from my Applied Econometric professor. It came with 3 features: company sales (denoted csales_original), industry sales (isales_original), and year. There were 20 instances in this dataset, which is small, but still useful for understanding time series techniques. 

# Feature Engineering
In Economics, it is important to recognize the difference between nominal and real values of money. In this dataset, the values for company sales and industry sales were in nominal value. Converting this to real values would be more benefical to the model, since increases in sales would then be compared with inflation, insuring that any increases are "real" and not due to inflation. To do this, I used the CPI index for the respective years in the model and adjusted the nominal values accordingly. 

# Static Model
Before exploring dynamic models, I first created a basic regression of company sales vs industry sales. This coefficient for industry sales was statistically significant. But, this wasn't the end of the story. In checking the residual plot, I saw that the residuals were not distributed indepentendly through time. That is, residuals were much higher towards the end of the 20 year period. 
{Insert Image}
I also confirmed the serial correlation using the tests, like Durbin-Watson d-statistic and Breusch-Godfrey LM test. 
{Insert Image}
Bases on the t-values, I could conclude that there was indeed serial correlation in the model. 

To fix this, I used Newey-West standard errors. In this model, the error structure is assumed to be heteroskedastic and possibly autocorrelated up to some lag. After applying Newey-West, the regression had statistically significant variables with no serial correlation. So how was this model different from the static model with serial correlation? The Newey-West model actually had different coefficients, and could be preceived as more accurate due to the lack of serial correlation.

# Dynamic Model
Another way to fix serial correlation is to introduce lagged variables to create a dynamic model. Put simply, the best way to estimate some variables is by looking at its previous value. In this case, the assumption is that company sales for a given year can be estimated by looking at previous years.

To determine how many lags should be used, I used a correlogram. 
{Insert Image}
Looking at the results, it can be seen that one lag of company sales has high auto correlation. The second lag displays much less auto correlation, and so I decided to stick with only one lag of company sales. Here are the results of the regression using one lagged variable.
{insert image}


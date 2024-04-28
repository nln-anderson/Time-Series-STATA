# Time Series Regression for Determining Company Sales
Knowing how to work with time series data is important skill for many forecasting models. My goal with this project was to learn time series techniques, like introducing lags, and familiarize myself with issue presented in time series models, such as serial correlation and spurios correlation. The research question for this model was "Does industry-wide sales have a signicicant impact on company sales over a 20-year time period?"

# Dataset
The dataset came from my Applied Econometric professor. It came with 3 features: company sales (denoted csales_original), industry sales (isales_original), and year. There were 20 instances in this dataset, which is small, but still useful for understanding time series techniques. 

# Feature Engineering and Experimentation
In Economics, it is important to recognize the difference between nominal and real values of money. In this dataset, the values for company sales and industry sales were in nominal value. Converting this to real values would be more benefical to the model, since increases in sales would then be compared with inflation, insuring that any increases are "real" and not due to inflation. To do this, I used the CPI index for the respective years in the model and adjusted the nominal values accordingly. 

Before exploring dynamic models, I first created a basic regression of company sales vs industry sales. This coefficient for industry sales was statistically significant. But, this wasn't the end of the story. In checking the residual plot, I saw that the residuals were not distributed indepentendly through time. That is, residuals were much higher towards the end of the 20 year period. 
{Insert Image}
I also confirmed the serial correlation using the tests, like Durbin-Watson d-statistic and Breusch-Godfrey LM test. 
{Insert Image}
Bases on the t-values, I could conclude that there was indeed serial correlation. 

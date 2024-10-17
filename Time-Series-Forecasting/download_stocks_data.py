"""Yahoo Finance is a popular source for historical stocks data that is 
vital for stocks trend analysis or time series forecasting for that matter.
This is a utility python script to download historic data of any stock from
Yahoo Finance using python and its library yfinance as a csv file."""

import yfinance as yf
import pandas as pd

# Define the ticker symbol of the stock
ticker = 'GOOGL'

start_date = '2023-10-17' # Decide on your own
end_date = '2024-10-17' # Decide on your own

data = yf.download(ticker, start=start_date, end=end_date)

data.to_csv(f'Time-Series-Forecasting\datasets\{ticker}_historical_data.csv')

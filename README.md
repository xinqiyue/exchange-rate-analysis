# Modeling the Impact of Commodity Prices and Interest Rates on the CAD/USD Exchange Rate: An Analysis of Key Drivers Using Bank Rate and BCPI

## Overview

This paper examines the key factors that influence the USD/CAD exchange rate, with a specific focus on the role of Canadian bank rates and commodity prices as measured by the Bank of Canada’s Commodity Price Index (BCPI). By applying regression analysis, the study explores the relationships between the exchange rate and variables such as the bank rate, total BCPI, and its specific components, including energy and metal prices. The findings suggest that higher bank rates and rising commodity prices, particularly in metals and total BCPI, are associated with a weaker Canadian dollar. In contrast, higher energy prices tend to strengthen the Canadian dollar. These results challenge traditional economic theories and provide valuable insights for policymakers and investors in understanding the economic drivers behind currency fluctuations.

## File Structure

The repo is structured as:

-   `data/simulated_data` contains the simulated dataset that was constructed.
-   `data/raw_data` contains the raw data as obtained from Bank of Canada (https://www.bankofcanada.ca/rates/).
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains datasheet of BCPI dataset, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download, clean and model data.


## Statement on LLM usage

Aspects of the code were written with the help of ChatGPT-4o. All part of the paper including title, abstract, introduction to Appendix were written with the help of ChatGpt-4o and the entire chat history is available in other/llm_usage/usage.txt.

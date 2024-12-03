# Starter folder

## Overview

The strategic prioritization of health determinants is crucial for understanding public health trends and informing policy decisions. Identifying and analyzing key factors effectively can have significant implications for health outcomes at the population level. This study focuses on the determinants of health from the 2019-2020 Canadian Community Health Survey (CCHS), aiming to understand the relationships between various demographic and lifestyle factors and health status.

We used a Bayesian linear regression model to analyze the data, which was obtained from the Canadian Community Health Survey (CCHS) dataset, accessible through Statistics Canada's website. The analysis explores the impact of predictors such as age, income, physical activity, and mental health indicators on self-reported health outcomes, providing valuable insights into public health policy and interventions.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from X.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

Parts of the code, including the implementation and analysis, were developed with the assistance of ChatGPT-4o. Additionally, ChatGPT-4o contributed to drafting the descriptions of the models, explaining their benefits, and detailing the tables and results. The full chat history documenting this collaboration is available in `other/llm_usage/usage.txt`.


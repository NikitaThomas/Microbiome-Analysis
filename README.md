# Microbiome-Analysis

This repository contains miscellaneous files exploring public microbiome related datasets and implementing techniques belonging to bioinformatics, machine learning, and data extraction/cleaning. 

## Public Datasets used: 

#### 1. Sample came from a longitudinal case study monitoring the gut microbial makeup of one infant over 2.5 years. Over 60 fecal samples were collected and informations such as diet and health status were recorded. Integrated QIIME pipeline to take sequence data to pick Operational Taxonomic Units (OTUs) and clusters in order to assign taxonomy and create an OTU table. OTU table can then be used to perform Machine Learning techniques on the data. 

* Data found here: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3063592/ 

#### 2. Sample of 107 premature infants were collected with already assigned taxonomic labels. Clinical features such as antibiotics taken, feeding type, and diagnosed diseases are available along with genomic data. Data cleaning and DBSCAN cluster analysis were performed on this dataset. 

* Data found here: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5758725/

#### 3. MIMIC III Dataset- Openly sourced de-identified EMR data from the critical care units of the Beth Israel Deaconess Medical Center between 2001 and 2012 containting 58,000 hospital admissions (7,875 belonging to neonates). Extracted all neonates diagnosed with Necrotizing Entercolitis via PostgreSQL. 


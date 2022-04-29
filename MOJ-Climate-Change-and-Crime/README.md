Met Office Climate Data Challenge May 2022

# How Will a Changing Climate Impact Crime and Justice in the UK? 

Subteams:
1)	Seasonal variation/long term crime trends.
2)	Climate change crime inequality
3)	Discomfort in courtrooms


## Seasonal variation/long term crime trends (SeaVarCriT)

### Data
Data only seems to be available at quarterly intervals.  Data sourced from here: https://www.gov.uk/government/statistics/police-recorded-crime-open-data-tables
In particular [Mar 2013-onwards](https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/1070772/prc-pfa-mar2013-onwards-tables-220422.ods) and [Mar 2008 - Mar 2012](https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/561334/prc-pfa-mar2008-mar2012-tabs.ods).


## Climate change crime inequality


## Discomfort in courtrooms


## Getting Started

A basic [Conda environment](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#) is available via `requirements.yml`, called `mocdc-moj`. 
To duplicate this environment do:
```shell
$ conda env create -f environment.yml
```
Then activate the environement with:
```shell
$ conda activate mocdc-moj
```

This environment contains a few core python libraries:

* python 3.7
* pandas 1.3.5
* iris 3.0.3
* jupyterlab 3.3.4
* matplotlib 3.5.1
* numpy 1.21.2
* pymc3 3.11.4
* scipy 1.7.3
* seaborn 0.11.2
* statsmodels 0.13.0

... and more. Inspect the yaml file for a complete list.  You are welcome to update or add libraries, but beware that packagae dependencies might cause complicated upgrade/downgrades which may cause breaking chages to code.

If you want to work in [Jupyter Lab](https://jupyter.org/), you can add this conda environment to your jupyter lab instance by:
```shell
$ conda activate mocdc-moj
(mocdc-moj) $ ipython kernel install --user --name=mocdc-moj
```

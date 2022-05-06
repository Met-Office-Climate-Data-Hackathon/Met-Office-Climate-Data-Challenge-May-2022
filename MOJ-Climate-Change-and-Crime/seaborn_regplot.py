import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

output_location = '/net/home/h04/spackman/test_data/hackathon/'

# Read crime data
df_crime_recent = pd.read_csv(
    "https://data.london.gov.uk/download/recorded_crime_summary/d2e9ccfc-a054-41e3-89fb-53c2bc3ed87a/MPS%20Borough%20Level%20Crime%20%28most%20recent%2024%20months%29.csv")
df_crime_hist = pd.read_csv('https://data.london.gov.uk/download/recorded_crime_summary/2bbd58c7-6be6-40ac-99ed-38c0ee411c8e/MPS%20Borough%20Level%20Crime%20%28Historical%29.csv')
df_crime = pd.concat([pd.melt(df_crime_recent, id_vars=['MajorText', 'MinorText', 'LookUp_BoroughName'], var_name='yearmonth'),
                      pd.melt(df_crime_hist, id_vars=['MajorText', 'MinorText', 'LookUp_BoroughName'], var_name='yearmonth')],
                     axis=0, ignore_index=True).sort_values(by=['yearmonth', 'LookUp_BoroughName', 'MajorText', 'MinorText']).reset_index()

df_crime['month'] = pd.to_datetime(df_crime['yearmonth'], format="%Y%m").dt.date
df_crime = df_crime.set_index('month')

# Read climate data
df_climate = pd.read_csv('climate_data/monthly_climate_actuals_London_2001_2022.csv')
df_climate_meantempdays = pd.read_csv('climate_data/monthly_meantemp_hotdays_London_2001_2022.csv')
df_climate_meantempdays = df_climate_meantempdays.rename(columns={'days_gt_15C': 'meantemp_days_gt_15C',
                                                                  'days_gt_20C': 'meantemp_days_gt_20C',
                                                                  'days_gt_25C': 'meantemp_days_gt_25C',
                                                                  'days_gt_30C': 'meantemp_days_gt_30C'})
df_climate_maxtempdays = pd.read_csv('climate_data/monthly_maxtemp_hotdays_London_2001_2022.csv')
df_climate_maxtempdays = df_climate_maxtempdays.rename(columns={'days_gt_15C': 'maxtemp_days_gt_15C',
                                                                'days_gt_20C': 'maxtemp_days_gt_20C',
                                                                'days_gt_25C': 'maxtemp_days_gt_25C',
                                                                'days_gt_30C': 'maxtemp_days_gt_30C'})

# Join max/mean temp num days
df_climate = pd.merge(df_climate, df_climate_meantempdays, left_index=True, right_index=True)
df_climate = pd.merge(df_climate, df_climate_maxtempdays, left_index=True, right_index=True)
df_climate['month'] = pd.to_datetime(df_climate['month'], format="%d/%m/%Y").dt.date
df_climate = df_climate.set_index('month')

# Aggregate crime by type
df_crime_major = pd.pivot_table(df_crime, values='value', index='month', columns='MajorText', aggfunc=np.sum)

# Merge climate vars onto crime dataset
df_crime_climate = pd.merge(df_crime_major, df_climate, left_index=True, right_index=True)

# Crime types
crime_types = ['Arson and Criminal Damage', 'Burglary', 'Robbery', 'Theft', 'Sexual Offences',
               'Violence Against the Person', 'Public Order Offences', 'Possession of Weapons',
               'Drug Offences', 'Miscellaneous Crimes Against Society', 'Vehicle Offences']

# Climate types
climate_types = ['mean_temperature', 'max_temperature', 'rainfall', 'raindays_gt_1mm',
                 'raindays_gt_10mm', 'sunshine_hours', 'humidity', 'meantemp_days_gt_15C',
                 'meantemp_days_gt_20C', 'meantemp_days_gt_25C', 'meantemp_days_gt_30C', 'maxtemp_days_gt_15C',
                 'maxtemp_days_gt_20C', 'maxtemp_days_gt_25C', 'maxtemp_days_gt_30C']

for crime_type in crime_types:
    for climate_type in climate_types:
        filename = output_location + 'plots/regplots/' + crime_type + '_' + climate_type + '.png'

        sns.regplot(x=crime_type, y=climate_type, data=df_crime_climate, logx=True)
        plt.savefig(filename)
        plt.close()
# Reading the data in 
install.packages('readxl')
library(readxl)
library(magrittr)

# Test run with 4th quarter, 2021
library(openxlsx)
load <- read.xlsx('/Users/sarveshwarisingh/Desktop/met hackathon/policeforceareatabledec21.xlsx', sheet='Table P1a Oct- Dec 21')
load
# Removing descriptive rows
library(dplyr)
load1 <- load %>%
  filter(!row_number() %in% c(1, 2,3,4, 5))

# Converting 
install.packages('janitor')
library(janitor)
load2 <- load1%>%
  row_to_names(row_number = 1)

# Categorising
load3 <- load2 %>%
  mutate(Region = rep(c("England", "North East", "North West", "Yorkshire and the Humber", "East Midlands", "West Midlands Region", "East", "London", "South East", "South West", "Wales", "British Transport Police"),times=c(2, 4,6,5,6,5,7,3,6,6,5,1)))
tail(load3, 30)
# Removing aggregated information
load4 <- load3%>%
  filter(!row_number() %in% c(1,2,3, 13, 18, 24, 29, 36,39, 51 ))
load4[14,2] <- "Derbyshire"
load4[43, 2] <- "Gwent"
load4
# Writing to CSV
write.csv(load4,"/Users/sarveshwarisingh/Desktop/met hackathon/dec_21.csv", row.names = FALSE)


# Proper datasets - 2016
tail(dec_2016.3, 10)
dec_2016.1 <- read.xlsx('/Users/sarveshwarisingh/Desktop/met hackathon/policeforceareatablesyearendingdec16.xlsx', sheet='Table P1')
dec_2016.2 <- dec_2016.1 %>%
  filter(!row_number() %in% c(1, 2,4, 61, 62, 63, 64, 65))
dec_2016.3 <- dec_2016.2%>%
  row_to_names(row_number = 1)
dec_2016.4 <- dec_2016.3 %>%
  filter(!row_number() %in% c(57,58,59,60))
dec_2016.5 <-  dec_2016.4%>%
  mutate(Region = rep(c("England", "North East", "North West", "Yorkshire and the Humber", "East Midlands", "West Midlands Region", "East", "London", "South East", "South West", "Wales", "British Transport Police"),times=c(2, 4,6,5,6,5,7,3,6,6,5,1)))
dec_2016.6 <- dec_2016.5%>%
  filter(!row_number() %in% c(1,2,3, 13, 18, 24, 29, 36,39, 51))
dec_2016.6[,2]
dec_2016.6[27,2] <- "Norfolk"
dec_2016.6[28, 2] <- "Suffolk"
dec_2016.6[12, 2] <- "South Yorkshire"
colnames(dec_2016.6)[3] <- "Total recorded crime (excluding fraud)"
write.csv(dec_2016.6,"/Users/sarveshwarisingh/Desktop/met hackathon/data_2016.csv", row.names = FALSE)


# Proper datasets - 2017
dec_2017.1 <- read.xlsx('/Users/sarveshwarisingh/Desktop/met hackathon/policeforceareatablesyearendingdec2017.xlsx', sheet='Table P1')
dec_2017.2 <- dec_2017.1 %>%
  filter(!row_number() %in% c(1, 2,4, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70))
dec_2017.3 <- dec_2017.2%>%
  row_to_names(row_number = 1)
dec_2017.4 <- dec_2017.3
dec_2017.4["Region"] <- rep(c("England", "North East", "North West", "Yorkshire and the Humber", "East Midlands", "West Midlands Region", "East", "London", "South East", "South West", "Wales", "British Transport Police"),times=c(2,4,6,5,6,5,7,3,6,6,5,1))
library(dplyr)
dec_2017.5 <- dec_2017.4[-c(1,2,3, 7,13, 18, 24, 29, 36,39, 45,51),]
dec_2017.5[,2]
dec_2017.5[19,2] <- "Warwickshire"
dec_2017.5[20, 2] <- "West Mercia"
colnames(dec_2017.5)[3] <- "Total recorded crime (excluding fraud)"
colnames(dec_2017.5)[8]  <- "Stalking and harassment"
colnames(dec_2017.5)[9]  <- "Death or serious injury - unlawful driving"
colnames(dec_2017.5)[14]  <- "Domestic burglary"
colnames(dec_2017.5)[15]  <- "Non-domestic burglary"
write.csv(dec_2017.5,"/Users/sarveshwarisingh/Desktop/met hackathon/data_2017.csv", row.names = FALSE)

# Proper datasets - 2018
dec_2018.1 <- read.xlsx('/Users/sarveshwarisingh/Desktop/met hackathon/policeforceareatablesyearendingdecember2018.xlsx', sheet='Table P1')
dec_2018.2 <- dec_2018.1 %>%
  filter(!row_number() %in% c(1, 2,4, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70))
dec_2018.3 <- dec_2018.2%>%
  row_to_names(row_number = 1)
dec_2018.4 <- dec_2018.3
dec_2018.4["Region"] <- rep(c("England", "North East", "North West", "Yorkshire and the Humber", "East Midlands", "West Midlands Region", "East", "London", "South East", "South West", "Wales", "British Transport Police"),times=c(2,4,6,5,6,5,7,3,6,6,5,1))
dec_2018.5 <- dec_2018.4[-c(1,2,3, 7,13, 18, 24, 29, 36,39, 45,51),]
dec_2018.5[,2]
dec_2018.5[7,2] <- "Lancashire"
dec_2018.5[35, 2] <- "Avon and Somerset"
colnames(dec_2018.5)
colnames(dec_2018.5)[3] <- "Total recorded crime (excluding fraud)"
colnames(dec_2018.5)[8]  <- "Stalking and harassment"
colnames(dec_2018.5)[9]  <- "Death or serious injury - unlawful driving"
colnames(dec_2018.5)[14]  <- "Residential burglary"
colnames(dec_2018.5)[15]  <- "Non-residential  burglary"
write.csv(dec_2018.5,"/Users/sarveshwarisingh/Desktop/met hackathon/data_2018.csv", row.names = FALSE)

# Getting rid of unlawful driving and stalking and harrassment from 2017 and 2018
drops <- c("Stalking and harassment","Death or serious injury - unlawful driving")
dec_2017.fewer <- dec_2017.5[,!(names(dec_2017.5) %in% drops)]
dec_2018.fewer <- dec_2018.5[,!(names(dec_2018.5) %in% drops)]
colnames(dec_2017.fewer)[23] <- "Miscellaneous crimes"  
colnames(dec_2017.fewer)[13] <- "Non-domestic burglary"  
colnames(dec_2018.fewer)[13] <- "Non-domestic burglary"  
colnames(dec_2018.fewer)[12] <-  "Domestic burglary"   
dec_2017.fewer <- dec_2017.fewer[-21,]
dec_2018.fewer <- dec_2018.fewer[-21,]
dec_2016.fewer <- dec_2016.6[-c(4,22, 36),]
combined <- rbind(dec_2016.fewer, dec_2017.fewer, dec_2018.fewer)

nrow(dec_2016.fewer)
nrow(dec_2017.fewer)
nrow(dec_2018.fewer)
years <- rep(c(2016, 2017, 2018), times=c(43,43,43))
years
combined.y <- combined%>%
  mutate(Year = years)
write.csv(combined.y,"/Users/sarveshwarisingh/Desktop/met hackathon/combined_crime.csv", row.names = FALSE)


# Proper datasets for rates

# 2016
dec_2016.1.r <- read.xlsx('/Users/sarveshwarisingh/Desktop/met hackathon/policeforceareatablesyearendingdec16.xlsx', sheet='Table P3')
dec_2016.2.r <- dec_2016.1.r %>%
  filter(!row_number() %in% c(1, 2,4, 60,61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72))
dec_2016.3.r <- dec_2016.2.r%>%
  row_to_names(row_number = 1)
dec_2016.4.r <- dec_2016.3.r
dec_2016.4.r["Region"] <- rep(c("England", "North East", "North West", "Yorkshire and the Humber", "East Midlands", "West Midlands Region", "East", "London", "South East", "South West", "Wales"),times=c(2, 4,6,5,6,5,7,3,6,6,5))
dec_2016.4.r <- dec_2016.4.r[-c(1,2,3, 7,13, 18, 24, 29, 36,39, 45,51),]
dec_2016.4.r[,2]
dec_2016.4.r[26,2] <- "Norfolk"
dec_2016.4.r[27, 2] <- "Suffolk"
dec_2016.4.r[28, 2] <- "London, City of"
colnames(dec_2016.4.r)[5] <- "Total recorded crime (excluding fraud)"
colnames(dec_2016.4.r)[14] <- "Domestic burglary"
colnames(dec_2016.4.r)[15] <- "Domestic burglary (households)"
write.csv(dec_2016.4.r,"/Users/sarveshwarisingh/Desktop/met hackathon/data_2016_rates.csv", row.names = FALSE)

# 2017
dec_2017.1.r <- read.xlsx('/Users/sarveshwarisingh/Desktop/met hackathon/policeforceareatablesyearendingdec2017.xlsx', sheet='Table P3')
dec_2017.2.r <- dec_2017.1.r %>%
  filter(!row_number() %in% c(1, 2,4, 60,61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72,73))
dec_2017.3.r <- dec_2017.2.r%>%
  row_to_names(row_number = 1)
dec_2017.4.r <- dec_2017.3.r
dec_2017.4.r["Region"] <- rep(c("England", "North East", "North West", "Yorkshire and the Humber", "East Midlands", "West Midlands Region", "East", "London", "South East", "South West", "Wales"),times=c(2, 4,6,5,6,5,7,3,6,6,5))
dec_2017.4.r <- dec_2017.4.r[-c(1,2,3, 7,13, 18, 24, 29, 36,39, 45,51),]
dec_2017.4.r[,2]
dec_2017.4.r[19,2] <- "Warwickshire"
dec_2017.4.r[20, 2] <- "West Mercia"
dec_2017.4.r[28, 2] <- "London, City of"
colnames(dec_2017.4.r)
colnames(dec_2017.4.r)[5] <- "Total recorded crime (excluding fraud)"
colnames(dec_2017.4.r)[16] <- "Domestic burglary"
colnames(dec_2017.4.r)[17] <- "Domestic burglary (households)"
colnames(dec_2017.4.r)[18] <- "Non-domestic burglary"
write.csv(dec_2017.4.r,"/Users/sarveshwarisingh/Desktop/met hackathon/data_2017_rates.csv", row.names = FALSE)

# 2018
dec_2018.1.r <- read.xlsx('/Users/sarveshwarisingh/Desktop/met hackathon/policeforceareatablesyearendingdecember2018.xlsx', sheet='Table P3')
dec_2018.2.r <- dec_2018.1.r %>%
  filter(!row_number() %in% c(1, 2,4, 60,61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72))
dec_2018.3.r <- dec_2018.2.r%>%
  row_to_names(row_number = 1)
dec_2018.4.r <- dec_2018.3.r
dec_2018.4.r["Region"] <- rep(c("England", "North East", "North West", "Yorkshire and the Humber", "East Midlands", "West Midlands Region", "East", "London", "South East", "South West", "Wales"),times=c(2, 4,6,5,6,5,7,3,6,6,5))
dec_2018.4.r <- dec_2018.4.r[-c(1,2,3, 7,13, 18, 24, 29, 36,39, 45,51),]
dec_2018.4.r[,2]
dec_2018.4.r[28, 2] <- "London, City of"
colnames(dec_2018.4.r)
colnames(dec_2018.4.r)[5] <- "Total recorded crime (excluding fraud)"
colnames(dec_2018.4.r)[16] <- "Domestic burglary"
colnames(dec_2018.4.r)[17] <- "Domestic burglary (households)"
colnames(dec_2018.4.r)[18] <- "Non-domestic burglary"
write.csv(dec_2018.4.r,"/Users/sarveshwarisingh/Desktop/met hackathon/data_2018_rates.csv", row.names = FALSE)

# Reading the Gini data in 
gini1 <- read.csv(file='/Users/sarveshwarisingh/Desktop/met hackathon/Gini_coeff.csv')
gini2 <- gini1%>%
  filter(!row_number() %in% c(1, 2,3,4,5))%>%
  row_to_names(row_number = 1)
gini2

# Joining the datasets together
table(dec_2016.fewer[,24])

# Plots
library(dplyr)
indices <- read.csv(file='/Users/sarveshwarisingh/Desktop/met hackathon/indices.csv')
colnames(indices)
lsoa <- indices%>%
  group_by(Local.Authority.District.name..2019.)%>%
  summarise(mean_income_score = mean(Income.Score..rate.), 
            mean_employment_score = mean(Employment.Score..rate.), 
            mean_health_score = mean(Health.Deprivation.and.Disability.Score), 
            mean_education_score = mean(Education..Skills.and.Training.Score), 
            mean_housing_score = mean(Barriers.to.Housing.and.Services.Score), 
            mean_environment_score = mean(Living.Environment.Score))
colnames(lsoa)[1] <- "Name"
View(county)
county <- read.csv(file='/Users/sarveshwarisingh/Desktop/met hackathon/LA_TO_COUNTY.csv')
colnames(county)[3] <- "Name"

indices.1 <- left_join(lsoa, county, by="Name")
indices.2 <- indices.1[,-c(8,9,10)]
colnames(indices.2)[8] <- "County"
indices.2[is.na(indices.2$County),]


library(sp)
library(rgdal)
data.shape <- readOGR(dsn="/Users/sarveshwarisingh/Desktop/met hackathon/Local_Authority_Districts_(December_2021)_GB_BFC")
library(magrittr)
library(broom)
data.shape_tidy <- tidy(data.shape)
table(data.shape_tidy$id)
library(ggplot2)
ggplot(data.shape_tidy, aes(x=long, y=lat,group=group))+
  geom_polygon(colour="black", size=0.1, fill="honeydew")+
  coord_equal()



# Unemployment
unemp <- indices.2[,c(1,3)]
write.csv(unemp,"/Users/sarveshwarisingh/Desktop/met hackathon/employment_score.csv", row.names = FALSE)
tidy.unemp <- data.shape_tidy
tidy.unemp["group"] <- 

# Income/Poverty
poverty <- indices.2[,c(1,2)]
write.csv(poverty,"/Users/sarveshwarisingh/Desktop/met hackathon/poverty_score.csv", row.names = FALSE)

# Health
health <- indices.2[,c(1,4)]
write.csv(health,"/Users/sarveshwarisingh/Desktop/met hackathon/health_score.csv", row.names = FALSE)


# Education and training
skills <- indices.2[,c(1,5)]
write.csv(skills,"/Users/sarveshwarisingh/Desktop/met hackathon/skills_score.csv", row.names = FALSE)

# housing
shelter <- indices.2[,c(1,6)]
write.csv(shelter,"/Users/sarveshwarisingh/Desktop/met hackathon/shelter_score.csv", row.names = FALSE)

# environment
env <- indices.2[,c(1,7)]
write.csv(env,"/Users/sarveshwarisingh/Desktop/met hackathon/env_score.csv", row.names = FALSE)

# local authority districts geo
la_geo <- read.csv(file='/Users/sarveshwarisingh/Desktop/met hackathon/LACSV.csv')
colnames(la_geo)[3] <- "Name"

# merging data together county data with geographics info
merged_demographics <- left_join(lsoa, la_geo, by="Name" )[complete.cases(left_join(lsoa, la_geo, by="Name" )),]
ggplot()

lsoa_2 <- indices%>%
  group_by(indices$Local.Authority.District.code..2019.)%>%
  summarise(mean_income_score = mean(Income.Score..rate.), 
            mean_employment_score = mean(Employment.Score..rate.), 
            mean_health_score = mean(Health.Deprivation.and.Disability.Score), 
            mean_education_score = mean(Education..Skills.and.Training.Score), 
            mean_housing_score = mean(Barriers.to.Housing.and.Services.Score), 
            mean_environment_score = mean(Living.Environment.Score))


merged_geography <- inner_join(data.shape_tidy, la_geo, by = c("id" = "OBJECTID"))
head(merged_geography)
data.shape_tidy$id <- as.integer(data.shape_tidy$id)
merged_colour <- inner_join(merged_geography, lsoa_2, by = c("LAD21CD" = "indices$Local.Authority.District.code..2019."))
merged_colour
library(dplyr)
library(ggplot2)

# Unemployment MAP
ggplot() +
  geom_polygon(data = merged_colour, aes(fill = mean_employment_score, x = long, y = lat, group = group))

# Health MAP
ggplot() +
  geom_polygon(data = merged_colour, aes(fill = mean_health_score, x = long, y = lat, group = group))

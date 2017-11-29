#Load libraries
library("lubridate")
library("plyr")
library("stringr")
library("pastecs")
library("oce")

install.packages("pracma")
library("pracma")


#Import Dataset

C <- copepod_2160000_compilation

C

#Subset year

C99 <- subset(C, C$YEAR == 1999)

#Date format for ArcGIS

C99$YY <- as.integer(C99$YEAR)
C99$MM <- as.integer(C99$MON)
C99$M <- sprintf("%02d", MM)
C99$DD <- as.integer(C99$DAY)
C99$D <- sprintf("%02d", DD)

C99$Date <- str_c(C99$YY,"-",C99$M,"-",C99$D)

#Normalize count data
C99$V <- as.numeric(C99$`VALUE-per-volu`)
C99$NPerVol <- nthroot(C99$V, 4)

#Sum per sampling site
VolSum <- aggregate(C99$NPerVol, by = list(C99$LATITUDE, C99$LONGITDE), FUN = sum)


#Write CSV
write.csv(C99, "Diatoms.csv")
write.csv(VolSum, "VolSum.csv")

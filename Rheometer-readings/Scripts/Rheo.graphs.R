getwd()
install.packages('janitor')
install.packages('expss')
library("readxl"); library("xlsx"); library("janitor"); library("expss"); library("ggplot2")
library("tidyverse")


SiphAmp <- read.csv("Jan23-2020_SiphTest/SweeneyLab_jan23-2020_siph_ampsweep.csv",col.names = x,y)
SiphAmp <- read.csv(header=T, sep=",",file="/Jan23-2020_SiphTest/SweeneyLabsiphjan232020attempt2.csv",col.names = x,y)

feb9freqsweepforskalialive.necto.sandpaperbottom <- read.xlsx2("./rheo/feb9_freqsweep.xlsx", sheetIndex =1, 
                                                               as.data.frame = T, header=F, startRow = 4,
                                                               stringsAsFactors=FALSE)
feb9freqsweepforskalialive.necto.sandpaperbottom
units <- feb9freqsweepforskalialive.necto.sandpaperbottom[3,]
units
names(feb9freqsweepforskalialive.necto.sandpaperbottom) <- c("PointNo.","TestTime","AverageTime","DeflectionAngle",
                                                             "Torque","NormalForce","Gap","Frequency","ShearStrain",
                                                             "ShearStress","StorageModulus","LossModulus","StorageCompliance",
                                                             "LossCompliance","ShearStrainWF","ShearStressWF")
nounits <- feb9freqsweepforskalialive.necto.sandpaperbottom[-(1:3), ]

freq <- drop_empty_rows(as.data.frame(as.array(nounits$Frequency)))
freq <- as.numeric(unlist(freq[1]))
LossMod <- drop_empty_rows(as.data.frame(as.array(nounits$`LossModulus`)))
LossMod <- as.numeric(unlist(LossMod[1]))
StorMod <- drop_empty_rows(as.data.frame(as.array(nounits$`StorageModulus`)))
StorMod <- as.numeric(unlist(StorMod[1]))

is.numeric(LossMod)
plot(freq, LossMod)

all <- cbind(freq, LossMod, StorMod)
all <- as.data.frame(all)


colors <- c("LossMod"="blue","StorMod"="red")

q <- ggplot(all, aes(x=freq)) + 
                geom_line(aes(y=LossMod, color="LossMod"), size=1.5) + 
                geom_line(aes(y=StorMod, color="StorMod"), size=1.5) + 
                labs(x='Frequency (Hz)',
                    y = "Pa",
                    color="Legend") +
                scale_color_manual(values=colors) +
                labs("Forskalia Live Nectophore") +
                theme(legend.justification = c("right", "top"),
                      plot.title = element_text(hjust = 0.5, face="bold"), 
                      legend.position="right", 
                      legend.title = element_text(colour = "black",size=16) +
                      scale_color_discrete(name="Variables"))
q






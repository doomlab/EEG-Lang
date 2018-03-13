setwd("~/OneDrive - Missouri State University/RESEARCH/2 projects/EEG-Lang/paper")
master = read.csv("graph_data.csv")

library(pracma)
master$area = apply(master[ , 303:603], 1, function(x){
  trapz(300:600, (x-6))
})

tapply(master$area, list(master$Task, master$Stimuli.Type), mean)

list.files()

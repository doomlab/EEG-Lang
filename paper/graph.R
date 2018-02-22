
setwd("~/GitHub/EEG-Lang/paper")
graph_data <- read_csv("graph_data.csv")
library(readr)
library(reshape2)
library(ggplot2)
library(cowplot)
theme = theme(panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank(), 
              panel.background = element_blank(), 
              axis.line.x = element_line(colour = "black"), 
              axis.line.y = element_line(colour = "black"), 
              legend.key = element_rect(fill = "white"),
              text = element_text(size = 15),
              legend.position='none',
              plot.margin = unit(c(0.3,1,0.3,0.3),'cm'))
colnames(graph_data)[1:3] = c('Task','Stimuli','Site')
graph_data$Task = factor(graph_data$Task)
graph_data$Stimuli = factor(graph_data$Stimuli)
graph_data$Site = factor(graph_data$Site)
longdata = melt(graph_data,
                   id = c('Task','Stimuli','Site'))
longdata$variable = as.numeric(longdata$variable)
ldt_dat = subset(longdata, Task == 'LDT')
lst_dat = subset(longdata, Task == 'LST')
cpz_ldt = subset(ldt_dat, Site == 'CPZ')
cz_ldt = subset(ldt_dat, Site == 'CZ')
fcz_ldt = subset(ldt_dat, Site == 'FCZ')
fz_ldt = subset(ldt_dat, Site == 'FZ')
pz_ldt = subset(ldt_dat, Site == 'PZ')
cpz_lst = subset(lst_dat, Site == 'CPZ')
cz_lst = subset(lst_dat, Site == 'CZ')
fcz_lst = subset(lst_dat, Site == 'FCZ')
fz_lst = subset(lst_dat, Site == 'FZ')
pz_lst = subset(lst_dat, Site == 'PZ')
cpz_ldt_g = ggplot(data=cpz_ldt, aes(x=variable, y = value, group = Stimuli)) + 
  geom_line(aes(color=Stimuli),size=1.3) +
  scale_colour_grey(start = 0, end = .6) +
  scale_y_continuous(name = 'Amplitude', limits = c(-2,6)) +
  scale_x_discrete(name = 'CPz', limits = c(175,350,525,700)) +
  geom_hline(yintercept = 0) +
  theme
cz_ldt_g = ggplot(data=cz_ldt, aes(x=variable, y = value, group = Stimuli)) + 
  geom_line(aes(color=Stimuli),size=1.3) +
  scale_colour_grey(start = 0, end = .6) +
  scale_y_continuous(name = 'Amplitude', limits = c(-2,6)) +
  scale_x_discrete(name = 'Cz', limits = c(175,350,525,700)) +
  geom_hline(yintercept = 0) +
  theme
fcz_ldt_g = ggplot(data=fcz_ldt, aes(x=variable, y = value, group = Stimuli)) + 
  geom_line(aes(color=Stimuli),size=1.3) +
  scale_colour_grey(start = 0, end = .6) +
  scale_y_continuous(name = 'Amplitude', limits = c(-2,6)) +
  scale_x_discrete(name = 'FCz', limits = c(175,350,525,700)) +
  geom_hline(yintercept = 0) +
  theme
fz_ldt_g = ggplot(data=fz_ldt, aes(x=variable, y = value, group = Stimuli)) + 
  geom_line(aes(color=Stimuli),size=1.3) +
  scale_colour_grey(start = 0, end = .6) +
  scale_y_continuous(name = 'Amplitude', limits = c(-2,6)) +
  scale_x_discrete(name = 'Fz', limits = c(175,350,525,700)) +
  geom_hline(yintercept = 0) +
  theme
pz_ldt_g = ggplot(data=pz_ldt, aes(x=variable, y = value, group = Stimuli)) + 
  geom_line(aes(color=Stimuli),size=1.3) +
  scale_colour_grey(start = 0, end = .6) +
  scale_y_continuous(name = 'Amplitude', limits = c(-2,6)) +
  scale_x_discrete(name = 'Pz', limits = c(175,350,525,700)) +
  geom_hline(yintercept = 0) +
  theme
temp = ggplot(data=pz_ldt, aes(x=variable, y = value, group = Stimuli)) + 
  geom_line(aes(color=Stimuli),size=1.3) +
  scale_colour_grey(start = 0, end = .6) 
mylegend <- get_legend(temp)
ldt_grid = plot_grid(cpz_ldt_g,cz_ldt_g,fcz_ldt_g,
        fz_ldt_g,pz_ldt_g,ncol=2)
ldt_plot = ldt_grid + draw_grob(mylegend, 2/3,0,1/3,0.4)
cpz_lst_g = ggplot(data=cpz_lst, aes(x=variable, y = value, group = Stimuli)) + 
  geom_line(aes(color=Stimuli),size=1.3) +
  scale_colour_grey(start = 0, end = .6) +
  scale_y_continuous(name = 'Amplitude', limits = c(-2,6)) +
  scale_x_discrete(name = 'CPz', limits = c(175,350,525,700)) +
  geom_hline(yintercept = 0) +
  theme
cz_lst_g = ggplot(data=cz_lst, aes(x=variable, y = value, group = Stimuli)) + 
  geom_line(aes(color=Stimuli),size=1.3) +
  scale_colour_grey(start = 0, end = .6) +
  scale_y_continuous(name = 'Amplitude', limits = c(-2,6)) +
  scale_x_discrete(name = 'Cz', limits = c(175,350,525,700)) +
  geom_hline(yintercept = 0) +
  theme
fcz_lst_g = ggplot(data=fcz_lst, aes(x=variable, y = value, group = Stimuli)) + 
  geom_line(aes(color=Stimuli),size=1.3) +
  scale_colour_grey(start = 0, end = .6) +
  scale_y_continuous(name = 'Amplitude', limits = c(-2,6)) +
  scale_x_discrete(name = 'FCz', limits = c(175,350,525,700)) +
  geom_hline(yintercept = 0) +
  theme
fz_lst_g = ggplot(data=fz_lst, aes(x=variable, y = value, group = Stimuli)) + 
  geom_line(aes(color=Stimuli),size=1.3) +
  scale_colour_grey(start = 0, end = .6) +
  scale_y_continuous(name = 'Amplitude', limits = c(-2,6)) +
  scale_x_discrete(name = 'Fz', limits = c(175,350,525,700)) +
  geom_hline(yintercept = 0) +
  theme
pz_lst_g = ggplot(data=pz_lst, aes(x=variable, y = value, group = Stimuli)) + 
  geom_line(aes(color=Stimuli),size=1.3) +
  scale_colour_grey(start = 0, end = .6) +
  scale_y_continuous(name = 'Amplitude', limits = c(-2,6)) +
  scale_x_discrete(name = 'Pz', limits = c(175,350,525,700)) +
  geom_hline(yintercept = 0) +
  theme
lst_grid = plot_grid(cpz_lst_g,cz_lst_g,fcz_lst_g,
                     fz_lst_g,pz_lst_g,ncol=2)
lst_plot = lst_grid + draw_grob(mylegend, 2/3,0,1/3,0.4)


ldt_plot
lst_plot

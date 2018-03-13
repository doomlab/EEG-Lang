
##import data
Peak <- read.csv("C:/Users/John/Desktop/Peak.csv")

##Non-Recursive Procedure with Moving Criterion
## 15 = 2.326  20 = 2.391  average equals 2.3585

options(scipen=999)
library(nlme)
library(reshape)

#melt
Peak = Peak[ , -c(1) ]
longdata = melt(Peak,
                id = c("site", "type.1", "task"), 
                measured = c("X1","X2","X3","X4","X5","X6",
                             "X7","X8","X9","X10","X11",
                             "X12","X13","X14","X15","X16",
                             "X17","X18"))
colnames(longdata) = c("site","type","task","partno", "peak")
table(longdata$type)
longdata$type=factor(longdata$type,
                     levels = c("unrelated","nonwords","semantic","associative"))
table(longdata$type)
longdata$type=factor(longdata$type,
                     labels = c("UR", "NW", "LH", "HL"),
                     levels = c("unrelated","nonwords","semantic","associative"))
table(longdata$type)


##non recursive outliers
zscore = unsplit(lapply(split(longdata$peak, list(longdata$partno, longdata$task)),
                        scale),list(longdata$partno, longdata$task))
summary(abs(zscore) < 2.3585) ##see how many outliers
noout = subset(longdata, abs(zscore) < 2.3585) ##exclude outliers



##MLM

##intercept only model
model1 = gls(peak ~ 1, 
             data = noout, 
             method = "ML", 
             na.action = "na.omit")
summary(model1)

##random intercept only model
model2 = lme(peak ~ 1, 
             data = noout, 
             method = "ML", 
             na.action = "na.omit",
             random = ~1|partno)
summary(model2)

anova(model1,model2)
##significant...on to fixed effects



##adding site
model3 = lme(peak ~ site, 
             data = noout, 
             method = "ML", 
             na.action = "na.omit",
             random = ~1|partno)
summary(model3)
plot.lme(model3)


##adding site and task 
model4 = lme(peak ~ site + task, 
             data = noout, 
             method = "ML", 
             na.action = "na.omit",
             random = ~1|partno)
summary(model4)
plot.lme(model4)

##adding site, task and type 
model5 = lme(peak ~ site + task + type, 
             data = noout, 
             method = "ML", 
             na.action = "na.omit",
             random = ~1|partno)
summary(model5)
plot.lme(model5)

#adding interaction with site as covariate
model6 = lme(peak ~ site + task*type,
             data = noout,
             method = "ML",
             na.action = "na.omit",
             random = ~1|partno)
summary(model6)
plot.lme(model6)


##compare models
anova(model1,model2,model3,model4,model5,model6)

with(noout,tapply(peak, list(type,task,site), mean,na.rm=T))
hist(noout$peak)

##simple slopes 

##split on task
LDT = subset(noout, task == "ldt")
LST = subset(noout, task == "lst")

LDTmodel = lme(peak ~ site + type, 
               data = LDT, 
               method = "ML", 
               na.action = "na.omit",
               random = ~1|partno)
summary(LDTmodel)

LSTmodel = lme(peak ~ site + type,
               data = LST,
               method = "ML",
               na.action = "na.omit",
               random = ~1|partno)
summary(LSTmodel)

####graph####
library(ggplot2)
theme = theme(panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank(), 
              panel.background = element_blank(), 
              axis.line.x = element_line(color = "black"),
              axis.line.y = element_line(color = "black"),
              text = element_text(size=20))

fitted = fitted(model6)
graphdata = na.omit(noout)
scatter = ggplot(graphdata, aes(fitted, peak))
scatter +
  theme + 
  geom_point() +
  geom_smooth(method = "lm", color = "black") +
  xlab("Task + Type") +
  ylab("Peak") 


##descriptives
tapply(noout$peak, list(noout$type, noout$task), mean)
tapply(noout$peak, list(noout$type, noout$task), sd)
tapply(noout$peak, list(noout$type, noout$task), length)

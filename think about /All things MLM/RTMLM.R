## "by changing the criterion cutoff required for outlier
##  removal as a function of sample size, outlier 
##  elimination can be made to produce results that are
##  independent of sample size, which eliminates one 
##  major difficulty with these procedures pointed out
## by Miller (1991) "   Van Selst & Jolicoeur (1994)

## adjusting the criterion according to sample size
## is the method of choice
##Non-Recursive Procedure with Moving Criterion
## 15 = 2.326  20 = 2.391  average equals 2.3585

##Modified Recursive Procedure with Moving Criterion
## 15 = 3.75  20 = 3.64  average equals 3.695
## repeat until either no outliers or sample size falls
##below 4

data <- read.csv("C:/Users/John/Desktop/data.csv")

options(scipen=999)
library(nlme)
library(reshape)
#melt
longdata = melt(data,
                 id = c("task","type"), 
                 measured = c("X1","X2","X3","X4","X5","X6",
                              "X7","X8","X9","X10","X11",
                              "X12","X13","X14","X15","X16",
                              "X17","X18"))
colnames(longdata) = c("task","type","partno","RT")
longdata$type=factor(longdata$type,
                     levels = c("UR","LH","NW","HL"))

##non recursive outliers
zscore = unsplit(lapply(split(longdata$RT, list(longdata$partno, longdata$task)),
                        scale),list(longdata$partno, longdata$task))



summary(abs(zscore) < 2.3585) ##see how many outliers
noout = subset(longdata, abs(zscore) < 2.3585) ##exclude outliers

##modified recursive
#round1
zscore2 = unsplit(lapply(split(longdata$RT, list(longdata$partno, longdata$task)),
                        scale),list(longdata$partno, longdata$task))
summary(abs(zscore2) < 3.695) 
noout2 = subset(longdata, abs(zscore2) < 3.695)
#round2
zscore3 = unsplit(lapply(split(noout2$RT, list(noout2$partno, noout2$task)),
                        scale),list(noout2$partno, noout2$task))
summary(abs(zscore3) < 3.695)
noout3 = subset(noout2, abs(zscore3) < 3.695)
#round3
zscore4 = unsplit(lapply(split(noout3$RT, list(noout3$partno, noout3$task)),
                        scale),list(noout3$partno, noout3$task))
summary(abs(zscore4) < 3.695)
noout4 = subset(noout3, abs(zscore4) < 3.695)
#round4
zscore5 = unsplit(lapply(split(noout4$RT, list(noout4$partno, noout4$task)),
                        scale),list(noout4$partno, noout4$task))
summary(abs(zscore5) < 3.695)
noout5 = subset(noout4, abs(zscore5) < 3.695)
#round5
zscore6 = unsplit(lapply(split(noout5$RT, list(noout5$partno, noout5$task)),
                        scale),list(noout5$partno, noout5$task))
summary(abs(zscore6) < 3.695)
noout6 = subset(noout5, abs(zscore6) < 3.695)
#round6
zscore7 = unsplit(lapply(split(noout6$RT, list(noout6$partno, noout6$task)),
                        scale),list(noout6$partno, noout6$task))
summary(abs(zscore7) < 3.695)


#using noout for MLM analysis (nonrecursive outlier treatment)


##MLM

##intercept only model
model1 = gls(RT ~ 1, 
             data = noout, 
             method = "ML", 
             na.action = "na.omit")
summary(model1)

##random intercept only model
model2 = lme(RT ~ 1, 
             data = noout, 
             method = "ML", 
             na.action = "na.omit",
             random = ~1|partno)
summary(model2)

anova(model1,model2)
##significant...on to fixed effects


##adding task
model3 = lme(RT ~ task, 
              data = noout, 
              method = "ML", 
              na.action = "na.omit",
              random = ~1|partno)
summary(model3)
plot.lme(model3)


##adding task and type 
model4 = lme(RT ~ task + type, 
              data = noout, 
              method = "ML", 
              na.action = "na.omit",
              random = ~1|partno)
summary(model4)
plot.lme(model4)


#adding interaction
model5 = lme(RT ~ task*type,
              data = noout,
              method = "ML",
              na.action = "na.omit",
              random = ~1|partno)
summary(model5)
plot.lme(model5)


##compare models
anova(model1,model2,model3,model4,model5)

with(noout,tapply(RT, list(type,task), mean,na.rm=T))
hist(noout$RT)


##simple slopes 

##split on task
LDT = subset(noout, task == "LDT")
LST = subset(noout, task == "LST")

LDTmodel = lme(RT ~ type, 
               data = LDT, 
               method = "ML", 
               na.action = "na.omit",
               random = ~1|partno)
summary(LDTmodel)

LSTmodel = lme(RT ~ type,
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

fitted = fitted(model5)
graphdata = na.omit(noout)
scatter = ggplot(graphdata, aes(fitted, RT))
scatter +
  theme + 
  geom_point() +
  geom_smooth(method = "lm", color = "black") +
  xlab("Task + Type") +
  ylab("Reaction Time") 

##descriptives
tapply(noout$RT, list(noout$type, noout$task), mean)
tapply(noout$RT, list(noout$type, noout$task), sd)
tapply(noout$RT, list(noout$type, noout$task), length)


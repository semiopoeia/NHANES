library(tidyverse)

DAT<-
tribble(
~Disease_Group,~Sleep_Duration,~Sleep_Disorder,~Hazards,
"ACO","long","yes",5.96,
"ACO","long","no",4.21,
"ACO","norm","yes",1.41,
"ACO","norm","no",1,
"ACO","short","yes",3.48,
"ACO","short","no",2.46,
"COPD","long","yes",1.43,
"COPD","long","no",1.014,
"COPD","norm","yes",1.48,
"COPD","norm","no",1.045,
"COPD","short","yes",1.43,
"COPD","short","no",1.012,
"Control","long","yes",0.46,
"Control","long","no",0.32,
"Control","norm","yes",1.53,
"Control","norm","no" ,1.08,
"Control","short","yes",0.71,
"Control","short","no",0.5)

ggplot(DAT, aes(fill=Sleep_Disorder, y=Hazards, x=Sleep_Duration))+ 
  geom_bar(position='dodge', stat='identity')+ facet_grid(~Disease_Group)+
theme_bw()+geom_hline(yintercept=1)+theme(legend.position="bottom")+scale_fill_grey()

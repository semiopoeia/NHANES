ods html close;
ods html;
*Table 1: describe, ANOVA, Chi-Squared 
*count groups;
proc surveyfreq data=ReadyToAnalyze;
strata sdmvstra;
cluster sdmvpsu;
weight IntWGT6yr;
table breathi_issue_3groups;run;
proc surveyfreq data=ReadyToAnalyze;
  strata sdmvstra;
  cluster sdmvpsu;
  weight IntWGT6yr;
table NewEth*breathi_issue_3groups
/col row nowt nofreq nocellpercent nototal;
title 'Groups by Ethnicity, % and SE';
run;

*full counts;
proc surveyfreq data=ReadyToAnalyze;
  strata sdmvstra;
  cluster sdmvpsu;
  weight IntWGT6yr;
table breathi_issue_3groups*(
riagendr Race2 MaritalS2 PovertyIndex Education Smoke 
MCQ160D MCQ160F MCQ160B BPQ020 MCQ160E MCQ160C CVD
SLQ060 SleepDurCat)
/col row 
wchisq wllchisq chisq chisq1; 
title 'Full counts, % and SE';
run;
*means by group;
proc sort 
data=ReadyToAnalyze
out=ReadToAnalyze;
by breathi_issue_3groups;run;
proc surveymeans data=ReadyToAnalyze nobs mean stderr clm;
cluster sdmvpsu;
stratum sdmvstra;
weight IntWGT6yr;
class breathi_issue_3groups;
var RIDAGEYR BMXBMI SLD010H;
domain breathi_issue_3groups;
title 'Means and SE for groups';
run;
*anova;
PROC SURVEYREG data=ReadyToAnalyze nomcar;
STRATA sdmvstra;
CLUSTER sdmvpsu;
WEIGHT IntWGT6yr;
CLASS  breathi_issue_3groups;
MODEL RIDAGEYR = breathi_issue_3groups/CLPARM ANOVA solution vadjust=none;
ESTIMATE  'Cont. vs ACO' breathi_issue_3groups 1 0 0 -1;
ESTIMATE  'Asthma vs ACO' breathi_issue_3groups 0 1 0 -1;
ESTIMATE  'COPD. vs ACO' breathi_issue_3groups 0 0 1 -1;
title 'comparisons of age';
run;   
PROC SURVEYREG data=ReadyToAnalyze nomcar;
STRATA sdmvstra;
CLUSTER sdmvpsu;
WEIGHT IntWGT6yr;
CLASS  breathi_issue_3groups;
MODEL BMXBMI = breathi_issue_3groups/CLPARM ANOVA solution vadjust=none;
ESTIMATE  'Cont. vs ACO' breathi_issue_3groups 1 0 0 -1;
ESTIMATE  'Asthma vs ACO' breathi_issue_3groups 0 1 0 -1;
ESTIMATE  'COPD. vs ACO' breathi_issue_3groups 0 0 1 -1;
title 'comparisons of BMI';
run;   
PROC SURVEYREG data=ReadyToAnalyze nomcar;
STRATA sdmvstra;
CLUSTER sdmvpsu;
WEIGHT IntWGT6yr;
CLASS  breathi_issue_3groups;
MODEL SLD010H = breathi_issue_3groups/CLPARM ANOVA solution vadjust=none;
ESTIMATE  'Cont. vs ACO' breathi_issue_3groups 1 0 0 -1;
ESTIMATE  'Asthma vs ACO' breathi_issue_3groups 0 1 0 -1;
ESTIMATE  'COPD. vs ACO' breathi_issue_3groups 0 0 1 -1;
title 'comparisons of sleep duration';
run;   

*subsetting analyses to get chi-sq tests;
data acoVasth;
set ReadyToAnalyze;
if breathi_issue_3groups=3 or breathi_issue_3groups=1;
run;
proc surveyfreq data=acoVasth;
  strata sdmvstra;
  cluster sdmvpsu;
  weight IntWGT6yr;
  table breathi_issue_3groups*(
riagendr Race2 MaritalS2 PovertyIndex Education Smoke 
MCQ160D MCQ160F MCQ160B BPQ020 MCQ160E MCQ160C CVD
SLQ060 SleepDurCat)
/col row 
wchisq wllchisq chisq chisq1; 
title 'chi-sq aco vs. asthma';
run;
data acoVcopd;
set ReadyToAnalyze;
if breathi_issue_3groups=3 or breathi_issue_3groups=2;
run;
proc surveyfreq data=acoVcopd;
  strata sdmvstra;
  cluster sdmvpsu;
  weight IntWGT6yr;
  table breathi_issue_3groups*(
riagendr Race2 MaritalS2 PovertyIndex Education Smoke 
MCQ160D MCQ160F MCQ160B BPQ020 MCQ160E MCQ160C CVD
SLQ060 SleepDurCat)
/col row 
wchisq wllchisq chisq chisq1; 
title 'chi square aco vs copd';
run;
data ConVoverlap;
set ReadyToAnalyze;
if breathi_issue_3groups=0 or breathi_issue_3groups=3;
run;
proc surveyfreq data=ConVoverlap;
  strata sdmvstra;
  cluster sdmvpsu;
  weight IntWGT6yr;
  table breathi_issue_3groups*(
riagendr Race2 MaritalS2 PovertyIndex Education Smoke 
MCQ160D MCQ160F MCQ160B BPQ020 MCQ160E MCQ160C CVD
SLQ060 SleepDurCat)
/col row 
wchisq wllchisq chisq chisq1; 
title 'chi sq control vs overlap';
run;
ods html close;
ods html;

/*Table 2*/
PROC SURVEYLOGISTIC DATA = ReadyToAnalyze nomcar; 
STRATA sdmvstra;
CLUSTER sdmvpsu;
WEIGHT IntWGT6yr;
*DOMAIN 	breathi_issue_3groups;
CLASS riagendr (PARAM=REF REF='male') 
	  Race2 (PARAM=REF REF='white')
	  Smoke (PARAM=REF REF='never')
	  PovertyIndex (PARAM=REF REF='0')
      SleepDurCat (PARAM=REF REF='normal')
 	  breathi_issue_3groups (PARAM=REF REF='Overlap'); 	
MODEL CVD (event='1')=ridageyr BMXBMI riagendr Race2 Smoke PovertyIndex 
		breathi_issue_3groups|SleepDurCat/ expb
clparm vadjust=none;
	title "Multiple Logistic Regression: Odds of CVD with Sleep Duration";
run;

ods html close;
ods html;
/*Table 3*/

ods html close;
data ReadyToAnalyze;
set ReadyToAnalyze;
zAge=(ridageyr-49.51)/17.91;
zBMI=(BMXBMI-28.979)/6.841;
run;

PROC SURVEYLOGISTIC DATA = ReadyToAnalyze nomcar; 
STRATA sdmvstra;
CLUSTER sdmvpsu;
WEIGHT IntWGT6yr;
*DOMAIN 	breathi_issue_3groups;
CLASS breathi_issue_3groups (PARAM=REF REF="Overlap")
	  SLQ060 (PARAM=REF REF='no')
	  SleepDurCat (PARAM=REF REF='normal');
MODEL CVD (event='1')=breathi_issue_3groups|SLQ060 / expb corrb
clparm vadjust=none ;
	title "Multiple Logistic Regression: Odds of CVD with Sleep Disturbance";
run;
PROC SURVEYLOGISTIC DATA = ReadyToAnalyze nomcar; 
STRATA sdmvstra;
CLUSTER sdmvpsu;
WEIGHT IntWGT6yr;
*DOMAIN 	breathi_issue_3groups;
CLASS riagendr (PARAM=REF REF='male') 
	  Race2 (PARAM=REF REF='white')
	  Smoke (PARAM=REF REF='never')
	  PovertyIndex (PARAM=REF REF='0')
      breathi_issue_3groups (PARAM=REF REF="Overlap")
	  SLQ060 (PARAM=REF REF='no')
	  SleepDurCat (PARAM=REF REF='normal');
MODEL CVD (event='1')=ridageyr BMXBMI riagendr Race2 Smoke PovertyIndex 
 breathi_issue_3groups|SLQ060/ expb 
clparm vadjust=none ;
	title "Multiple Logistic Regression: Odds of CVD with Sleep Disturbance";
run;
ods html;
/*tables 4a-d*/
proc surveyphreg DATA = ReadyToAnalyze; 
STRATA sdmvstra;
CLUSTER sdmvpsu;
WEIGHT IntWGT6yr;
DOMAIN 	breathi_issue_3groups;
MODEL PERMTH_INT*MORTSTAT(0)=ridageyr/risklimit vadjust=none ties=efron;
	title "Proportional Hazards of death";
run;
proc surveyphreg DATA = ReadyToAnalyze; 
STRATA sdmvstra;
CLUSTER sdmvpsu;
WEIGHT IntWGT6yr;
DOMAIN 	breathi_issue_3groups;
MODEL PERMTH_INT*MORTSTAT(0)=BMXBMI/risklimit vadjust=none ties=efron;
	title "Proportional Hazards of death";
run;
proc surveyphreg DATA = ReadyToAnalyze; 
STRATA sdmvstra;
CLUSTER sdmvpsu;
WEIGHT IntWGT6yr;
DOMAIN 	breathi_issue_3groups;
CLASS riagendr (PARAM=REF REF='male') ;
MODEL PERMTH_INT*MORTSTAT(0)=riagendr/risklimit vadjust=none ties=efron;
run;
proc surveyphreg DATA = ReadyToAnalyze; 
STRATA sdmvstra;
CLUSTER sdmvpsu;
WEIGHT IntWGT6yr;
DOMAIN 	breathi_issue_3groups;
CLASS Race2 (PARAM=REF REF='white');
MODEL PERMTH_INT*MORTSTAT(0)=Race2/risklimit vadjust=none ties=efron;
run;
proc surveyphreg DATA = ReadyToAnalyze; 
STRATA sdmvstra;
CLUSTER sdmvpsu;
WEIGHT IntWGT6yr;
DOMAIN 	breathi_issue_3groups;
CLASS Smoke (PARAM=REF REF='never');
MODEL PERMTH_INT*MORTSTAT(0)=Smoke/risklimit vadjust=none ties=efron;
run;
proc surveyphreg DATA = ReadyToAnalyze; 
STRATA sdmvstra;
CLUSTER sdmvpsu;
WEIGHT IntWGT6yr;
DOMAIN 	breathi_issue_3groups;
CLASS PovertyIndex (PARAM=REF REF='0');
MODEL PERMTH_INT*MORTSTAT(0)=PovertyIndex/risklimit vadjust=none ties=efron;
run;
proc surveyphreg DATA = ReadyToAnalyze; 
STRATA sdmvstra;
CLUSTER sdmvpsu;
WEIGHT IntWGT6yr;
DOMAIN 	breathi_issue_3groups;
CLASS SleepDurCat (PARAM=REF REF='normal');
MODEL PERMTH_INT*MORTSTAT(0)=SleepDurCat/risklimit vadjust=none ties=efron;
run;
proc surveyphreg DATA = ReadyToAnalyze; 
STRATA sdmvstra;
CLUSTER sdmvpsu;
WEIGHT IntWGT6yr;
DOMAIN 	breathi_issue_3groups;
CLASS SLQ060 (PARAM=REF REF='no');
MODEL PERMTH_INT*MORTSTAT(0)=SLQ060/risklimit vadjust=none ties=efron;
run;

proc surveyphreg DATA = ReadyToAnalyze; 
STRATA sdmvstra;
CLUSTER sdmvpsu;
WEIGHT IntWGT6yr;
DOMAIN 	breathi_issue_3groups;
CLASS riagendr (PARAM=REF REF='male') 
	  Race2 (PARAM=REF REF='white')
	  Smoke (PARAM=REF REF='never')
	  PovertyIndex (PARAM=REF REF='0')
      SleepDurCat (PARAM=REF REF='normal');
MODEL PERMTH_INT*MORTSTAT(0)=ridageyr BMXBMI riagendr Race2 Smoke PovertyIndex SleepDurCat/ 
risklimit vadjust=none ties=efron;
	title "Proportional Hazards of death";
run;
*sleep disturb model;
proc surveyphreg DATA = ReadyToAnalyze; 
STRATA sdmvstra;
CLUSTER sdmvpsu;
WEIGHT IntWGT6yr;
DOMAIN 	breathi_issue_3groups;
CLASS riagendr (PARAM=REF REF='male') 
	  Race2 (PARAM=REF REF='white')
	  Smoke (PARAM=REF REF='never')
	  PovertyIndex (PARAM=REF REF='0')
      SLQ060 (PARAM=REF REF='no');
MODEL PERMTH_INT*MORTSTAT(0)=ridageyr BMXBMI riagendr Race2 Smoke PovertyIndex SLQ060/ 
risklimit vadjust=none ties=efron;
	title "Proportional Hazards of death";
run;
data contr;
set ReadyToAnalyze;
if breathi_issue_3groups=0;run;
proc lifetest data=contr plots=survival method=km notable;
      time PERMTH_INT*MORTSTAT(1);
      strata SleepDurCat;
      run;
	  proc lifetest data=contr plots=survival method=km notable; 
      time PERMTH_INT*MORTSTAT(1);
      strata SLQ060;
      run;
data asthma;
set ReadyToAnalyze;
if breathi_issue_3groups=1;run;
proc lifetest data=asthma plots=survival method=km notable;
      time PERMTH_INT*MORTSTAT(1);
      strata SleepDurCat;
      run;
	  proc lifetest data=asthma plots=survival method=km notable;
      time PERMTH_INT*MORTSTAT(1);
      strata SLQ060;
      run;
data copd;
set ReadyToAnalyze;
if breathi_issue_3groups=2;run;
proc lifetest data=copd plots=survival method=km notable;
      time PERMTH_INT*MORTSTAT(1);
      strata SleepDurCat;
      run;
	  proc lifetest data=copd plots=survival method=km notable;
      time PERMTH_INT*MORTSTAT(1);
      strata SLQ060;
      run;

data overlap;
set ReadyToAnalyze;
if breathi_issue_3groups=3;run;
proc lifetest data=overlap plots=survival method=km notable;
      time PERMTH_INT*MORTSTAT(1);
      strata SleepDurCat;
      run;
	  proc lifetest data=overlap plots=survival method=km notable;
      time PERMTH_INT*MORTSTAT(1);
      strata SLQ060;
      run;


proc surveyphreg DATA = ReadyToAnalyze; 
STRATA sdmvstra;
CLUSTER sdmvpsu;
WEIGHT IntWGT6yr;
*DOMAIN 	breathi_issue_3groups;
CLASS riagendr (PARAM=REF REF='male') 
	  Race2 (PARAM=REF REF='white')
	  Smoke (PARAM=REF REF='never')
	  PovertyIndex (PARAM=REF REF='0')
	breathi_issue_3groups (PARAM=REF REF='control')
	SleepDurCat (PARAM=REF REF='normal')
	SLQ060 (PARAM=REF REF='no');
MODEL PERMTH_INT*MORTSTAT(0)= ridageyr BMXBMI riagendr Race2 Smoke PovertyIndex breathi_issue_3groups|SleepDurCat SLQ060/
risklimit vadjust=none ties=efron;
	title "Proportional Hazards of death";
run;

proc surveyfreq data=ReadyToAnalyze;
  strata sdmvstra;
  cluster sdmvpsu;
  weight IntWGT6yr;
  table breathi_issue_3groups*(SleepDurCat)*MORTSTAT
/col row 
wchisq wllchisq chisq chisq1; 
title 'chi sq control vs overlap';
run;


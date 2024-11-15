PROC IMPORT OUT= WORK.basedat 
            DATAFILE= "C:\Users\PWS5\OneDrive - University of Pittsburgh
\Desktop\SleepHUB\NHANESFocused.sav" 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=basedat;run;

data nhanes; set tmp1.nhanesfocused;
HTN=HTN-1;
Diabetes=Diabetes-1;
LungDz=LungDz-1;
CVDz=CVDz-1; 
Nocturia=Nocturia-1;
Fatigue=Fatigue-1;
Insomnia=Insomnia-1;
Sleepy=Sleepy-1;
Snore=Snore-1;	
Snort=Snort-1;
DepVar=DepVar+1;
run;
proc surveyfreq data=basedat;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
tables 
	Fatigue
	Insomnia
	Nocturia
	Sleepy
	Snore
	Snort
	Diabetes
	HTN
	LungDz
	CVDz
	DepVar;
run;

PROC LCA DATA=nhanes OUTPOST=postprob;
ID SEQN; 
NCLASS 5; 
ITEMS 
	Fatigue
	Insomnia
	Nocturia
	Sleepy
	Snore
	Snort
	Diabetes
	HTN
	LungDz
	CVDz
	DepVar; 
CATEGORIES 4 4 2 4 4 4 2 2 2 2 2; 
WEIGHT WTINT4YR;
CLUSTERS SDMVPSU;
NSTARTS 20; 
SEED 3456;
RHO PRIOR= .5;
RUN; 

proc surveylogistic data=basedat;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
model povind200=bmxbmi snore;run;

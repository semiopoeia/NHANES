libname sleepy "C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\";run;

*bring in NHANES;
*2005-2006;
*SLQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\SLQ_D.xpt';
proc copy inlib=xptfile outlib=work;
run;
*pick vars of interest;
data SLQ_D;
set SLQ_D;
keep SEQN SLQ030 SLQ040;
run;

*DEMO;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\DEMO_D.xpt';
proc copy inlib=xptfile outlib=work;
run;
data DEMO_D;
set DEMO_D (rename=(INDFMPIR=INDFMMPI));
run;
*BMX;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\BMX_D.xpt';
proc copy inlib=xptfile outlib=work;
run;
data BMX_D;
set BMX_D;
keep SEQN BMXBMI;
run;

*MCQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\MCQ_D.xpt';
proc copy inlib=xptfile outlib=work;
run;
data MCQ_D;
set MCQ_D;
keep SEQN MCQ160K MCQ160g MCQ160f MCQ160d MCQ160b MCQ160c MCQ160e
MCQ010 MCQ035 MCQ220 MCQ160b MCQ160c MCQ160e MCQ160l MCQ160f;
array setmis(*) MCQ160K MCQ160g MCQ160f MCQ160d MCQ160b MCQ160c MCQ160e
MCQ010 MCQ035 MCQ220 MCQ160b MCQ160c MCQ160e MCQ160l MCQ160f;
	do i=1 to dim(setmis);
		if setmis(i)>2 then setmis(i)=.;
 	end;
run;
*MCQ160o is not in 2005-2008;

*BPQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\BPQ_D.xpt';
proc copy inlib=xptfile outlib=work;
run;
data BPQ_D;
set BPQ_D;
keep SEQN BPQ020;
if BPQ020>2 then BPQ020=.;
run;

*HUQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\HUQ_D.xpt';
proc copy inlib=xptfile outlib=work;
run;
data HUQ_D;
set HUQ_D;
keep SEQN HUQ050 HUQ071 HUD080;
if HUD080>6 then HUD080=.;
if HUQ071>2 then HUQ071=.;
if HUQ050>5 then HUQ050=.;
run;

*HIQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\HIQ_D.xpt';
proc copy inlib=xptfile outlib=work;
run;
data HIQ_D;
set HIQ_D;
keep SEQN HIQ011;
if HIQ011>2 then HIQ011=.;
run;

*DIQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\DIQ_D.xpt';
proc copy inlib=xptfile outlib=work;
run;
data DIQ_D;
set DIQ_D;
keep SEQN DIQ010;
if DIQ010>3 then DIQ010=.;
run;

*SMQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\SMQ_D.xpt';
proc copy inlib=xptfile outlib=work;
run;
data SMQ_D;
set SMQ_D;
keep SEQN SMQ020 SMQ040;
run;
*had to use trick referencing "https://wwwn.cdc.gov/Nchs/Nhanes/2007-2008/RHQ_D.xpt" in search bar;

*RHQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\RHQ_D.xpt';
proc copy inlib=xptfile outlib=work;
run;
data RHQ_D;
set RHQ_D;
keep SEQN RHQ031 RHD042;
run;

*merge the data;
proc sql;
   create table combD as
   select *
   from DEMO_D
   inner join SLQ_D
   on DEMO_D.SEQN = SLQ_D.SEQN
   inner join MCQ_D
   on SLQ_D.SEQN = MCQ_D.SEQN
   inner join BMX_D
   on MCQ_D.SEQN=BMX_D.SEQN
   inner join BPQ_D
   on BMX_D.SEQN=BPQ_D.SEQN
   inner join HUQ_D
   on BPQ_D.SEQN=HUQ_D.SEQN
   inner join HIQ_D
   on HUQ_D.SEQN=HIQ_D.SEQN
   inner join SMQ_D
   on HIQ_D.SEQN=SMQ_D.SEQN
   inner join DIQ_D
   on SMQ_D.SEQN=DIQ_D.SEQN
   full outer join RHQ_D
   on DIQ_D.SEQN=RHQ_D.SEQN;
quit;

*2007-2008;
*SLQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\SLQ_E.xpt';
proc copy inlib=xptfile outlib=work;
run;
data SLQ_E;
set SLQ_E;
keep SEQN SLQ030 SLQ040;
run;

*DEMO;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\DEMO_E.xpt';
proc copy inlib=xptfile outlib=work;
run;

*BMX;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\BMX_E.xpt';
proc copy inlib=xptfile outlib=work;
run;
data BMX_E;
set BMX_E;
keep SEQN BMXBMI;
run;

*MCQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\MCQ_E.xpt';
proc copy inlib=xptfile outlib=work;
run;
data MCQ_E;
set MCQ_E;
keep SEQN MCQ160K MCQ160g MCQ160f MCQ160d MCQ160b MCQ160c MCQ160e
MCQ010 MCQ035 MCQ220 MCQ160b MCQ160c MCQ160e MCQ160l MCQ160f;
array setmis(*) MCQ160K MCQ160g MCQ160f MCQ160d MCQ160b MCQ160c MCQ160e
MCQ010 MCQ035 MCQ220 MCQ160b MCQ160c MCQ160e MCQ160l MCQ160f;
	do i=1 to dim(setmis);
		if setmis(i)>2 then setmis(i)=.;
 	end;
run;
*MCQ160o is not in 2005-2008;

*BPQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\BPQ_E.xpt';
proc copy inlib=xptfile outlib=work;
run;
data BPQ_E;
set BPQ_E;
keep SEQN BPQ020;
if BPQ020>2 then BPQ020=.;
run;

*HUQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\HUQ_E.xpt';
proc copy inlib=xptfile outlib=work;
run;
data HUQ_E;
set HUQ_E;
keep SEQN HUQ050 HUQ071 HUD080;
if HUD080>6 then HUD080=.;
if HUQ071>2 then HUQ071=.;
if HUQ050>5 then HUQ050=.;
run;

*HIQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\HIQ_E.xpt';
proc copy inlib=xptfile outlib=work;
run;
data HIQ_E;
set HIQ_E;
keep SEQN HIQ011;
if HIQ011>2 then HIQ011=.;
run;

*DIQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\DIQ_E.xpt';
proc copy inlib=xptfile outlib=work;
run;
data DIQ_E;
set DIQ_E;
keep SEQN DIQ010;
if DIQ010>3 then DIQ010=.;
run;

*SMQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\SMQ_E.xpt';
proc copy inlib=xptfile outlib=work;
run;
data SMQ_E;
set SMQ_E;
keep SEQN SMQ020 SMQ040;
run;

*RHQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\RHQ_E.xpt';
proc copy inlib=xptfile outlib=work;
run;
data RHQ_E;
set RHQ_E;
keep SEQN RHQ031 RHD042;
run;

*INQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\INQ_E.xpt';
proc copy inlib=xptfile outlib=work;
run;
data INQ_E;
set INQ_E;
keep SEQN INDFMMPI;
run;

*merge the data;
proc sql;
   create table combE as
   select *
   from DEMO_E
   inner join SLQ_E
   on DEMO_E.SEQN = SLQ_E.SEQN
   inner join MCQ_E
   on SLQ_E.SEQN = MCQ_E.SEQN
   inner join BMX_E
   on MCQ_E.SEQN=BMX_E.SEQN
   inner join BPQ_E
   on BMX_E.SEQN=BPQ_E.SEQN
   inner join HUQ_E
   on BPQ_E.SEQN=HUQ_E.SEQN
   inner join HIQ_E
   on HUQ_E.SEQN=HIQ_E.SEQN
   inner join SMQ_E
   on HIQ_E.SEQN=SMQ_E.SEQN
   inner join INQ_E
   on SMQ_E.SEQN=INQ_E.SEQN
   inner join DIQ_E
   on INQ_E.SEQN=DIQ_E.SEQN
   full outer join RHQ_E
   on DIQ_E.SEQN=RHQ_E.SEQN;
quit;

*2015-2016;
*SLQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\SLQ_I.xpt';
proc copy inlib=xptfile outlib=work;
run;
data SLQ_I;
set SLQ_I;
keep SEQN SLQ030 SLQ040;
run;

*DEMO;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\DEMO_I.xpt';
proc copy inlib=xptfile outlib=work;
run;
*BMX;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\BMX_I.xpt';
proc copy inlib=xptfile outlib=work;
run;
data BMX_I;
set BMX_I;
keep SEQN BMXBMI;
run;

*MCQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\MCQ_I.xpt';
proc copy inlib=xptfile outlib=work;
run;
data MCQ_I;
set MCQ_I;
keep SEQN MCQ160K MCQ160g MCQ160o MCQ160f MCQ160d MCQ160b MCQ160c MCQ160e
MCQ010 MCQ035 MCQ220 MCQ160b MCQ160c MCQ160e MCQ160l MCQ160f;
array setmis(*) MCQ160K MCQ160g MCQ160o MCQ160f MCQ160d MCQ160b MCQ160c MCQ160e
MCQ010 MCQ035 MCQ220 MCQ160b MCQ160c MCQ160e MCQ160l MCQ160f;
	do i=1 to dim(setmis);
		if setmis(i)>2 then setmis(i)=.;
 	end;
run;

*BPQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\BPQ_I.xpt';
proc copy inlib=xptfile outlib=work;
run;
data BPQ_I;
set BPQ_I;
keep SEQN BPQ020;
if BPQ020>2 then BPQ020=.;
run;

*HUQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\HUQ_I.xpt';
proc copy inlib=xptfile outlib=work;
run;
data HUQ_I;
set HUQ_I;
keep SEQN HUQ051 HUQ071 HUD080;
if HUQ051>8 then HUQ051=.;
if HUQ071>2 then HUQ071=.;
if HUD080>6 then HUD080=.;
run;

*HIQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\HIQ_I.xpt';
proc copy inlib=xptfile outlib=work;
run;
data HIQ_I;
set HIQ_I;
keep SEQN HIQ011;
if HIQ011>2 then HIQ011=.;
run;
*DIQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\DIQ_I.xpt';
proc copy inlib=xptfile outlib=work;
run;
data DIQ_I;
set DIQ_I;
keep SEQN DIQ010;
if DIQ010>3 then DIQ010=.;
run;
*SMQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\SMQ_I.xpt';
proc copy inlib=xptfile outlib=work;
run;
data SMQ_I;
set SMQ_I;
keep SEQN SMQ020 SMQ040;
run;

*INQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\INQ_I.xpt';
proc copy inlib=xptfile outlib=work;
run;
data INQ_I;
set INQ_I;
keep SEQN INDFMMPI;
run;

*RHQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\RHQ_I.xpt';
proc copy inlib=xptfile outlib=work;
run;
data RHQ_I;
set RHQ_I;
keep SEQN RHQ031 RHD043;
run;

*merge the data;
proc sql;
   create table combI as
   select *
   from DEMO_I
   inner join SLQ_I
   on DEMO_I.SEQN = SLQ_I.SEQN
   inner join MCQ_I
   on SLQ_I.SEQN = MCQ_I.SEQN
   inner join BMX_I
   on MCQ_I.SEQN=BMX_I.SEQN
   inner join BPQ_I
   on BMX_I.SEQN=BPQ_I.SEQN
   inner join HUQ_I
   on BPQ_I.SEQN=HUQ_I.SEQN
   inner join HIQ_I
   on HUQ_I.SEQN=HIQ_I.SEQN
   inner join SMQ_I
   on HIQ_I.SEQN=SMQ_I.SEQN
  inner join INQ_I
   on SMQ_I.SEQN=INQ_I.SEQN
   inner join DIQ_I
   on INQ_I.SEQN=DIQ_I.SEQN
   full outer join RHQ_I
   on DIQ_I.SEQN=RHQ_I.SEQN;
quit;

*2017-2018;
*SLQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\SLQ_J.xpt';
proc copy inlib=xptfile outlib=work;
run;
data SLQ_J;
set SLQ_J;
keep SEQN SLQ030 SLQ040;
run;

*DEMO;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\DEMO_J.xpt';
proc copy inlib=xptfile outlib=work;
run;

*BMX;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\BMX_J.xpt';
proc copy inlib=xptfile outlib=work;
run;
data BMX_J;
set BMX_J;
keep SEQN BMXBMI;
run;

*MCQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\MCQ_J.xpt';
proc copy inlib=xptfile outlib=work;
run;
data MCQ_J;
set MCQ_J;
keep SEQN MCQ160K MCQ160g MCQ160o MCQ160f MCQ160d MCQ160b MCQ160c MCQ160e
MCQ010 MCQ035 MCQ220 MCQ160b MCQ160c MCQ160e MCQ160l MCQ160f;
array setmis(*) MCQ160K MCQ160g MCQ160o MCQ160f MCQ160d MCQ160b MCQ160c MCQ160e
MCQ010 MCQ035 MCQ220 MCQ160b MCQ160c MCQ160e MCQ160l MCQ160f;
	do i=1 to dim(setmis);
		if setmis(i)>2 then setmis(i)=.;
 	end;
run;

*BPQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\BPQ_J.xpt';
proc copy inlib=xptfile outlib=work;
run;
data BPQ_J;
set BPQ_J;
keep SEQN BPQ020;
if BPQ020>2 then BPQ020=.;
run;

*HUQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\HUQ_J.xpt';
proc copy inlib=xptfile outlib=work;
run;
data HUQ_J;
set HUQ_J;
keep SEQN HUQ051 HUQ071 HUD080;
if HUQ051>8 then HUQ051=.;
if HUQ071>2 then HUQ071=.;
if HUD080>6 then HUD080=.;
run;

*HIQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\HIQ_J.xpt';
proc copy inlib=xptfile outlib=work;
run;
data HIQ_J;
set HIQ_J;
keep SEQN HIQ011;
if HIQ011>2 then HIQ011=.;
run;
*DIQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\DIQ_J.xpt';
proc copy inlib=xptfile outlib=work;
run;
data DIQ_J;
set DIQ_J;
keep SEQN DIQ010;
if DIQ010>3 then DIQ010=.;
run;
*SMQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\SMQ_J.xpt';
proc copy inlib=xptfile outlib=work;
run;
data SMQ_J;
set SMQ_J;
keep SEQN SMQ020 SMQ040;
run;

libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\INQ_J.xpt';
proc copy inlib=xptfile outlib=work;
run;
data INQ_J;
set INQ_J;
keep SEQN INDFMMPI;
run;

*RHQ;
libname xptfile xport 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\RHQ_J.xpt';
proc copy inlib=xptfile outlib=work;
run;
data RHQ_J;
set RHQ_J;
keep SEQN RHQ031 RHD043;
run;

*merge the data;
proc sql;
   create table combJ as
   select *
   from DEMO_J
   inner join SLQ_J
   on DEMO_J.SEQN = SLQ_J.SEQN
   inner join MCQ_J
   on SLQ_J.SEQN = MCQ_J.SEQN
   inner join BMX_J
   on MCQ_J.SEQN=BMX_J.SEQN
   inner join BPQ_J
   on BMX_J.SEQN=BPQ_J.SEQN
   inner join HUQ_J
   on BPQ_J.SEQN=HUQ_J.SEQN
   inner join HIQ_J
   on HUQ_J.SEQN=HIQ_J.SEQN
   inner join SMQ_J
   on HIQ_J.SEQN=SMQ_J.SEQN
   inner join INQ_J
   on SMQ_J.SEQN=INQ_J.SEQN
   inner join DIQ_J
   on INQ_J.SEQN=DIQ_J.SEQN
   full outer join RHQ_J
   on DIQ_J.SEQN=RHQ_J.SEQN;
quit;

*pull together 2005-2008;
data comb58;
set combD combE;
run;
*compute the joint weight and rename to align with new cohort;
data comb58;
set comb58 (rename=(RHD042=RHD043));
WTINT4YR = 1/2 *WTINT2YR;
run;
*filter >=40 years;
data comb58over40;
set comb58;
if RIDAGEYR>=40;
run;
*compute Apnea Index and MAP;
data comb58over40v;
set comb58over40;
if SLQ030=0 then SLQ030r=0;
if SLQ030>0 then SLQ030r=1+SLQ030;
if SLQ030=7 then SLQ030r=.;
if SLQ030=9 then SLQ030r=.;
if SLQ040=0 then SLQ040r=0;
if SLQ040>0 then SLQ040r=1+SLQ040;
if SLQ040=7 then SLQ040r=.;
if SLQ040=9 then SLQ040r=.;
*first approach to menopausal status;
*if (RHQ031=2 & RHD043=7) then MenoStat1=1;
*if ((RIDAGEYR<55 & RHQ031=2 & RHD043~=7) | RHQ031=1) then MenoStat1=0;
*second approach to menopausal;
if (RHQ031=2 & RHD043=7) then MenoStat2=1;
if ((RHQ031=2 & RHD043~=7) | RHQ031=1) then MenoStat2=0;
run;

data comb58over40m;
set comb58over40v;
ApneaIndex= mean(SLQ030r,SLQ040r);
Male =2-RIAGENDR;
logitMAP= -8.16+(1.299*ApneaIndex)+(0.163*BMXBMI)-(0.028*ApneaIndex*BMXBMI)+(0.032*RIDAGEYR)+(1.278*Male);
MAP=(exp(logitMAP))/(1+exp(logitMAP));
*if (MAP<=0.5) then OSA=0;
*if (MAP>0.5) then OSA=1;
if (MAP<=0.5)&(Male=1) then OSA=0;
if (MAP<=0.154)&(Male=0)&(MenoStat2=0) then OSA=0;
if (MAP<=0.375)&(Male=0)&(MenoStat2=1) then OSA=0;
if (MAP>0.5)&(Male=1) then OSA=1;
if (MAP>0.154)&(Male=0)&(MenoStat2=0) then OSA=1;
if (MAP>0.375)&(Male=0)&(MenoStat2=1) then OSA=1;
run;

*compute COPD, CVD and morbid obsesity (<=40 BMI);
data comb58over40p;
set comb58over40m;
if ((MCQ160K=1) or (MCQ160G=1)) then COPD=1;
else COPD=0;
if BMXBMI>=40 then Obese=1;
else Obese=0;
if MCQ160f=1 | MCQ160d=1 | MCQ160b=1 | MCQ160c=1 | MCQ160e=1 | BPQ020=1
then CVD=1;
if MCQ160f=2 & MCQ160d=2 & MCQ160b=2 & MCQ160c=2 & MCQ160e=2 & BPQ020=2
then CVD=0;
if (MCQ010=1 & MCQ035=1) then Asthma=1;
else Asthma=0;
if HUQ050<=1 then HCVisit=0;
if HUQ050=2 then HCVisit=1;
if HUQ050=3 then HCVisit=2;
if HUQ050>3 then HCVisit=3;
if RIDRETH1=3 then Ethno2=0;
else Ethno2=1;
if RIDRETH1=3 then Ethno4=0;
if RIDRETH1=4 then Ethno4=1;
if (RIDRETH1=1 or RIDRETH1=2) then Ethno4=2;
if RIDRETH1=5 then Ethno4=3;
if DMDEDUC2<=2 then Educ2=0;
if (DMDEDUC2>2 & DMDEDUC2<=5) then Educ2=1;
if DMDEDUC2>5 then Educ2=.;
if (SMQ040=1)or(SMQ040=2) then Smoke=2;
if (SMQ040=3) and (SMQ020=1) then Smoke=1;
if (SMQ020=2) then Smoke=0;
if (INDFMMPI>2) then FPR_povInd=1;
if (INDFMMPI<=2) then FPR_povInd=0;
if (DMDMARTL>=77) then Partnered=.;
if (DMDMARTL=1 or DMDMARTL=6) then Partnered=1;
else Partnered=0;
if DIQ010=1 then Diabetes=1;
if (DIQ010=2 or DIQ010=3) then Diabetes=0;
 run; 

*make triple overlap (OSA, COPD, BMI>=40), osa/copd (<40),copd only ;
data overlap58;
set comb58over40p;
if ((COPD=1)&(OSA=1)&(Obese=1)) then GroupOverlap=1;
if ((COPD=1)&(OSA=1)&(Obese=0)) then GroupOverlap=2;
if ((COPD=1)&(OSA=0)& (Obese=1)) then GroupOverlap=3;
if ((COPD=1)&(OSA=0)& (Obese=0)) then GroupOverlap=4;
if ((COPD=0)&(OSA=1)&(Obese=1)) then GroupOverlap=5;
if ((COPD=0)&(OSA=1)&(Obese=0)) then GroupOverlap=6;
if ((COPD=0)&(OSA=0)&(Obese=1)) then GroupOverlap=7;
if ((COPD=0)&(OSA=0)&(Obese=0)) then GroupOverlap=8;
run;
proc format;
 value group8g 
1 = 'Triple'
2 = 'Double, not obese'
3 = 'COPD only, obese'
4 = 'COPD only, not obese'
5 = 'OSA only, obese'
6 = 'OSA only, not obese'
7 = 'Obese only'
8 = 'Control'
;

proc format;
value smocat
0="Never"
1="Former"
2="Current";
run;

*pull together 2015-2018;
data comb1518;
set combI combJ;
run;
*compute the joint weight;
data comb1518;
set comb1518;
WTINT4YR = 1/2 *WTINT2YR;
run;
*filter >=40 years;
data comb1518over40;
set comb1518;
if RIDAGEYR>=40;
run;
*compute Apnea Index and MAP;
data comb1518over40v;
set comb1518over40;
if SLQ030=0 then SLQ030r=0;
if SLQ030>0 then SLQ030r=1+SLQ030;
if SLQ030=7 then SLQ030r=.;
if SLQ030=9 then SLQ030r=.;
if SLQ040=0 then SLQ040r=0;
if SLQ040>0 then SLQ040r=1+SLQ040;
if SLQ040=7 then SLQ040r=.;
if SLQ040=9 then SLQ040r=.;
*first approach to menopausal status;
*if (RHQ031=2 &(RHD043=7 | RHD043=3)) then MenoStat1=1;
*if ((RIDAGEYR<55 & RHQ031=2 &(RHD043~=7 & RHD043~=3))|RHQ031=1) then MenoStat1=0;
*second approach to menopausal;
if (RHQ031=2 & (RHD043=7 | RHD043=3)) then MenoStat2=1;
if ((RHQ031=2 & (RHD043~=7 & RHD043~=3))|RHQ031=1) then MenoStat2=0;
run;
data comb1518over40m;
set comb1518over40v;
ApneaIndex= mean(SLQ030r,SLQ040r);
MALE=2-RIAGENDR;
logitMAP= -8.16+(1.299*ApneaIndex)+(0.163*BMXBMI)-(0.028*ApneaIndex*BMXBMI)+(0.032*RIDAGEYR)+(1.278*MALE);
MAP=(exp(logitMAP))/(1+exp(logitMAP));
*if (MAP<=0.5) then OSA=0;
*if (MAP>0.5) then OSA=1;
if (MAP<=0.5)&(Male=1) then OSA=0;
if (MAP<=0.154)&(Male=0)&(MenoStat2=0) then OSA=0;
if (MAP<=0.375)&(Male=0)&(MenoStat2=1) then OSA=0;
if (MAP>0.5)&(Male=1) then OSA=1;
if (MAP>0.154)&(Male=0)&(MenoStat2=0) then OSA=1;
if (MAP>0.375)&(Male=0)&(MenoStat2=1) then OSA=1;
run;

*compute COPD, CVD, and morbid obesity;
data comb1518over40p;
set comb1518over40m;
if ((MCQ160K=1) or (MCQ160G=1) or (MCQ160O=1)) then COPD=1;
else COPD=0;
if BMXBMI>=40 then Obese=1;
else Obese=0;
if MCQ160f=1 | MCQ160d=1 | MCQ160b=1 | MCQ160c=1 | MCQ160e=1 | BPQ020=1
then CVD=1;
if MCQ160f=2 & MCQ160d=2 & MCQ160b=2 & MCQ160c=2 & MCQ160e=2 & BPQ020=2
then CVD=0;
if (MCQ010=1 & MCQ035=1) then Asthma=1;
else Asthma=0;
if HUQ051<=1 then HCVisit=0;
if HUQ051=2 then HCVisit=1;
if HUQ051>2 & HUQ051<6 then HCVisit=2;
if HUQ051>5 then HCVisit=3;
if RIDRETH1=3 then Ethno2=0;
else Ethno2=1;
if RIDRETH3=3 then Ethno5=0;
if RIDRETH3=4 then Ethno5=1;
if (RIDRETH3=1 or RIDRETH3=2) then Ethno5=2;
if RIDRETH3=6 then Ethno5=3;
if RIDRETH3=7 then Ethno5=4;
if RIDRETH3=3 then Ethno4=0;
if RIDRETH3=4 then Ethno4=1;
if (RIDRETH3=1 or RIDRETH3=2) then Ethno4=2;
if (RIDRETH3=6 or RIDRETH3=7) then Ethno4=3;
if DMDEDUC2<=2 then Educ2=0;
if (DMDEDUC2>2 & DMDEDUC2<=5) then Educ2=1;
if DMDEDUC2>5 then Educ2=.;
if (SMQ040=1)or(SMQ040=2) then Smoke=2;
if (SMQ040=3) and (SMQ020=1) then Smoke=1;
if (SMQ020=2) then Smoke=0; 
if (INDFMMPI>2) then FPR_povInd=1;
if (INDFMMPI<=2) then FPR_povInd=0;
if (DMDMARTL>=77) then Partnered=.;
if (DMDMARTL=1 or DMDMARTL=6) then Partnered=1;
else Partnered=0;
if DIQ010=1 then Diabetes=1;
if (DIQ010=2 or DIQ010=3) then Diabetes=0;
run; 

*make triple overlap (OSA, COPD, BMI>=40), osa/copd (<40),copd only ;
data overlap1518;
set comb1518over40p;
if ((COPD=1)&(OSA=1)&(Obese=1)) then GroupOverlap=1;
if ((COPD=1)&(OSA=1)&(Obese=0)) then GroupOverlap=2;
if ((COPD=1)&(OSA=0)& (Obese=1)) then GroupOverlap=3;
if ((COPD=1)&(OSA=0)& (Obese=0)) then GroupOverlap=4;
if ((COPD=0)&(OSA=1)&(Obese=1)) then GroupOverlap=5;
if ((COPD=0)&(OSA=1)&(Obese=0)) then GroupOverlap=6;
if ((COPD=0)&(OSA=0)&(Obese=1)) then GroupOverlap=7;
if ((COPD=0)&(OSA=0)&(Obese=0)) then GroupOverlap=8;
run;

*get frequencies;
proc format;
 value group8g 
1 = 'Triple'
2 = 'Double, not obese'
3 = 'COPD only, obese'
4 = 'COPD only, not obese'
5 = 'OSA only, obese'
6 = 'OSA only, not obese'
7 = 'Obese only'
8 = 'Control'
;


data aim2_coh1;
set overlap58;
if (GroupOverlap=1) or (GroupOverlap=2) or (GroupOverlap=4) or (GroupOverlap=8);
run;

data aim2_coh2;
set overlap1518;
if (GroupOverlap=1) or (GroupOverlap=2) or (GroupOverlap=4) or (GroupOverlap=8);
run;

*combine cohorts;
data aim2_combcoh;
set aim2_coh1 aim2_coh2;
WTINT8YR = 1/4 *WTINT2YR;
run;

data overlap_comb;
set overlap58 overlap1518;
WTINT8YR = 1/4 *WTINT2YR;
if (SDDSRVYR=4 | SDDSRVYR=5) then Cohort=1;
if (SDDSRVYR=9 | SDDSRVYR=10) then Cohort=2;
run;
data just_overlap_comb;
set overlap_comb;
if GroupOverlap<3;
run;


*cross-cohort analysis set;
proc format;
value nameyr
4='2005-2006'
5='2007-2008'
9='2015-2016'
10='2017-2018'
;
proc format;
value namecoh
1='2005-2008'
2='2015-2018'
;

proc format;
value eth5no
0='white'
1='black'
2='hispanic'
3='asian'
4='other/multi (includes asian in 05-08 cohort)'
;

proc format;
value eth4no
0='white'
1='black'
2='hispanic'
3='other'
;

proc format;
value partner
0='not partnered'
1='partnered'
;

data crosscoh;
set aim2_combcoh;
if (SDDSRVYR=4 | SDDSRVYR=5) then Cohort=1;
if (SDDSRVYR=9 | SDDSRVYR=10) then Cohort=2;
run;


*all cause mortality (ref: SAS_ReadInProgramAllSurvey (1);
data mortality;
set NHANES_2005_2006 NHANES_2007_2008 NHANES_2015_2016 NHANES_2017_2018;
run;

*merge to combined cohort file;
proc sql;
   create table cohcomb_MortLink as
   select *
   from just_overlap_comb
   inner join mortality
   on just_overlap_comb.SEQN = mortality.SEQN;
quit;
run;

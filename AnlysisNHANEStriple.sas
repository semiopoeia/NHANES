
ods HTML close;
ods pdf file='AdjCutMAP.pdf' pdftoc=2;
*AIM 1;
proc surveyfreq data=overlap58;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
format GroupOverlap group8g.;
tables GroupOverlap /cl;
run;

proc surveyfreq data=overlap1518;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
format GroupOverlap group8g.;
tables GroupOverlap /cl;
run;

*AIM 2;
proc surveyfreq data=overlap58;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
format GroupOverlap group8g.;
tables 
GroupOverlap*
(CVD
MCQ160f
MCQ160d
MCQ160b
MCQ160c
MCQ160e
BPQ020)
 /cl row;
run;

proc surveyfreq data=overlap1518;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
format GroupOverlap group8g.;
tables 
GroupOverlap*
(CVD
MCQ160f
MCQ160d
MCQ160b
MCQ160c
MCQ160e
BPQ020)
 /cl row;
run;

*cohort 1;
proc surveyfreq data=aim2_coh1;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
format GroupOverlap group8g.;
tables 
/*angina*/
GroupOverlap*MCQ160d
/*CHF*/
GroupOverlap*MCQ160b
/*hypertension*/
GroupOverlap*BPQ020
/*coronary heart disease*/
GroupOverlap*MCQ160c
/*myocardial infarction*/
GroupOverlap*MCQ160e
/*stroke*/
GroupOverlap*MCQ160f
/*overall cvd*/
GroupOverlap*CVD
/cl row nototal nocellpercent nofreq chisq;
run;
*overall cvd;
proc surveylogistic data=aim2_coh1; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model CVD(event='1')=GroupOverlap/expb clparm;
run;
*angina;
proc surveylogistic data=aim2_coh1; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model MCQ160d(event='1')=GroupOverlap/expb clparm;
run;
*chf;
proc surveylogistic data=aim2_coh1; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model MCQ160b(event='1')=GroupOverlap/expb clparm;
run;
*hypertension;
proc surveylogistic data=aim2_coh1; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model BPQ020(event='1')=GroupOverlap/expb clparm;
run;
*coronary heart disease;
proc surveylogistic data=aim2_coh1; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model MCQ160c(event='1')=GroupOverlap/expb clparm;
run;
*myocardial infarction;
proc surveylogistic data=aim2_coh1; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model MCQ160e(event='1')=GroupOverlap/expb clparm;
run;
*stroke;
proc surveylogistic data=aim2_coh1; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model MCQ160f(event='1')=GroupOverlap/expb clparm;
run;
*healthcare utilization;
*regular visits;
proc surveyfreq data=aim2_coh1;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
format GroupOverlap group8g.;
tables 
GroupOverlap*HCVisit/cl row nototal nocellpercent nofreq chisq;;
run;

proc surveylogistic data=aim2_coh1; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model HCVisit(ref='0')=GroupOverlap/expb clparm link=glogit;
run;
*overnight hospitalizations;
proc surveyfreq data=aim2_coh1;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
format GroupOverlap group8g.;
tables 
GroupOverlap*HUQ071/cl row nototal nocellpercent nofreq chisq;;
run;

proc surveylogistic data=aim2_coh1; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model HUQ071(event='1')=GroupOverlap/expb clparm;
run;

*cohort 2;
proc surveyfreq data=aim2_coh2;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
format GroupOverlap group8g.;
tables 
/*angina*/
GroupOverlap*MCQ160d
/*CHF*/
GroupOverlap*MCQ160b
/*hypertension*/
GroupOverlap*BPQ020
/*coronary heart disease*/
GroupOverlap*MCQ160c
/*myocardial infarction*/
GroupOverlap*MCQ160e
/*stroke*/
GroupOverlap*MCQ160f
/*overall cvd*/
GroupOverlap*CVD
/cl row nototal nocellpercent nofreq chisq;
run;
*overall cvd;
proc surveylogistic data=aim2_coh2; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model CVD(event='1')=GroupOverlap/expb clparm;
run;
*angina;
proc surveylogistic data=aim2_coh2; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model MCQ160d(event='1')=GroupOverlap/expb clparm;
run;
*chf;
proc surveylogistic data=aim2_coh2; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model MCQ160b(event='1')=GroupOverlap/expb clparm;
run;
*hypertension;
proc surveylogistic data=aim2_coh2; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model BPQ020(event='1')=GroupOverlap/expb clparm;
run;
*coronary heart disease;
proc surveylogistic data=aim2_coh2; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model MCQ160c(event='1')=GroupOverlap/expb clparm;
run;
*myocardial infarction;
proc surveylogistic data=aim2_coh2; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model MCQ160e(event='1')=GroupOverlap/expb clparm;
run;
*stroke;
proc surveylogistic data=aim2_coh2; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model MCQ160f(event='1')=GroupOverlap/expb clparm;
run;
*healthcare utilization;
*regular visits;
proc surveyfreq data=aim2_coh2;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
format GroupOverlap group8g.;
tables 
GroupOverlap*HCVisit/cl row nototal nocellpercent nofreq chisq;;
run;
proc surveylogistic data=aim2_coh2; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model HCVisit(desc)=GroupOverlap/expb clparm;
run;
*overnight hospitalizations;
proc surveyfreq data=aim2_coh2;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
format GroupOverlap group8g.;
tables 
GroupOverlap*HUQ071/cl row nototal nocellpercent nofreq chisq;;
run;
proc surveylogistic data=aim2_coh2; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model HUQ071(event='1')=GroupOverlap/expb clparm;
run;


*combined cohorts;
proc surveyfreq data=aim2_combcoh;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
format GroupOverlap group8g.;
tables 
/*angina*/
GroupOverlap*MCQ160d
/*CHF*/
GroupOverlap*MCQ160b
/*hypertension*/
GroupOverlap*BPQ020
/*coronary heart disease*/
GroupOverlap*MCQ160c
/*myocardial infarction*/
GroupOverlap*MCQ160e
/*stroke*/
GroupOverlap*MCQ160f
/*overall cvd*/
GroupOverlap*CVD
/cl row nototal nocellpercent nofreq chisq;
run;
proc surveyfreq data=aim2_coh2;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
format GroupOverlap group8g.;
tables 
GroupOverlap*CVD;
run;
*overall cvd;
proc surveylogistic data=aim2_combcoh; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
class GroupOverlap (PARAM=REF REF='Triple');
model CVD(event='1')=GroupOverlap/expb clparm;
run;
*angina;
proc surveylogistic data=aim2_combcoh; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
class GroupOverlap (PARAM=REF REF='Triple');
model MCQ160d(event='1')=GroupOverlap/expb clparm;
run;
*chf;
proc surveylogistic data=aim2_combcoh; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
class GroupOverlap (PARAM=REF REF='Triple');
model MCQ160b(event='1')=GroupOverlap/expb clparm;
run;
*hypertension;
proc surveylogistic data=aim2_combcoh; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
class GroupOverlap (PARAM=REF REF='Triple');
model BPQ020(event='1')=GroupOverlap/expb clparm;
run;
*coronary heart disease;
proc surveylogistic data=aim2_combcoh; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
class GroupOverlap (PARAM=REF REF='Triple');
model MCQ160c(event='1')=GroupOverlap/expb clparm;
run;
*myocardial infarction;
proc surveylogistic data=aim2_combcoh; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
class GroupOverlap (PARAM=REF REF='Triple');
model MCQ160e(event='1')=GroupOverlap/expb clparm;
run;
*stroke;
proc surveylogistic data=aim2_combcoh; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
class GroupOverlap (PARAM=REF REF='Triple');
model MCQ160f(event='1')=GroupOverlap/expb clparm;
run;

ods pdf close;
ods HTML;
*trying with full set of conditions, e.g. CHF;
proc surveyfreq data=aim2_combcoh;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
format GroupOverlap group8g.;
tables 
/*angina*/
GroupOverlap*MCQ160d
/*CHF*/
GroupOverlap*MCQ160b
/*hypertension*/
GroupOverlap*BPQ020
/*coronary heart disease*/
GroupOverlap*MCQ160c
/*myocardial infarction*/
GroupOverlap*MCQ160e
/*stroke*/
GroupOverlap*MCQ160f
/*overall cvd*/
GroupOverlap*CVD
/cl row;
run;
*visit not overnight;
proc surveyfreq data=aim2_combcoh;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
format GroupOverlap group8g.;
tables 
GroupOverlap*HCVisit/cl row nototal nocellpercent nofreq chisq;
run;
proc surveylogistic data=aim2_combcoh; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
class GroupOverlap (PARAM=REF REF='Triple');
model HCVisit(desc)=GroupOverlap/expb clparm;
run;

*overnight hospitalizations;
proc surveyfreq data=aim2_combcoh;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
format GroupOverlap group8g.;
tables 
GroupOverlap*HUQ071/cl row nototal nocellpercent nofreq chisq;
run;
proc surveylogistic data=aim2_combcoh; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
class GroupOverlap (PARAM=REF REF='Triple');
model HUQ071(event='1')=GroupOverlap/expb clparm;
run;

proc means data=mortal58;
var PERMTH_INT;run;

proc surveyfreq data=coh1_MortLink; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
table GroupOverlap*MORTSTAT/cl row nototal nocellpercent nofreq chisq;
run;
proc sort data=coh1_MortLink;
by GroupOverlap MORTSTAT;
run;
proc surveymeans data=coh1_MortLink; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
by GroupOverlap MORTSTAT;
var PERMTH_INT;
run;
proc surveylogistic data=coh1_MortLink; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model MORTSTAT(event='Assumed deceased')=GroupOverlap/expb clparm;
run;

proc surveyphreg data=coh1_MortLink; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Triple');
model PERMTH_INT*MORTSTAT(0)= GroupOverlap/
risklimit vadjust=none ties=efron;
	title "Proportional Hazards of death";
run;

*combined cohort with controls;
*CVD;
proc surveylogistic data=aim2_combcoh; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
class GroupOverlap (PARAM=REF REF='Triple')
	  Smoke (PARAM=REF REF='0');
model CVD(event='1')=GroupOverlap RIDAGEYR Male Ethno2 Educ2 Smoke HIQ011/expb clparm;
contrast 'COPD vs. Double' GroupOverlap 1 0 -1 0/estimate=exp;
run;

*healthcare utilization overnight;
proc surveylogistic data=aim2_combcoh; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
class GroupOverlap (PARAM=REF REF='Triple')
	  Smoke (PARAM=REF REF='0');
model HUQ071(event='1')=GroupOverlap RIDAGEYR Male Ethno2 Educ2 Smoke HIQ011/expb clparm;
contrast 'COPD vs. Double' GroupOverlap 1 0 -1 0/estimate=exp;
run;

*care visits;
proc surveylogistic data=aim2_combcoh; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
class GroupOverlap (PARAM=REF REF='Triple')
	  Smoke (PARAM=REF REF='0');
model HCVisit(desc)=GroupOverlap RIDAGEYR Male Ethno2 Educ2 Smoke HIQ011/expb clparm;
contrast 'COPD vs. Double' GroupOverlap 1 0 -1 0/estimate=exp;
run;

*mortality;
proc surveyphreg data=coh1_MortLink; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT4YR;
class GroupOverlap (PARAM=REF REF='Double, not obese')
	  Smoke (PARAM=REF REF='0');
model PERMTH_INT*MORTSTAT(0)= GroupOverlap RIDAGEYR Male Ethno2 Educ2 Smoke HIQ011/
risklimit vadjust=DF ties=efron;
run;


**additional Analyses Dec 18th;
*(1);
proc sort data=crosscoh;
by GroupOverlap;run;

proc surveyfreq data=crosscoh; 
format 
GroupOverlap group8g.
Cohort namecoh.
SDDSRVYR nameyr.
;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
by GroupOverlap;
table 
Cohort /*GroupOverlap
SDDSRVYR*GroupOverlap*/
/cl row chisq;
run;
proc surveylogistic data=crosscoh;
format GroupOverlap group8g.
		Cohort namecoh.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
by GroupOverlap;
model Ethno2(event="1")=/expb clparm;
run;

*(2);
proc surveymeans data=crosscoh all;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
var RIDAGEYR;run;
proc surveyreg data=crosscoh;
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
class GroupOverlap(PARAM=REF REF='Double, not obese');
model RIDAGEYR=GroupOverlap/clparm solution;
run;

proc surveyfreq data=crosscoh; 
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
table Male Ethno2/cl;
run;

*(3);
proc surveymeans data=crosscoh;
format 
GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
domain GroupOverlap;
var RIDAGEYR;run;
proc surveyfreq data=crosscoh; 
format 
GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT8YR;
table 
(Male Ethno2 Educ2 Smoke HIQ011)*
GroupOverlap
/cl row chisq;
run;

proc surveyfreq data=overlap_comb;
format GroupOverlap group8g.
		Cohort namecoh.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT2YR;
tables 
Cohort*GroupOverlap/cl row chisq;
run;

*full sample with both cohorts;
proc surveyfreq data=overlap_comb;
format Cohort namecoh.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
Cohort*(COPD OSA Obese)
/cl row chisq;
run;
proc sort data=just_overlap_comb;
by GroupOverlap;run;
proc surveyfreq data=just_overlap_comb;
format Cohort namecoh.
		GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
tables Cohort*GroupOverlap/
chisq cl row;
run;

proc surveymeans data=overlap_comb;
format 
GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
domain GroupOverlap;
var RIDAGEYR;run;

proc surveyreg data=just_overlap_comb;
format 
GroupOverlap group8g.;
class GroupOverlap;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
model RIDAGEYR=GroupOverlap;run;

proc surveyfreq data=just_overlap_comb; 
format 
GroupOverlap group8g.
Ethno5 eth5no.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
table 
GroupOverlap*MenoStat2
/cl row chisq;
run;
proc surveyfreq data=just_overlap_comb; 
format Ethno4 eth4no.
		GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
table Ethno4*GroupOverlap
/cl  row col chisq;
run;
proc surveyfreq data=just_overlap_comb; 
format 
GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
table 
GroupOverlap*Diabetes
/cl row nototal chisq;
run;
data overlap_comb;
set overlap_comb;
if GroupOverlap=1 then Triple=1;
else Triple=0;
run;
proc surveylogistic data=overlap_comb;
class HIQ011 (REF='1');
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
model Triple (event='1')=HIQ011/expb ;
run;

proc sort data=just_overlap_comb;
by GroupOverlap;run;
proc surveyfreq data=just_overlap_comb; 
by GroupOverlap;
format 
GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
table 
Cohort
/cl chisq wald row;
run;

*survival;
proc sort data=cohcomb_MortLink;
by GroupOverlap MORTSTAT Cohort; run;
proc surveymeans data=cohcomb_MortLink; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
by GroupOverlap MORTSTAT Cohort;
var PERMTH_INT;
run;
proc surveylogistic data=cohcomb_MortLink; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
class GroupOverlap (PARAM=REF REF='Double, not obese');
domain Cohort;
model MORTSTAT(event='Assumed deceased')=GroupOverlap/expb clparm;
run;

proc surveyphreg data=cohcomb_MortLink; 
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight FullWgt;
class GroupOverlap (PARAM=REF REF='Double, not obese');
model PERMTH_INT*MORTSTAT(0)= GroupOverlap/
risklimit vadjust=none ties=efron;
	title "Proportional Hazards of death";
run;


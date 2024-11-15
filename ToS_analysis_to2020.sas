*cohort sizes;
proc surveyfreq data=overlap_comb;
format Cohort namecoh.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables Cohort/cl;
run;
*get overall prev rates;
proc surveyfreq data=overlap_comb;
format GroupOverlap group8g.
		Cohort namecoh.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
GroupOverlap*Cohort
/cl row chisq;
run;
*indicate difference in syndromes;
proc surveyfreq data=just_overlap_comb;
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
GroupOverlap
/cl row chisq;
run;

*consider age;
proc surveymeans data=just_overlap_comb;
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
domain GroupOverlap/diff;
var RIDAGEYR; 
run;

*sex diff;
proc surveyfreq data=overlap_comb;
format RIAGENDR gendlab.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
RIAGENDR
MenoStat2
/cl row chisq;
run;
*indicate difference in syndromes;
proc surveyfreq data=just_overlap_comb;
format GroupOverlap group8g.
		RIAGENDR gendlab.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
GroupOverlap*RIAGENDR
GroupOverlap*MenoStat2
/cl row chisq;
run;

*ethnic diff;
proc surveyfreq data=overlap_comb;
format Ethno4 eth4no.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
Ethno4/cl row chisq;
run;
*indicate difference in syndromes;
proc surveyfreq data=just_overlap_comb;
format GroupOverlap group8g.
		Ethno4 eth4no.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
GroupOverlap*Ethno4
/cl row chisq;
run;

*marital diff;
proc surveyfreq data=overlap_comb;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
Educ2/cl row chisq;
run;
*indicate difference in syndromes;
proc surveyfreq data=just_overlap_comb;
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
GroupOverlap*Partnered
/cl row chisq;
run;


*education diff;
proc surveyfreq data=overlap_comb;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
Educ2/cl row chisq;
run;
*indicate difference in syndromes;
proc surveyfreq data=just_overlap_comb;
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
GroupOverlap*Educ2
/cl row chisq;
run;

*health insurance diff;
proc surveyfreq data=overlap_comb;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
HIQ011/cl row chisq;
run;
*indicate difference in syndromes;
proc surveyfreq data=just_overlap_comb;
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
GroupOverlap*HIQ011
/cl row chisq;
run;

*poverty diff;
proc surveyfreq data=overlap_comb;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
FPR3/cl row chisq;
run;
*indicate difference in syndromes;
proc surveyfreq data=just_overlap_comb;
format GroupOverlap group8g.
	   FPR3 fpr3lab.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
GroupOverlap*FPR3
/cl row chisq;
run;

*smoke diff;
proc surveyfreq data=overlap_comb;
format Smoke smocat.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
Smoke/cl row chisq;
run;
*indicate difference in syndromes;
proc surveyfreq data=just_overlap_comb;
format GroupOverlap group8g.
		Smoke smocat.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
GroupOverlap*Smoke
/cl row chisq;
run;

*comorbid diff;
proc surveyfreq data=overlap_comb;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
MCQ010
MCQ160d
MCQ160f
MCQ160b
BPQ020
MCQ160e
MCQ160c
MCQ220
MCQ160l
Diabetes
/cl row chisq;
run;
*indicate difference in syndromes;
proc surveyfreq data=just_overlap_comb;
format GroupOverlap group8g.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
GroupOverlap*
(MCQ010
MCQ160d
MCQ160f
MCQ160b
BPQ020
MCQ160e
MCQ160c
MCQ220
MCQ160l
Diabetes)
/cl row chisq;
run;

*cohort changes in double and triple;
proc surveyfreq data=overlap_comb;
format GroupOverlap group8g.
		Cohort namecoh.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
Cohort*GroupOverlap/cl row chisq;
run;

proc surveyfreq data=overlap_comb;
format Cohort namecoh.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
Cohort*(COPD OSA Obese)/cl row chisq;
run;
ods html close;
ods html file="outputTable1_ToS_Sept18_24.html" style=journal ;
***********updated******91824*******;
*compare cohorts;
*age in years;
proc surveymeans data=overlap_comb;
format Cohort namecoh.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
domain Cohort/diff;
var RIDAGEYR; 
run;
*age categories;
proc surveyfreq data=overlap_comb;
format Cohort namecoh.
		AgeCat agecatlab.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
Cohort*AgeCat/cl row chisq;
run;

*sex/gender categories;
proc surveyfreq data=overlap_comb;
format Cohort namecoh.
		Male malelab.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
Cohort*Male/cl row chisq;
run;

*race/ethnicity categories;
proc surveyfreq data=overlap_comb;
format Cohort namecoh.
	   Ethno4 eth4no.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
Cohort*Ethno4/cl row chisq;
run;

*education categories;
proc surveyfreq data=overlap_comb;
format Cohort namecoh.
	    Educ2 edu2lab.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
Cohort*Educ2/cl row chisq;
run;

*insurance categories;
proc surveyfreq data=overlap_comb;
format Cohort namecoh.
		HIQ011 insurelab.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
Cohort*HIQ011/cl row chisq;
run;

*income-poverty ratio categories;
proc surveyfreq data=overlap_comb;
format Cohort namecoh.
	    FPR3 fpr3lab.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
Cohort*FPR3/cl row chisq;
run;

*copd;
proc surveyfreq data=overlap_comb;
format Cohort namecoh.
	    COPD copdlab.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
Cohort*COPD/cl row chisq;
run;
*osa;
proc surveyfreq data=overlap_comb;
format Cohort namecoh.
	    OSA osalab.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
Cohort*OSA/cl row chisq;
run;
*obesity;
proc surveyfreq data=overlap_comb;
format Cohort namecoh.
	    Obese obeselab.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
tables 
Cohort*Obese/cl row chisq;
run;
*ods html close;
*ods html file="outputTable2_ToS_Sept19_24.html" style=journal;
*age adjusted prevalence;
*overall;
*unadjusted prevalence;
proc sort data=overlap_comb;
by Cohort AgeCat;run;
ods output statistics=ToSprev;
proc surveymeans data=overlap_comb mean sum nomcar sumwgt;
by Cohort AgeCat;
*format Cohort namecoh.
	   AgeCat agecatlab.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
var ToS;
run;
ods output close;
data fromCensus;
	input Cohort AgeCat population;
	datalines;
1	1	43676000
1	2	57887000
1	3	39699000
2	1	41153000
2	2	64105000
2	3	5430300
;
run;
*get the separate Rate and CL info for each cohort and age strata;
proc stdrate data=ToSprev refdata=fromcensus
method=direct stat=rate(mult=100) 
plots(stratum=vertical)=rate;
population event=sum total=SumWgt;
reference total=population;
strata AgeCat/stats(cl=normal);
by Cohort;
run; 
*get the overall cohort differences rate ratio and CL;
proc stdrate data=ToSprev refdata=fromcensus
method=direct stat=rate(mult=100) effect 
plots(only)=(dist effect);
population group=Cohort event=sum total=SumWgt;
reference total=population;
strata AgeCat/effect;
run;
*rate diff to get p;
proc stdrate data=ToSprev refdata=fromcensus
method=direct stat=rate(mult=100) effect=diff 
plots(only)=(dist effect);
population group=Cohort event=sum total=SumWgt;
reference total=population;
strata AgeCat/effect;
run;

*for sex;
proc sort data=overlap_comb;
by Male Cohort AgeCat;run;
ods output statistics=ToSprevSex;
proc surveymeans data=overlap_comb mean sum nomcar sumwgt;
by Male Cohort AgeCat;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
var ToS;
run;
ods output close;
*get the overall cohort differences rate ratio and CL by sex;
proc stdrate data=ToSprevSex refdata=fromcensus
method=direct stat=rate(mult=100) effect 
plots(only)=(dist effect);
population group=Cohort event=sum total=SumWgt;
reference total=population;
strata AgeCat/effect;
by Male;
run;  

*for race/ethnicity;
proc sort data=overlap_comb;
by Ethno4 Cohort AgeCat;run;
ods output statistics=ToSprevEthno;
proc surveymeans data=overlap_comb mean sum nomcar sumwgt;
by Ethno4 Cohort AgeCat;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
var ToS;
run;
ods output close;
*get the overall cohort differences rate ratio and CL by ethnicity;
proc stdrate data=ToSprevEthno refdata=fromcensus
method=direct stat=rate(mult=100) effect 
plots(only)=(dist effect);
population group=Cohort event=sum total=SumWgt;
reference total=population;
strata AgeCat/effect;
by Ethno4;
run;

*for education;
proc sort data=overlap_comb;
by Educ2 Cohort AgeCat;run;
ods output statistics=ToSprevEduc2;
proc surveymeans data=overlap_comb mean sum nomcar sumwgt;
by Educ2 Cohort AgeCat;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
var ToS;
run;
ods output close;
data ToSprevEduc2;
set ToSprevEduc2;
if Educ2~=.;
run;
*get the overall cohort differences rate ratio and CL by education;
proc stdrate data=ToSprevEduc2 refdata=fromcensus
method=direct stat=rate(mult=100) effect 
plots(only)=(dist effect);
population group=Cohort event=sum total=SumWgt;
reference total=population;
strata AgeCat/effect;
by Educ2;
run;

*for insured;
proc sort data=overlap_comb;
by HIQ011 Cohort AgeCat;run;
ods output statistics=ToSprevIns;
proc surveymeans data=overlap_comb mean sum nomcar sumwgt;
by HIQ011 Cohort AgeCat;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
var ToS;
run;
ods output close;
data ToSprevIns;
set ToSprevIns;
if HIQ011~=.;
run;
*get the overall cohort differences rate ratio and CL by insured;
proc stdrate data=ToSprevIns refdata=fromcensus
method=direct stat=rate(mult=100) effect 
plots(only)=(dist effect);
population group=Cohort event=sum total=SumWgt;
reference total=population;
strata AgeCat/effect;
by HIQ011;
run;

*for FPR;
proc sort data=overlap_comb;
by FPR3 Cohort AgeCat;run;
ods output statistics=ToSprevFPR;
proc surveymeans data=overlap_comb mean sum nomcar sumwgt;
by FPR3 Cohort AgeCat;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
var ToS;
run;
ods output close;
data ToSprevFPR;
set ToSprevFPR;
if FPR3~=.;
run;
*get the overall cohort differences rate ratio and CL by fpr;
proc stdrate data=ToSprevFPR refdata=fromcensus
method=direct stat=rate(mult=100) effect 
plots(only)=(dist effect);
population group=Cohort event=sum total=SumWgt;
reference total=population;
strata AgeCat/effect;
by FPR3;
run;

*logistic regression;
data overlap_comb;
set overlap_comb;
if GroupOverlap=1 then Triple=1;
else Triple=0;
run;
*age gender ethnicity;
proc surveylogistic data=overlap_comb;
format 
AgeCat agecatlab.
Male gendlab.
Ethno4 eth4no.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
class AgeCat(REF='40-49')
	  Male (REF='Male')
	  Ethno4(REF='Non-Hispanic White')
	  ;
model Triple (event='1')=AgeCat Male Ethno4/expb ;
run;
*education;
proc surveylogistic data=overlap_comb;
format 
AgeCat agecatlab.
Male gendlab.
Ethno4 eth4no. 
Educ2 edu2lab.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
class 
AgeCat(REF='40-49')
Male (REF='Male')
Ethno4(REF='Non-Hispanic White')
Educ2(REF='less than HS');
model Triple (event='1')=AgeCat Male Ethno4 Educ2/expb ;
run;
*insured;
proc surveylogistic data=overlap_comb;
format 
AgeCat agecatlab.
Male gendlab.
Ethno4 eth4no. 
HIQ011 insurelab.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
class 
AgeCat(REF='40-49')
Male (REF='Male')
Ethno4(REF='Non-Hispanic White')
HIQ011(REF='Insured');
model Triple (event='1')=AgeCat Male Ethno4 HIQ011/expb ;
run;
*family-poverty;
proc surveylogistic data=overlap_comb;
format 
AgeCat agecatlab.
Male gendlab.
Ethno4 eth4no. 
FPR3 fpr3lab.;
cluster SDMVPSU;
strata SDMVSTRA;
weight WTINT92YR;
class 
AgeCat(REF='40-49')
Male (REF='Male')
Ethno4(REF='Non-Hispanic White')
FPR3(REF='High Economic Hardship (<130%)');
model Triple (event='1')=AgeCat Male Ethno4 FPR3/expb ;
run;


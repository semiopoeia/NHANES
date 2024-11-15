PROC IMPORT OUT= WORK.NHANES 
            DATAFILE= "C:\Users\pws5\OneDrive - University of Pittsburgh
\Desktop\Merged 2015 2018_Jan 2021.dta" 
            DBMS=STATA REPLACE;RUN;
data NHANES1;set NHANES;
if RIDEXPRG~=1;
MVPA=sum(ModerateLeisure,VigLeisure);
if(MVPA>=500) then dichMVPA=1;
if (MVPA<500) then dichMVPA=0;
if (MVPA=.) then dichMVPA=.;
if(rcDBQ700<3) then diet=0;
if (rcDBQ700>=3) then diet=1;
if (rcDBQ700=.)then diet=.;
if (BMXBMI<30) then BMI_2cat=0;
if (BMXBMI>=30) then BMI_2cat=1;
if (BMXBMI=.) then BMI_2cat=.;
dietQRC=5-rcDBQ700;
MAP2perc=MAP2*10;
if(METS_Z_score>=1) then dichMETSz=1;
if(METS_Z_score<1) then dichMETSz=0;
if (dyslipidemia=9)then dyslipidemia=.;
run;
proc sort data=NHANES1; by Gender;run;
proc surveymeans data=NHANES1;
strata SDMVSTRA;
cluster SDMVPSU;
weight WTMEC4YR;
var rcDBQ700;run;

proc surveyreg data=NHANES1;
strata SDMVSTRA;
cluster SDMVPSU;
weight WTMEC4YR;
class Gender(ref='0') AgeGrp(ref='0');
model METS_Z_score= MAP2perc/solution stb;
run;
proc sort data=NHANES1; by Race2; run;
proc surveyreg data=NHANES1;
by Race2;
strata SDMVSTRA;
cluster SDMVPSU;
weight WTMEC4YR;
class Gender(ref='1') AgeGrp(ref='0') dichMVPA (ref='1');
model METS_Z_score= MAP2perc AgeGrp BMXBMI Gender dietQRC dichMVPA/solution stb;
run;
/*proc surveyreg data=NHANES1;
strata SDMVSTRA;
cluster SDMVPSU;
weight WTMEC4YR;
class Gender(ref='0') AgeGrp(ref='0');
model MAP2perc= METS_Z_score/solution;
run;
proc surveyreg data=NHANES1;
strata SDMVSTRA;
cluster SDMVPSU;
weight WTMEC4YR;
class Gender(ref='0') AgeGrp(ref='0');
model MAP2perc=METS_Z_score AgeGrp BMXBMI Gender rcDBQ700 dichMVPA/solution;
run;

proc surveylogistic data=NHANES1;
strata SDMVSTRA;
cluster SDMVPSU;
weight WTMEC4YR;
class Gender(ref='0') AgeGrp(ref='0');
model dichMETSz= MAP2perc;
run;
proc surveylogistic data=NHANES1;
strata SDMVSTRA;
cluster SDMVPSU;
weight WTMEC4YR;
class Gender(ref='0') AgeGrp(ref='0');
model dichMETSz= MAP2perc AgeGrp BMXBMI Gender rcDBQ700 dichMVPA;
run;*/
*for odds ratio;
data NHANES2;
set 'C:\Users\pws5\OneDrive - University of Pittsburgh\Documents\merged_2015_2018_packyr.sas7bdat';
if (packyear_cat=1) then former_smk=1;
if (packyear_cat=0) then former_smk=0;
if (packyear_cat=2) then current_smk=1;
if (packyear_cat=0) then current_smk=0;
run;
proc sort data=NHANES1;
by SEQN;run;
proc sort data=NHANES2;
by SEQN; run;
data NHANES3;
merge NHANES2 NHANES1;
by SEQN;
run;

proc surveyfreq data=NHANES3;
strata SDMVSTRA;
cluster SDMVPSU;
weight WTMEC4YR;
table(MAP2_2cat MetSyn MS4_R 
BMI_2cat MS1_R dyslipidemia rec_LTPA diet former_smk current_smk)* 
METS_Z_score_2cat/or alpha=0.05 row col;
tables(METS_Z_score_2cat MetSyn MS4_R 
BMI_2cat MS1_R dyslipidemia rec_LTPA diet former_smk current_smk)*
MAP2_2cat/or alpha=0.05 row col;
run;

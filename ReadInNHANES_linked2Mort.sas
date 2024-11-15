*********************************************************************************************
September 2018

** PUBLIC-USE LINKED MORTALITY FOLLOW-UP THROUGH DECEMBER 31, 2015 **

The following SAS code can be used to read the fixed-width format ASCII public-use Linked
Mortality Files (LMFs) from a stored location into a temporary SAS work dataset.  Basic 
frequencies are also produced.  
 
NOTE:  The format definitions given below will result in
       procedure output showing values that have been
       grouped as they are shown in the file layout
       documentation.

NOTE:  In order to read the public-use linked mortality ASCII file 
       into a permanent SAS dataset, please consult SAS documentation
       and modify the program accordingly.

NOTE:  As some variables are survey specific, we have created two versions of the program. 
		One for NHANES, another of NHIS 

*********************************************************************************************


To download and save the public-use LMFs to your hard drive, follow these steps:

*Step 1: Designate a folder on your hard drive to download the public-use LMF. 
		 In this example, the data will be saved to: 'C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop'

*Step 2: To dowload the public-use LMF, go to the web site: 
	     ftp://ftp.cdc.gov/pub/health_statistics/nchs/datalinkage/linked_mortality/.

         Right click on the desired survey link and select "Save target as...".  A "Save As"
         screen will appear where you will need to select and input a location where to
         save the data file on your hard drive.  

         Also note that the "Save as type:" box should read "DAT File (*.dat)".  This will ensure
         that the data file is saved to your hard drive in the correct format.  

         In this example, the data file is saved in the folder, "C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop", and the 
         data file is saved as "<SURVEYNAME>_MORT_2015_PUBLIC.DAT". 

****************;
*NHANES VERSION*;
****************;

* Define variable values for reports;
PROC FORMAT;
  VALUE PREMISS 
	.='MISSING'
   	OTHER='PRESENT';

  VALUE ELIGFMT
    1 = "Eligible"
    2 = "Under age 18, not available for public release"
    3 = "Ineligible";

  VALUE MORTFMT
    0 = "Assumed alive"
    1 = "Assumed deceased"
    . = "Ineligible or under age 18";

  VALUE FLAGFMT
    0 = "No - Condition not listed as a multiple cause of death"
    1 = "Yes - Condition listed as a multiple cause of death"  
    . = "Assumed alive, under age 18, ineligible for mortality follow-up, or MCOD not available";

  VALUE $UCODFMT
		"001" = "Diseases of heart (I00-I09, I11, I13, I20-I51)"
		"002" = "Malignant neoplasms (C00-C97)"
		"003" = "Chronic lower respiratory diseases (J40-J47)"
		"004" = "Accidents (unintentional injuries) (V01-X59, Y85-Y86)"
		"005" = "Cerebrovascular diseases (I60-I69)"
		"006" = "Alzheimer's disease (G30)"
		"007" = "Diabetes mellitus (E10-E14)"
		"008" = "Influenza and pneumonia (J09-J18)"
		"009" = "Nephritis, nephrotic syndrome and nephrosis (N00-N07, N17-N19, N25-N27)"
		"010" = "All other causes (residual)" 
		"   " = "Ineligible, under age 18, assumed alive, or no cause of death data";

RUN;

*Create a temporary SAS work dataset;

DATA MortLinkNHANES_07_08;		/* For example, NHANES_1999_2000 */

INFILE "C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\BaniakLuyster\
NHANES_2007_2008_MORT_2015_PUBLIC.dat"  LRECL = 61 PAD MISSOVER ;
* INPUT VARIABLES;
INPUT
	
	SEQN			1-5 	
	ELIGSTAT		15
	MORTSTAT		16
	UCOD_LEADING	$17-19
	DIABETES		20
	HYPERTEN		21
	PERMTH_INT		43-45	
	PERMTH_EXM		46-48	
     ;

* DEFINE VARIABLE LABELS;
LABEL
	SEQN			=	'NHANES Respondent Sequence Number'
	ELIGSTAT		=	'Eligibility Status for Mortality Follow-up'
	MORTSTAT		=	'Final Mortality Status'
	UCOD_LEADING	=	'Underlying Leading Cause of Death: Recode'
	DIABETES		=	'Diabetes Flag from Multiple Cause of Death (MCOD)'
	HYPERTEN		=	'Hypertension Flag from Multiple Cause of Death (MCOD)'
	PERMTH_INT		=	'Number of Person-Months of Follow-up from NHANES Interview date'
	PERMTH_EXM		=	'Number of Person-Months of Follow-up from NHANES Mobile Examination Center (MEC) Date'
;

   * ASSOCIATE VARIABLES WITH FORMAT VALUES;
FORMAT    
	ELIGSTAT 		ELIGFMT.          
	MORTSTAT 		MORTFMT.
	UCOD_LEADING	UCODFMT.
	DIABETES 		FLAGFMT.          
	HYPERTEN 		FLAGFMT. 
	PERMTH_INT PERMTH_EXM PREMISS.
;
RUN;


OPTIONS PAGENO=1;
TITLE1 "MortLinkNHANES_07_08 PUBLIC-USE LINKED MORTALITY FILE";

*RUN PROC CONTENTS;
PROC CONTENTS DATA=MortLinkNHANES_07_08 VARNUM; RUN;

*RUN FREQUENCIES;
PROC FREQ DATA=MortLinkNHANES_07_08;
TABLES 
	ELIGSTAT
	MORTSTAT 
	UCOD_LEADING 
	DIABETES
	HYPERTEN 
	PERMTH_INT	
	PERMTH_EXM	

	/ MISSING;
TITLE1 "MortLinkNHANES_07_08 PUBLIC-USE LINKED MORTALITY FILE";
TITLE2 "UNWEIGHTED FREQUENCIES";

* USER NOTE: TO SEE UNFORMATTED VALUES IN THE FREQUENCY PROCEDURE, 
  UNCOMMENT THE STATEMENT "FORMAT _ALL_" BELOW ;
* FORMAT _ALL_;
RUN;

* Define variable values for reports;
PROC FORMAT;
  VALUE PREMISS 
	.='MISSING'
   	OTHER='PRESENT';

  VALUE ELIGFMT
    1 = "Eligible"
    2 = "Under age 18, not available for public release"
    3 = "Ineligible";

  VALUE MORTFMT
    0 = "Assumed alive"
    1 = "Assumed deceased"
    . = "Ineligible or under age 18";

  VALUE FLAGFMT
    0 = "No - Condition not listed as a multiple cause of death"
    1 = "Yes - Condition listed as a multiple cause of death"  
    . = "Assumed alive, under age 18, ineligible for mortality follow-up, or MCOD not available";

  VALUE $UCODFMT
		"001" = "Diseases of heart (I00-I09, I11, I13, I20-I51)"
		"002" = "Malignant neoplasms (C00-C97)"
		"003" = "Chronic lower respiratory diseases (J40-J47)"
		"004" = "Accidents (unintentional injuries) (V01-X59, Y85-Y86)"
		"005" = "Cerebrovascular diseases (I60-I69)"
		"006" = "Alzheimer's disease (G30)"
		"007" = "Diabetes mellitus (E10-E14)"
		"008" = "Influenza and pneumonia (J09-J18)"
		"009" = "Nephritis, nephrotic syndrome and nephrosis (N00-N07, N17-N19, N25-N27)"
		"010" = "All other causes (residual)" 
		"   " = "Ineligible, under age 18, assumed alive, or no cause of death data";

RUN;


*Create a temporary SAS work dataset;

DATA MortLinkNHANES_09_10;		/* For example, NHANES_1999_2000 */

INFILE "C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\BaniakLuyster\
NHANES_2009_2010_MORT_2015_PUBLIC.dat"  LRECL = 61 PAD MISSOVER ;
* INPUT VARIABLES;
INPUT
	
	SEQN			1-5 	
	ELIGSTAT		15
	MORTSTAT		16
	UCOD_LEADING	$17-19
	DIABETES		20
	HYPERTEN		21
	PERMTH_INT		43-45	
	PERMTH_EXM		46-48	
     ;

* DEFINE VARIABLE LABELS;
LABEL
	SEQN			=	'NHANES Respondent Sequence Number'
	ELIGSTAT		=	'Eligibility Status for Mortality Follow-up'
	MORTSTAT		=	'Final Mortality Status'
	UCOD_LEADING	=	'Underlying Leading Cause of Death: Recode'
	DIABETES		=	'Diabetes Flag from Multiple Cause of Death (MCOD)'
	HYPERTEN		=	'Hypertension Flag from Multiple Cause of Death (MCOD)'
	PERMTH_INT		=	'Number of Person-Months of Follow-up from NHANES Interview date'
	PERMTH_EXM		=	'Number of Person-Months of Follow-up from NHANES Mobile Examination Center (MEC) Date'
;

   * ASSOCIATE VARIABLES WITH FORMAT VALUES;
FORMAT    
	ELIGSTAT 		ELIGFMT.          
	MORTSTAT 		MORTFMT.
	UCOD_LEADING	UCODFMT.
	DIABETES 		FLAGFMT.          
	HYPERTEN 		FLAGFMT. 
	PERMTH_INT PERMTH_EXM PREMISS.
;
RUN;


OPTIONS PAGENO=1;
TITLE1 "MortLinkNHANES_09_10 PUBLIC-USE LINKED MORTALITY FILE";

*RUN PROC CONTENTS;
PROC CONTENTS DATA=MortLinkNHANES_09_10 VARNUM; RUN;

*RUN FREQUENCIES;
PROC FREQ DATA=MortLinkNHANES_09_10;
TABLES 
	ELIGSTAT
	MORTSTAT 
	UCOD_LEADING 
	DIABETES
	HYPERTEN 
	PERMTH_INT	
	PERMTH_EXM	

	/ MISSING;
TITLE1 "MortLinkNHANES_09_10 PUBLIC-USE LINKED MORTALITY FILE";
TITLE2 "UNWEIGHTED FREQUENCIES";

* USER NOTE: TO SEE UNFORMATTED VALUES IN THE FREQUENCY PROCEDURE, 
  UNCOMMENT THE STATEMENT "FORMAT _ALL_" BELOW ;
* FORMAT _ALL_;
RUN;

* Define variable values for reports;
PROC FORMAT;
  VALUE PREMISS 
	.='MISSING'
   	OTHER='PRESENT';

  VALUE ELIGFMT
    1 = "Eligible"
    2 = "Under age 18, not available for public release"
    3 = "Ineligible";

  VALUE MORTFMT
    0 = "Assumed alive"
    1 = "Assumed deceased"
    . = "Ineligible or under age 18";

  VALUE FLAGFMT
    0 = "No - Condition not listed as a multiple cause of death"
    1 = "Yes - Condition listed as a multiple cause of death"  
    . = "Assumed alive, under age 18, ineligible for mortality follow-up, or MCOD not available";

  VALUE $UCODFMT
		"001" = "Diseases of heart (I00-I09, I11, I13, I20-I51)"
		"002" = "Malignant neoplasms (C00-C97)"
		"003" = "Chronic lower respiratory diseases (J40-J47)"
		"004" = "Accidents (unintentional injuries) (V01-X59, Y85-Y86)"
		"005" = "Cerebrovascular diseases (I60-I69)"
		"006" = "Alzheimer's disease (G30)"
		"007" = "Diabetes mellitus (E10-E14)"
		"008" = "Influenza and pneumonia (J09-J18)"
		"009" = "Nephritis, nephrotic syndrome and nephrosis (N00-N07, N17-N19, N25-N27)"
		"010" = "All other causes (residual)" 
		"   " = "Ineligible, under age 18, assumed alive, or no cause of death data";

RUN;


*Create a temporary SAS work dataset;

DATA MortLinkNHANES_11_12;		/* For example, NHANES_1999_2000 */

INFILE "C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\BaniakLuyster\
NHANES_2011_2012_MORT_2015_PUBLIC.dat"  LRECL = 61 PAD MISSOVER ;
* INPUT VARIABLES;
INPUT
	
	SEQN			1-5 	
	ELIGSTAT		15
	MORTSTAT		16
	UCOD_LEADING	$17-19
	DIABETES		20
	HYPERTEN		21
	PERMTH_INT		43-45	
	PERMTH_EXM		46-48	
     ;

* DEFINE VARIABLE LABELS;
LABEL
	SEQN			=	'NHANES Respondent Sequence Number'
	ELIGSTAT		=	'Eligibility Status for Mortality Follow-up'
	MORTSTAT		=	'Final Mortality Status'
	UCOD_LEADING	=	'Underlying Leading Cause of Death: Recode'
	DIABETES		=	'Diabetes Flag from Multiple Cause of Death (MCOD)'
	HYPERTEN		=	'Hypertension Flag from Multiple Cause of Death (MCOD)'
	PERMTH_INT		=	'Number of Person-Months of Follow-up from NHANES Interview date'
	PERMTH_EXM		=	'Number of Person-Months of Follow-up from NHANES Mobile Examination Center (MEC) Date'
;

   * ASSOCIATE VARIABLES WITH FORMAT VALUES;
FORMAT    
	ELIGSTAT 		ELIGFMT.          
	MORTSTAT 		MORTFMT.
	UCOD_LEADING	UCODFMT.
	DIABETES 		FLAGFMT.          
	HYPERTEN 		FLAGFMT. 
	PERMTH_INT PERMTH_EXM PREMISS.
;
RUN;


OPTIONS PAGENO=1;
TITLE1 "MortLinkNHANES_11_12 PUBLIC-USE LINKED MORTALITY FILE";

*RUN PROC CONTENTS;
PROC CONTENTS DATA=
MortLinkNHANES_11_12 VARNUM; RUN;

*RUN FREQUENCIES;
PROC FREQ DATA=MortLinkNHANES_11_12;
TABLES 
	ELIGSTAT
	MORTSTAT 
	UCOD_LEADING 
	DIABETES
	HYPERTEN 
	PERMTH_INT	
	PERMTH_EXM	

	/ MISSING;
TITLE1 "MortLinkNHANES_11_12 PUBLIC-USE LINKED MORTALITY FILE";
TITLE2 "UNWEIGHTED FREQUENCIES";

* USER NOTE: TO SEE UNFORMATTED VALUES IN THE FREQUENCY PROCEDURE, 
  UNCOMMENT THE STATEMENT "FORMAT _ALL_" BELOW ;
* FORMAT _ALL_;
RUN;

*append cohorts;
proc datasets;
append base=work.MortLinkNHANES_07_08
data=work.MortLinkNHANES_09_10;
run;
proc datasets;
append base=work.MortLinkNHANES_07_08
data=work.MortLinkNHANES_11_12;
run;

**append BPX from NHANES 7-12;
proc datasets;
append base=work.Bpx_e
data=work.Bpx_f;
run;
proc datasets;
append base=work.Bpx_e
data=work.Bpx_g;
run;

*merge morality data with NHANES BPX;
proc sort 
data=work.MortLinkNHANES_07_08
out=Mortality;
by SEQN; run;
proc sort
data=work.Bpx_e
out=BPX;
by SEQN; run;

data MortBPX_7_12;
merge Mortality BPX;
by SEQN; run;

*bring in BPQ;
proc datasets;
append base=work.Bpq_e
data=work.Bpq_f;
run;
proc datasets;
append base=work.Bpq_e
data=work.Bpq_g;
run;

*merge morality data with NHANES BPQ;
proc sort 
data=work.MortLinkNHANES_07_08
out=Mortality;
by SEQN; run;
proc sort
data=work.Bpq_e
out=BPQ;
by SEQN; run;

data MortBPQ_7_12;
merge Mortality BPQ;
by SEQN; run;

*questionaire and exam;
data MortBPQX_7_12;
merge MortBPX_7_12 BPQ;
by SEQN; run;
*bring in spss data;
PROC IMPORT OUT= WORK.REVISDAT 
            DATAFILE= "C:\Users\PWS5\OneDrive - University of Pittsburgh
\Desktop\SleepHUB\BaniakLuyster\Revision dataset 10.12.21.sav" 
            DBMS=SPSS REPLACE;

RUN;
*/
*imported revised spss file as revisdat;
proc sort
data=revisdat
out=revisdat;
by seqn; run;
proc sort 
data=MortBPQ_7_12
out=MortBPQ_7_12;
by seqn; run;
data CollectDat;
merge Revisdat MortBPQ_7_12;
by seqn;
run; 


data ReadyToAnalyze;
set CollectDat;
if MCQ160D>2 then MCQ160D=.;
if MCQ160B>2 then MCQ160B=.;
if BPQ020>2 then BPQ020=.;
if MCQ160C>2 then MCQ160C=.;
if MCQ160E>2 then MCQ160E=.;
if MCQ160F>2 then MCQ160F=.;
if ((MCQ160D=1) or (MCQ160B=1) or (BPQ020=1)
or (MCQ160C=1) or (MCQ160E=1) or (MCQ160F=1))
then CVD=1;
if ((MCQ160D=2) and (MCQ160B=2) and (BPQ020=2)
and (MCQ160C=2) and (MCQ160E=2) and (MCQ160F=2))
then CVD=2;
if ((MCQ160D=.) and (MCQ160B=.) and (BPQ020=.)
and (MCQ160C=.) and (MCQ160E=.) and (MCQ160F=.))
then CVD=.;
run;



proc freq data=ReadyToAnalyze;
tables CVD*(MCQ160D MCQ160B BPQ020 MCQ160C MCQ160E MCQ160F);
run;

*incorporate the poverty index;
*bring in INQ;
proc datasets;
append base=work.Inq_e
data=work.Inq_f;
run;
proc datasets;
append base=work.Inq_e
data=work.Inq_g;
run;

*merge ready data with NHANES INQ;
proc sort 
data=ReadyToAnalyze
out=ReadyToAnalyze;
by SEQN; run;
proc sort
data=Inq_e
out=INQ;
by SEQN; run;

data ReadyToAnalyze;
merge ReadyToAnalyze INQ;
by SEQN; run;

data ReadyToAnalyze;
set ReadyToAnalyze;
if INDFMMPI>=2 then PovertyIndex=1;
if INDFMMPI<2 then PovertyIndex=0;
if INDFMMPI=. then PovertyIndex=.;
run;

*bring in wgt;
proc datasets;
append base=work.demo_e
data=work.demo_f;
run;
proc datasets;
append base=work.demo_e
data=work.demo_g;
run;

*merge ready data with NHANES demo for wgts;
proc sort 
data=ReadyToAnalyze
out=ReadyToAnalyze;
by SEQN; run;
proc sort
data=demo_e
out=DEMO;
by SEQN; run;
data WGT;
set DEMO;
keep SEQN WTINT2YR WTMEC2YR SDMVPSU SDMVSTRA;
run;
proc sort
data=WGT
out=WGT;
by SEQN;run;
data ReadyToAnalyze;
merge ReadyToAnalyze WGT;
by SEQN; run;
*create 6 year weight;
data ReadyToAnalyze;
set ReadyToAnalyze;
IntWGT6yr=WTINT2YR/3;
run;
*create smoke;
data ReadyToAnalyze;
set ReadyToAnalyze;
if (SMQ040='1')or(SMQ040='2') then Smoke=2;
if (SMQ040='3') and (SMQ020=1) then Smoke=1;
if (SMQ020=2) then Smoke=0; run;

*save permanent file;
libname loc
"C:\Users\PWS5\OneDrive - University of Pittsburgh\Desktop\SleepHUB\BaniakLuyster\";
data loc.workfile;
set work.ReadyToAnalyze;
run;

data ReadyToAnalyze;
set ReadyToAnalyze;
if SLQ060=2 then SLQ060=0;
if SLQ060>2 then SLQ060=.;
run;

data ReadyToAnalyze;
 set ReadyToAnalyze;
 SBP=input(BPXSY1,8.);run;

 proc sort data=readytoanalyze nodupkey;
 by SEQN; run;
PROC FORMAT;
    VALUE ethy
      1 = 'Mexican-American'
      2 = 'Other Hispanic'
	  3= 'Non-Hispanic White'
	  4= 'Non-Hispanic Black'
	  5= 'Other inc. Multi'
	  6= 'Non-Hispanic Asian';
    RUN;
 data ReadyToAnalyze;
set ReadyToAnalyze;
NewEth=RIDRETH1;
if RIDRETH3=6 then NewEth=6;
format NewEth ethy.;
run;

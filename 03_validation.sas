/*=========================================================
  PROGRAM: 03_validation.sas
  PURPOSE: Validation and QC checks
=========================================================*/

/*---------------------------------------------------------
1. Dataset structure checks
---------------------------------------------------------*/
title "AE Clean - Structure";
proc contents data=ae_clean varnum;
run;

title "DM Clean - Structure";
proc contents data=dm_clean varnum;
run;

title "DS Clean - Structure";
proc contents data=ds_clean varnum;
run;

title "LB Clean - Structure";
proc contents data=lb_clean varnum;
run;

title "VS Clean - Structure";
proc contents data=vs_clean varnum;
run;

/*---------------------------------------------------------
2. Observation counts
---------------------------------------------------------*/
proc sql;
    create table qc_counts as
    select "AE" as dataset length=3, count(*) as nobs from ae_clean
    union all
    select "DM" as dataset, count(*) from dm_clean
    union all
    select "DS" as dataset, count(*) from ds_clean
    union all
    select "LB" as dataset, count(*) from lb_clean
    union all
    select "VS" as dataset, count(*) from vs_clean
    ;
quit;

title "Record Counts";
proc print data=qc_counts noobs;
run;

/*---------------------------------------------------------
3. Duplicate checks
---------------------------------------------------------*/

/* DM should be one record per subject */
proc sort data=dm_clean nodupkey out=dm_unique dupout=dm_dups;
    by usubjid;
run;

title "Duplicate Subjects in DM";
proc print data=dm_dups noobs;
run;

/* AE can have multiple records per subject, but AESEQ should be unique within subject */
proc sort data=ae_clean nodupkey out=ae_unique dupout=ae_dups;
    by usubjid aeseq;
run;

title "Duplicate AE Records by USUBJID + AESEQ";
proc print data=ae_dups noobs;
run;

/* DS can have multiple records per subject, so check composite key */
proc sort data=ds_clean nodupkey out=ds_unique dupout=ds_dups;
    by usubjid dsseq;
run;

title "Duplicate DS Records by USUBJID + DSSEQ";
proc print data=ds_dups noobs;
run;

/* LB and VS composite key checks */
proc sort data=lb_clean nodupkey out=lb_unique dupout=lb_dups;
    by usubjid lbseq;
run;

proc sort data=vs_clean nodupkey out=vs_unique dupout=vs_dups;
    by usubjid vsseq;
run;

/*---------------------------------------------------------
4. Missing value checks for key variables
---------------------------------------------------------*/
title "Missing Key Variables - DM";
proc freq data=dm_clean;
    tables usubjid sex age arm / missing;
run;

title "Missing Key Variables - AE";
proc freq data=ae_clean;
    tables usubjid aesev aerel / missing;
run;

/*---------------------------------------------------------
5. Demographic checks
---------------------------------------------------------*/
title "Demographic Distribution";
proc freq data=dm_clean;
    tables sex armcd arm / missing;
run;

/* Age range check */
data dm_age_issues;
    set dm_clean;
    if age < 18 or age > 120 then output;
run;

title "Age Range Issues";
proc print data=dm_age_issues noobs;
run;

/*---------------------------------------------------------
6. AE checks
---------------------------------------------------------*/
title "AE Severity Summary";
proc freq data=ae_clean;
    tables aesev / missing;
run;

title "AE Relationship Summary";
proc freq data=ae_clean;
    tables aerel / missing;
run;

/* AE date logic check */
data ae_date_issues;
    set ae_clean;
    if not missing(aestdtc) and not missing(aeendtc) then do;
        if aeendtc < input(aestdtc, yymmdd10.) then output;
    end;
run;

title "AE Date Logic Issues";
proc print data=ae_date_issues noobs;
run;

/*---------------------------------------------------------
7. Lab checks
---------------------------------------------------------*/

/* Use meaningful numeric lab values only */
title "Laboratory Summary Statistics";
proc means data=lb_clean n nmiss min mean median max;
    var lbstresn lbornrlo lbornrhi;
run;

/* Flag impossible or suspicious lab values */
data lb_issues;
    set lb_clean;
    if not missing(lbstresn) and lbstresn < 0 then output;
run;

title "Laboratory Issues";
proc print data=lb_issues noobs;
run;

/*---------------------------------------------------------
8. Vital signs checks
---------------------------------------------------------*/

/* Use meaningful numeric vital sign values only */
title "Vital Signs Summary Statistics";
proc means data=vs_clean n nmiss min mean median max;
    var vsstresn vsorres;
run;

/* Flag suspicious vital sign values */
data vs_issues;
    set vs_clean;
    if not missing(vsstresn) and vsstresn <= 0 then output;
run;

title "Vital Signs Issues";
proc print data=vs_issues noobs;
run;

title;

/*---------------------------------------------------------
9. Subject Reconciliation
---------------------------------------------------------*/

proc sql;

title "Unique Subject Counts";

select count(distinct usubjid) as DM_Subjects
from dm_clean;

select count(distinct usubjid) as AE_Subjects
from ae_clean;

select count(distinct usubjid) as DS_Subjects
from ds_clean;

select count(distinct usubjid) as LB_Subjects
from lb_clean;

select count(distinct usubjid) as VS_Subjects
from vs_clean;

quit;
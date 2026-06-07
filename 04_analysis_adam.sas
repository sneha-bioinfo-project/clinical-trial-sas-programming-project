/*=========================================================
  PROGRAM: 04_analysis_adam.sas
  PURPOSE: Create Analysis Dataset (ADaM-style ADSL)
=========================================================*/

/*---------------------------------------------------------
1. Sort source datasets
---------------------------------------------------------*/
proc sort data=dm_clean out=dm_srt;
    by usubjid;
run;

proc sort data=ds_clean out=ds_srt;
    by usubjid dsseq;
run;

/*---------------------------------------------------------
2. Keep the final DS record per subject
   Sorting by DSSEQ and taking LAST.USUBJID gives one
   disposition record per subject for subject-level analysis.
---------------------------------------------------------*/
data ds_one;
    set ds_srt;
    by usubjid;
    if last.usubjid;
run;

/*---------------------------------------------------------
3. Create subject-level analysis dataset (ADSL)
---------------------------------------------------------*/
data adsl;
    merge dm_srt(in=a drop=domain)
          ds_one(in=b drop=domain);
    by usubjid;

    if a;

    length domain $4 agegr1 $10 saffl $1 ittfl $1;

    /* Standard ADaM-style domain */
    domain = "ADSL";

    /* Age group */
    if not missing(age) then do;
        if age < 65 then agegr1 = "<65";
        else agegr1 = ">=65";
    end;
    else agegr1 = "";

    /* Safety population flag */
    if upcase(strip(arm)) = "SCREEN FAILURE" then saffl = "N";
    else saffl = "Y";

    /* Intent-to-treat style flag */
    if upcase(strip(arm)) = "SCREEN FAILURE" then ittfl = "N";
    else ittfl = "Y";
run;

/*---------------------------------------------------------
4. Verify dataset
---------------------------------------------------------*/
title "ADSL Structure";
proc contents data=adsl varnum;
run;

title "ADSL Sample";
proc print data=adsl(obs=20);
    var usubjid sex age agegr1 arm actarm saffl ittfl domain;
run;

/*---------------------------------------------------------
5. Population summary
---------------------------------------------------------*/
title "ADSL Population Summary";

proc freq data=adsl;
    tables sex agegr1 arm actarm saffl ittfl / missing;
run;

/*---------------------------------------------------------
6. QC checks
---------------------------------------------------------*/

/* One record per subject */
proc sql;
    select count(*) as total_records,
           count(distinct usubjid) as unique_subjects
    from adsl;
quit;

/* Check for duplicates if any */
proc sort data=adsl nodupkey out=adsl_nodup dupout=adsl_dups;
    by usubjid;
run;

title "Duplicate Subjects in ADSL";
proc print data=adsl_dups noobs;
run;

title;
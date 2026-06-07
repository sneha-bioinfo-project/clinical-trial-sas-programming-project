/*=========================================================
  PROGRAM: 02_clean.sas
  PURPOSE: Create cleaned datasets from raw clinical data
=========================================================*/

/*---------------------------------------------------------
  AE CLEANING
---------------------------------------------------------*/
data ae_clean;
    set ae;

    /* Standardize character variables */
    AETERM   = strip(AETERM);
    AEDECOD  = strip(AEDECOD);
    AESEV    = upcase(strip(AESEV));
    AEREL    = upcase(strip(AEREL));
    AESER    = upcase(strip(AESER));
    AEACN    = upcase(strip(AEACN));

    /* QC Checks */
    if missing(USUBJID) then
        put "WARNING: Missing USUBJID in AE record " _N_=;

    if missing(AESEV) then
        put "WARNING: Missing AESEV for USUBJID=" USUBJID;

    if AESEV not in ("MILD","MODERATE","SEVERE")
       and not missing(AESEV) then
        put "WARNING: Unexpected AESEV value: "
            AESEV= USUBJID=;

run;


/*---------------------------------------------------------
  DM CLEANING
---------------------------------------------------------*/
data dm_clean;
    set dm;

    SEX     = upcase(strip(SEX));
    RACE    = strip(RACE);
    ETHNIC  = strip(ETHNIC);
    ARM     = strip(ARM);
    ACTARM  = strip(ACTARM);

    /* QC Checks */
    if AGE < 0 or AGE > 120 then
        put "WARNING: Suspicious AGE=" AGE " USUBJID=" USUBJID;

    if SEX not in ("M","F")
       and not missing(SEX) then
        put "WARNING: Unexpected SEX=" SEX= USUBJID=;

run;


/*---------------------------------------------------------
  DS CLEANING
---------------------------------------------------------*/
data ds_clean;
    set ds;

    DSTERM  = strip(DSTERM);
    DSDECOD = strip(DSDECOD);
    DSCAT   = strip(DSCAT);
    VISIT   = strip(VISIT);

run;


/*---------------------------------------------------------
  LB CLEANING
---------------------------------------------------------*/
data lb_clean;
    set lb;

    LBTESTCD = upcase(strip(LBTESTCD));
    LBTEST   = strip(LBTEST);
    LBCAT    = strip(LBCAT);
    LBORRESU = upcase(strip(LBORRESU));
    LBSTRESU = upcase(strip(LBSTRESU));
    LBNRIND  = upcase(strip(LBNRIND));

run;


/*---------------------------------------------------------
  VS CLEANING
---------------------------------------------------------*/
data vs_clean;
    set vs;

    VSTESTCD = upcase(strip(VSTESTCD));
    VSTEST   = strip(VSTEST);
    VSPOS    = strip(VSPOS);
    VSORRESU = strip(VSORRESU);
    VSSTRESU = strip(VSSTRESU);
    VSSTAT   = strip(VSSTAT);
    VSLOC    = strip(VSLOC);
    VSTPT    = strip(VSTPT);
    VSELTM   = strip(VSELTM);
    VSTPTREF = strip(VSTPTREF);

run;


/*---------------------------------------------------------
  DUPLICATE SUBJECT QC CHECK
---------------------------------------------------------*/
proc sort data=dm_clean
          nodupkey
          dupout=dm_duplicates;
    by USUBJID;
run;

title "Duplicate Subject Check - DM";

proc sql;
    select count(*) as Duplicate_Subjects
    from dm_duplicates;
quit;


/*---------------------------------------------------------
  MISSING AEREL QC CHECK
---------------------------------------------------------*/
title "Missing AEREL Check";

proc freq data=ae_clean;
    tables AEREL / missing;
run;

title;
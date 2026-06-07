/*=========================================================
  PROGRAM: 05_reports.sas
  PURPOSE: Generate Clinical Study Reports
=========================================================*/

ods pdf file="/home/u64531897/clinical_study_reports.pdf" style=journal;

/*---------------------------------------------------------
  Subject-Level Demographics / Table 1
---------------------------------------------------------*/
title "Table 1. Demographic Summary";

proc freq data=adsl;
    tables arm*sex / missing norow nocol nopercent;
run;

title "Age Summary by Treatment Arm";
proc means data=adsl n mean std min max;
    class arm;
    var age;
run;

title "Age Group by Treatment Arm";
proc freq data=adsl;
    tables arm*agegr1 / missing norow nocol nopercent;
run;

/*---------------------------------------------------------
  Safety Population / Analysis Flags
---------------------------------------------------------*/
title "Safety Population";
proc freq data=adsl;
    tables saffl / missing;
run;

title "Intent-to-Treat Population";
proc freq data=adsl;
    tables ittfl / missing;
run;

/*---------------------------------------------------------
  Subject Listing
---------------------------------------------------------*/
title "Subject Listing";

proc print data=adsl(obs=25);
    var usubjid sex age agegr1 arm actarm saffl ittfl domain;
run;

/*---------------------------------------------------------
  Subject Count Check
---------------------------------------------------------*/
title "Subject Count Check";

proc sql;
    select count(*) as Total_Records,
           count(distinct usubjid) as Unique_Subjects
    from adsl;
quit;

/*---------------------------------------------------------
  Adverse Event Summary
  Create ADAE-style analysis data on the fly
---------------------------------------------------------*/
proc sort data=ae_clean out=ae_srt;
    by usubjid;
run;

proc sort data=adsl(keep=usubjid arm sex age) out=adsl_key;
    by usubjid;
run;

data adae;
    merge ae_srt(in=a)
          adsl_key(in=b);
    by usubjid;
    if a;
run;

title "Adverse Event Severity Summary";
proc freq data=adae;
    tables aesev / missing;
run;

title "Adverse Event Severity by Treatment Arm";
proc freq data=adae;
    tables arm*aesev / missing norow nocol nopercent;
run;

title "Adverse Event Relationship by Treatment Arm";
proc freq data=adae;
    tables arm*aerel / missing norow nocol nopercent;
run;

/*---------------------------------------------------------
  Laboratory Summary
---------------------------------------------------------*/
title "Laboratory Summary Statistics";

proc means data=lb_clean n nmiss min mean median max;
    var lbstresn lbornrlo lbornrhi;
run;

title "ALT / AST Summary";
proc means data=lb_clean n mean std min max;
    class lbtestcd;
    where lbtestcd in ("ALT","AST");
    var lbstresn;
run;

/*---------------------------------------------------------
  Vital Signs Summary
---------------------------------------------------------*/
title "Vital Signs Summary Statistics";

proc means data=vs_clean n nmiss min mean median max;
    var vsstresn vsorres;
run;

title "Vital Sign Test Summary";
proc means data=vs_clean n mean std min max;
    class vstestcd;
    var vsstresn;
run;

ods pdf close;
title;
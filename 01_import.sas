/*=========================================================
  PROGRAM: 01_import.sas
  PURPOSE: Import raw clinical CSV files into SAS datasets
=========================================================*/

options mprint mlogic symbolgen;
ods listing;

/* Create a raw data library if you want to store imported datasets permanently */
libname raw "/home/u64531897";

/* Import raw CSV files */

proc import datafile="/home/u64531897/AE.csv"
    out=raw.ae
    dbms=csv
    replace;
    guessingrows=max;
    getnames=yes;
run;

proc import datafile="/home/u64531897/DM.csv"
    out=raw.dm
    dbms=csv
    replace;
    guessingrows=max;
    getnames=yes;
run;

proc import datafile="/home/u64531897/DS.csv"
    out=raw.ds
    dbms=csv
    replace;
    guessingrows=max;
    getnames=yes;
run;

proc import datafile="/home/u64531897/LB.csv"
    out=raw.lb
    dbms=csv
    replace;
    guessingrows=max;
    getnames=yes;
run;

proc import datafile="/home/u64531897/VS.csv"
    out=raw.vs
    dbms=csv
    replace;
    guessingrows=max;
    getnames=yes;
run;

/* Verify imports */

title "AE - Metadata and Row Check";
proc contents data=raw.ae varnum;
run;
proc sql;
    select count(*) as AE_Records from raw.ae;
quit;

title "DM - Metadata and Row Check";
proc contents data=raw.dm varnum;
run;
proc sql;
    select count(*) as DM_Records from raw.dm;
quit;

title "DS - Metadata and Row Check";
proc contents data=raw.ds varnum;
run;
proc sql;
    select count(*) as DS_Records from raw.ds;
quit;

title "LB - Metadata and Row Check";
proc contents data=raw.lb varnum;
run;
proc sql;
    select count(*) as LB_Records from raw.lb;
quit;

title "VS - Metadata and Row Check";
proc contents data=raw.vs varnum;
run;
proc sql;
    select count(*) as VS_Records from raw.vs;
quit;

title;
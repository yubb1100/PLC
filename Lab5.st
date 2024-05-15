// Author: Riley Olfert
// Date Created: 2024-05-01
// File Name: Lab5
// Description: Motor Control Program for Siemens S7-1200 PLC
"level" := 0.00351 * "Pot0";
"level_disp" := 0.00351 * INT_TO_REAL("Pot0");
"P1" := 0.00351 * "Pot1";

"pump1_last" := "pump1";
"pump2_last" := "pump2";
"level_last" := "level";
"primsec_last" := "primsec";

IF "level" < 70 AND "level" > 50 AND ("pump1" > 0 OR "pump2" > 0) AND "flag" = 0 THEN
    "flag" := 1;
END_IF;

IF "flag" = 1 AND ("pump1" = 0 OR "pump2" = 0) THEN
    "flag" := 0;
    "primsec" := NOT "primsec";
END_IF;

IF "level" <= 30 AND "primsec" THEN
    "pump1" := 100;
    "p1_disp" := 100;
ELSIF "level" > 30 AND "level" <= 50  AND "primsec" THEN
    "pump1" := 160 - 2 * "level";
    "p1_disp" := 160 - 2 * "level_disp";
ELSIF (NOT ("pump1_last" = 0)) AND "level" > 50 AND "level" < 70  AND "primsec" THEN
    "pump1" := 160 - 2 * "level";
    "p1_disp" := 160 - 2 * "level_disp";
   // "primsec" := 0;
ELSIF (NOT ("pump1_last" = 0)) AND "level" >= 70 AND "level" <= 80  AND "primsec" THEN
    "pump1" := 20;
    "p1_disp" := 20;
ELSIF "level" > 80  AND "primsec" THEN
    "pump1" := 0;
    "p1_disp" := 0;
    
ELSIF "level" <= 30 AND NOT "primsec" THEN
    "pump1" := 100;
    "p1_disp" := 100;
ELSIF (NOT ("pump1_last" = 0)) AND "level" > 30 AND "level" < 70 AND NOT "primsec" THEN
    "pump1" := 160 - 2 * "level";
    "p1_disp" := 160 - 2 * "level_disp";
ELSIF (NOT ("pump1_last" = 0)) AND "level" >= 70 AND "level" <= 80 AND NOT "primsec" THEN
    "pump1" := 20;
    "p1_disp" := 20;
ELSIF "level" > 80 AND NOT "primsec" THEN
    "pump1" := 0;
    "p1_disp" := 0;

ELSE
    "pump1" := "pump1";
    "p1_disp" := "p1_disp";
END_IF;

IF "level" <= 30 AND "primsec" THEN
    "pump2" := 100;
    "p2_disp" := 100;
ELSIF (NOT ("pump2_last" = 0)) AND "level" > 30 AND "level" < 70 AND "primsec" THEN
    "pump2" := 160 - 2 * "level";
    "p2_disp" := 160 - 2 * "level_disp";
ELSIF (NOT ("pump2_last" = 0)) AND "level" >= 70 AND "level" <= 80 AND "primsec" THEN
    "pump2" := 20;
    "p2_disp" := 20;
ELSIF "level" > 80 AND "primsec" THEN
    "pump2" := 0;
    "p2_disp" := 0;
    
ELSIF "level" <= 30 AND NOT "primsec" THEN
    "pump2" := 100;
    "p2_disp" := 100;
ELSIF "level" > 30 AND "level" <= 50  AND NOT "primsec" THEN
    "pump2" := 160 - 2 * "level";
    "p2_disp" := 160 - 2 * "level_disp";
ELSIF (NOT ("pump2_last" = 0)) AND "level" > 50 AND "level" < 70  AND NOT "primsec" THEN
    "pump2" := 160 - 2 * "level";
    "p2_disp" := 160 - 2 * "level_disp";
    //"primsec" := 1;
    
ELSIF (NOT ("pump2_last" = 0)) AND "level" >= 70 AND "level" <= 80  AND NOT "primsec" THEN
    "pump2" := 20;
    "p2_disp" := 20;
ELSIF "level" > 80 AND NOT "primsec" THEN
    "pump2" := 0;
    "p2_disp" := 0;
    
ELSE
    "pump2" := "pump2";
    "p2_disp" := "p2_disp";
END_IF;

IF "p1_count" >= 5 THEN
    "red" := 1;
ELSE
    "red" := 0;
END_IF;

IF "p2_count" >= 5 THEN
    "org" := 1;
ELSE
    "org" := 0;
END_IF;

IF "p" THEN
    "p1_count" := 0;
ELSIF (NOT ("pump1" = 0)) AND "pump1_last" = 0 THEN
    "p1_count" := "p1_count" + 1;
ELSE
    "p1_count" := "p1_count";
END_IF;

IF "s" THEN
    "p2_count" := 0;
ELSIF (NOT ("pump2" = 0)) AND "pump2_last" = 0 THEN
    "p2_count" := "p2_count" + 1;
ELSE
    "p2_count" := "p2_count";
END_IF;




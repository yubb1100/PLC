// Author: Riley Olfert
// Date Created: 2024-05-01
// File Name: Lab4.ST
// Description: Motor Control Program for Siemens S7-1200 PLC
"P0" := 0.3535 * "Pot0" + 100;

"ZEROSEC" := T#0S;
"timing" := INT_TO_TIME("P0");
"ONESEC" := T#1S;
"HMS" := T#100mS;

"Timer".TON(IN:=TRUE,
            PT:="timing",
            Q=>"toggle",
            ET=>"ZEROSEC");

// Detecting rising edge of pushbutton
"risingEdge" := ("HS_1"AND NOT"HS_1_last");

// Update lastButtonState for next cycle
"HS_1_last" := "HS_1";

IF "toggle" THEN
    "togglevar" := NOT "togglevar";
    "Timer".TON(IN := FALSE, PT:="ONESEC");
END_IF;

IF "risingEdge" THEN
    "dir" := NOT "dir";
END_IF;

IF "reset" THEN
    "dir" := TRUE;
    "togglevar" := FALSE;
    "circle0" := TRUE;
    "circle1" := TRUE;
    "circle2" := TRUE;
    "circle3" := TRUE;
    "circle4" := FALSE;
    "circle5" := TRUE;
    "circle6" := TRUE;
    "circle7" := TRUE;
    "circle8" := FALSE;
    "circle9" := TRUE;
    "circle10" := TRUE;
    "circle11" := FALSE;
    "circle12" := TRUE;
    "circle13" := FALSE;
    "circle14" := FALSE;
    "circle15" := FALSE;
    ELSIF "toggle" AND "dir" THEN
        "temp" := "circle15";
        "circle15" := "circle14";
        "circle14" := "circle13";
        "circle13" := "circle12";
        "circle12" := "circle11";
        "circle11" := "circle10";
        "circle10" := "circle9";
        "circle9" := "circle8";
        "circle8" := "circle7";
        "circle7" := "circle6";
        "circle6" := "circle5";
        "circle5" := "circle4";
        "circle4" := "circle3";
        "circle3" := "circle2";
        "circle2" := "circle1";
        "circle1" := "circle0";
        "circle0" := "temp";
    ELSIF "toggle" AND (NOT "dir") THEN
        "temp" := "circle0";
        "circle0" := "circle1";
        "circle1" := "circle2";
        "circle2" := "circle3";
        "circle3" := "circle4";
        "circle4" := "circle5";
        "circle5" := "circle6";
        "circle6" := "circle7";
        "circle7" := "circle8";
        "circle8" := "circle9";
        "circle9" := "circle10";
        "circle10" := "circle11";
        "circle11" := "circle12";
        "circle12" := "circle13";
        "circle13" := "circle14";
        "circle14" := "circle15";
        "circle15" := "temp";
    ELSE
        "circle15" := "circle15";
        "circle14" := "circle14";
        "circle13" := "circle13";
        "circle12" := "circle12";
        "circle11" := "circle11";
        "circle10" := "circle10";
        "circle9" := "circle9";
        "circle8" := "circle8";
        "circle7" := "circle7";
        "circle6" := "circle6";
        "circle5" := "circle5";
        "circle4" := "circle4";
        "circle3" := "circle3";
        "circle2" := "circle2";
        "circle1" := "circle1";
        "circle0" := "circle0";
    END_IF;

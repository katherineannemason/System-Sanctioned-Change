* Manylabs SJ analyses;

************* Condition X Country X Ideology Interaction Omnibus Effects *************


* Import files;

* Data set to do sharing and action analyses; 

libname df xlsx "/home/u63541235/sasuser.v94/ManyLabs/Syst_Sanct_17_Data.xlsx";

* Make sure data sets accessible in the working library;

data df; set df.df; run;

* Sort by ID;
proc sort data=df; by responseid; run;

* Make sure SAS recognizes that ideology is numeric;

data df; 
  set df; 

  ide_c = input(ide_c, best32.); 
  age_c = input(age_c, best32.); 
  edu_c = input(edu_c, best32.); 
  income_c = input(income_c, best32.); 
  
* All effects coded variables also need to be recognized as numeric;

  cond_effects = input(cond_effects, best32.); 
  gend_effects = input(gend_effects, best32.); 
run;

* Check that vars are correct;

proc means data=df mean median std;
   var ide_c age_c income_c edu_c;
run;

proc freq data=df; 
   tables cond_effects gend_effects Country SHAREcc
   / nocol norow nopercent; 
run;


*** SHARING MODEL ***

* Without covariates;
proc logistic data=df;
   class Country (ref = "USA") ;
   model SHAREcc(event='1') = cond_effects Country ide_c 
   cond_effects*Country  
   cond_effects*ide_c
   Country*ide_c
   cond_effects*Country*ide_c
   / expb;
run;

* With covariates;
proc logistic data=df;
   class Country (ref = "USA") ;
   model SHAREcc(event='1') = cond_effects Country ide_c gend_effects age_c edu_c income_c
   cond_effects*Country  
   cond_effects*ide_c
   Country*ide_c
   cond_effects*Country*ide_c
   / expb;
run;

*** ACTION MODEL ***

* Without covariates;
proc logistic data=df ;
   class Country (ref = "USA") ;
   model WEPTcc = cond_effects Country ide_c
   cond_effects*Country  
   cond_effects*ide_c
   Country*ide_c
   cond_effects*Country*ide_c / link=glogit;
run;

* With covariates ;

proc logistic data=df;
   class Country (ref = "USA") ;
   model WEPTcc = cond_effects Country ide_c gend_effects age_c edu_c income_c
   cond_effects*Country  
   cond_effects*ide_c
   Country*ide_c
   cond_effects*Country*ide_c / link=glogit;
run;










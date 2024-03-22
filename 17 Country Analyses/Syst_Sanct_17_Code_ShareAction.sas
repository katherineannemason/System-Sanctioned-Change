* Manylabs SJ analyses;

************* Condition X Country X Ideology Interaction Omnibus Effects *************


* Import files;

* Data set to do sharing and action analyses; 

libname df xlsx "/home/u63541235/sasuser.v94/ManyLabs/Syst_Sanct_17_Data.xlsx";

* Look at the data set;
 
proc print data = df.df;
run;

* Make sure data sets accessible in the working library;

data df; set df.df; run;

* Sort by ID;
proc sort data=df; by responseid; run;

* Make sure SAS recognizes that ideology is numeric;

data df; 
  set df; 

  ide_c = input(ide_c, best32.); 
  Age = input(Age, best32.); 
  Edu = input(Edu, best32.); 
  Income = input(Income, best32.); 
  
* All effects coded variables also need to be recognized as numeric;

  cond_effects = input(cond_effects, best32.); 
  gend_effects = input(gend_effects, best32.); 
run;


*** SHARING MODEL ***

* Without covariates;
proc logistic data=df;
   class cond_effects Country ;
   model SHAREcc= cond_effects Country ide_c 
   cond_effects*Country  
   cond_effects*ide_c
   Country*ide_c
   cond_effects*Country*ide_c
   / expb;
run;


* With covariates;
proc logistic data=df;
   class cond_effects Country ;
   model SHAREcc= cond_effects Country ide_c gend_effects age_c edu_c income_c
   cond_effects*Country  
   cond_effects*ide_c
   Country*ide_c
   cond_effects*Country*ide_c
   / expb;
run;

*** ACTION MODEL ***

* Without covariates;
proc logistic data=df descending;
   class cond_effects Country ;
   model WEPTcc = cond_effects Country ide_c
   cond_effects*Country  
   cond_effects*ide_c
   Country*ide_c
   cond_effects*Country*ide_c / link=glogit;
run;

* With covariates ;

proc logistic data=df descending;
   class cond_effects Country ;
   model WEPTcc = cond_effects Country ide_c gend_effects age_c edu_c income_c
   cond_effects*Country  
   cond_effects*ide_c
   Country*ide_c
   cond_effects*Country*ide_c / link=glogit;
run;








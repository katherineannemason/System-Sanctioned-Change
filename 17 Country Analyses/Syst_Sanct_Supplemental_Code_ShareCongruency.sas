************ CONGRUENCY ANALYSES SHARING AND ACTION ************

* Import file;

* Congruency data set;

libname cong_df xlsx "/home/u63541235/sasuser.v94/ManyLabs/Congruency.xlsx";

* Make sure data sets accessible in the working library;

data cong_df; set cong_df.df; run;

* Sort by ID;
proc sort data=cong_df; by responseid; run;

* Make sure SAS recognizes that ideology is numeric;

data cong_df; 
  set cong_df; 

  ide_c = input(ide_c, best32.); 
  age_c = input(age_c, best32.); 
  edu_c = input(edu_c, best32.); 
  income_c = input(income_c, best32.); 
  
* All effects coded variables also need to be recognized as numeric;
  cond_effects = input(cond_effects, best32.); 
  gend_effects = input(gend_effects, best32.); 
run;

*** SHARING MODEL ***

* Without covariates;
proc logistic data=cong_df;
   class cond_effects Country Congruence;
   model SHAREcc = 
   cond_effects Country ide_c Congruence
   cond_effects*ide_c  
   cond_effects*Congruence                     
   ide_c*Congruence                        
   cond_effects*Country                        
   ide_c*Country                           
   Congruence*Country                       
   cond_effects*ide_c*Congruence            
   cond_effects*ide_c*Country                  
   cond_effects*Congruence*Country           
   ide_c*Congruence*Country                   
   cond_effects*ide_c*Congruence*Country
   / expb;
run;

* With covariates;
proc logistic data=cong_df;
   class cond_effects Country Congruence;
   model SHAREcc = 
   cond_effects Country ide_c Congruence gend_effects age_c edu_c income_c
   cond_effects*ide_c  
   cond_effects*Congruence                     
   ide_c*Congruence                        
   cond_effects*Country                        
   ide_c*Country                           
   Congruence*Country                       
   cond_effects*ide_c*Congruence            
   cond_effects*ide_c*Country                  
   cond_effects*Congruence*Country           
   ide_c*Congruence*Country                   
   cond_effects*ide_c*Congruence*Country
   / expb;
run;


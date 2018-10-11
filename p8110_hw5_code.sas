
* Nick Williams
* P8110 Homework 5
* Columbia University 
* Department of Biostatistics; 

* importing data; 

data hw5; 
	infile "C:\Users\niwi8\OneDrive\Documents\fall_2018\regression\homework\p8110_hw5\HW5data.csv"
		delimiter= ',' missover dsd; 
	input id len_follow final_stat mi_ord bmi year age_c; 
run; 

* cox model 1; 

proc phreg data = hw5; 
	class mi_ord (ref = "0") / param = ref; 
	model len_follow * final_stat(0) = mi_ord / risklimits covb ties = efron; 
	title "Cox model, length of follow-up as a function of MI order"; 
run; 

* cox model 2; 

proc phreg data = hw5; 
	class mi_ord (ref = "0")
		  age_c (ref = "1")
		  year (ref = "1") / param = ref; 
	model len_follow * final_stat(0) = mi_ord age_c bmi year / risklimits covb ties = efron; 
	title "Cox model, length of follow-up as a function of MI order, age category, bmi, and cohort year"; 
run; 

* cox model 3; 

proc phreg data = hw5; 
	class mi_ord (ref = "0")
		  age_c (ref = "1")
		  year (ref = "1") / param = ref; 
	model len_follow * final_stat(0) = mi_ord age_c bmi year mi_ord * age_c / risklimits covb ties = efron; 
	hazardratio mi_ord / at (age_c = "2") diff = ref; 
	baseline out = model_3 survival = surv lower = lcl upper = ucl; 
	title "Cox model, length of follow-up as a function of MI order, age category, bmi, cohort year, interaction between 
		   MI order and age category"; 
run;

* survival prediction; 

data surv_pred; 
	input id mi_ord age_c bmi year; 
	cards; 
	1 1 4 30 3
	; 
run; 

proc phreg data = hw5 plots(cl) = survival; 
	class mi_ord (ref = "0")
		  age_c (ref = "1")
		  year (ref = "1") / param = ref; 
	model len_follow * final_stat(0) = mi_ord age_c bmi year mi_ord * age_c / risklimits covb ties = efron; 
	baseline covariates = surv_pred out = pred survival = _all_ / rowid = id; 
run; 

proc print data = pred; 
run; 

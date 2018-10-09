
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


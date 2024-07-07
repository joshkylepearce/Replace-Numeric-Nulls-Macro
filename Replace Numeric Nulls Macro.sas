/************************************************************************************
***** Program: 	Replace Numeric Nulls Macro *****
***** Author:	joshkylepearce      		*****
************************************************************************************/

/************************************************************************************
Purpose:
Replace null values of numeric values with a user-inputted value.

Input Parameters:
1. input_data	- The name of the input dataset.
2. value		- The value that replaces null values of numeric variables.

Macro Usage:
1.	Run the replace_nulls_numeric macro code.
2.	Call the replace_nulls_numeric macro and enter the input parameters.
	e.g. %replace_nulls_numeric(input_data=work.library,value=0);

Note:
1. Input parameter 'value' is compatible with/without quotations.
************************************************************************************/

/*Create a macro to replace all null values of numeric variables with zero*/
%macro replace_nulls_numeric(input_data,value);

data &input_data._RNN;
set &input_data.;
array variablesOfInterest _numeric_;
do over variablesOfInterest;
	if variablesOfInterest =. then variablesOfInterest=&value.;
end;
run;

%mend;

/************************************************************************************
Example 1 & 2: Data Setup
************************************************************************************/

/*Data preparation for usage of the replace numeric nulls array*/
data dollars_spent_today;
infile datalines delimiter=",";
input Name $ Sex $ dollars_spent_today;
datalines;
Rachael, F, 66
Scott, M ,120
Jarrod, M, 100
Tamara, F, 88
Henry, M, ,.
Michael, M ,79
Betty, M ,F ,.
run;

/*Add additional variable to dataset*/
data dollars_spent_yday;
set dollars_spent_today;
dollars_spent_yday=.;
run;

/************************************************************************************
Example 1: Macro Usage Without Quotations
************************************************************************************/

/*Call the replace null numeric macro*/
%replace_nulls_numeric(dollars_spent_today,0);

/************************************************************************************
Example 2: Macro Usage With Quotations
************************************************************************************/

/*Call the replace null numeric macro*/
%replace_nulls_numeric(dollars_spent_yday,"0");
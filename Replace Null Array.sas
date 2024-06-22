/**********************************************************************
***** Program: 	Replace Nulls Array *******************
***** Author:	joshkylepearce      *******************
**********************************************************************/

/*Create a macro to replace all null values of numeric variables with zero*/
%macro replace_nulls(input_data);

data &input_data._RNA;
set &input_data.;
array variablesOfInterest _numeric_;
do over variablesOfInterest;
	if variablesOfInterest =. then variablesOfInterest=0;
end;
run;

%mend;

/**********************************************************************
Examples
**********************************************************************/

/**********************************************************************
Example 1: Daily Spend 
**********************************************************************/

/*Create dataset in preparation for usage of the replace nulls array*/
data dollars_spent_today;
input Name $ Sex $ dollars_spent_today;
datalines;
Rachael F 66
Scott M 120
Jarrod M 100
Tamara F 88
Henry M .
Michael M 79
Betty F .
run;

/*Add additional variable to dataset*/
data dollars_spent_yday;
set dollars_spent_today;
dollars_spent_yday=.;
run;

/*Call the replace null array macro function*/
%replace_nulls(dollars_spent_yday);

/**********************************************************************
2.1.2 Example 2: Item List 
**********************************************************************/

/*Create dataset 1 in preparation for usage of the replace nulls array*/
data item_list1;
do item_no = 1 to 20;
	quantity=rand("integer",0,3);
	output;
end;
run;

/*Create dataset 2 in preparation for usage of the replace nulls array*/
data item_list2;
do item_no = 21 to 25;
	quantity=.;
	output;
end;
run;

/*Append datasets in preparation for usage of the replace nulls array*/
proc sql;
create table item_list_appended as 
select * from item_list1
union all 
select * from item_list2
;
quit;

/*Call the replace null array macro function*/
%replace_nulls(item_list_appended);
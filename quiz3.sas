*Question 1a;
data new;
	input code disease count;
	datalines;
1 1 90
1 0 2
0 1 10
0 0 98
;
run;
proc freq data=new order=data;
	tables code*disease / out=lr outpct;
	weight count;
run;
proc freq data=new order=data;
	tables code*disease / nopct nocol out=lr outpct;
	weight count;
run;


*Question 1b;
data lr2;
	set lr end=final;
	retain sens spec;

	if code=1 and disease=1 then
		sens=pct_col/100;

	if code=0 and disease=0 then
		spec=pct_col/100;

	if final=1 then
		do;
			pospredvalue=(90/92)*100;
			lr_pos=sens/(1-spec);
			keep sens spec pospredvalue lr_pos;
			output;
		end;
run;



*Question 1c;
data final;
	set lr2;
	pretest_prob=0.00133;
	lr_pos=45;
	pretest_odds=pretest_prob/(1-pretest_prob);
	posttest_odds=lr_pos*pretest_odds;
	posttest_prob=posttest_odds/(posttest_odds+1);
	pappv=sens*pretest_prob/(sens*pretest_prob+(1-spec)*(1-pretest_prob));
run;
proc print;
run;


*Question 2;
data final1;
	*set lr2;
	pretest_prob=0.025;
	lr_pos=29.9;
	pretest_odds=pretest_prob/(1-pretest_prob);
	posttest_odds=lr_pos*pretest_odds;
	posttest_prob=posttest_odds/(posttest_odds+1);
	pappv=sens*pretest_prob/(sens*pretest_prob+(1-spec)*(1-pretest_prob));
run;
proc print;
run;


*Question 3;
data final2;
	*set lr2;
	pretest_prob=0.025;
	lr_pos=32;
	pretest_odds=pretest_prob/(1-pretest_prob);
	posttest_odds=lr_pos*pretest_odds;
	posttest_prob=posttest_odds/(posttest_odds+1);
	pappv=sens*pretest_prob/(sens*pretest_prob+(1-spec)*(1-pretest_prob));
run;
proc print;
run;


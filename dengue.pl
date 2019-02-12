:- use_module(library(pce)).
:- dynamic counter/1.

counter(0).

start:-
	new(D,dialog('welcome')),
	send(D,append,button(take_test, message(@prolog, tester))),
	send(D, open).

tester:-
	new(A,dialog('test for dengue')),
	send(A,append,new(Name, text_item(name))),
	send(A,append,new(Age, int_item(age))),
	send(A,append,new(Tempreture, int_item(tempreture))),
	send(A,append,new(Travel,menu('have you travels to any tropical areas recently',marked))),
	send(A,append,new(High_fever,menu(high_fever,marked))),
	send(A,append,new(Eye_pain,menu('pain behind the eyes',marked))),
	send(A,append,new(Joint,menu('joint and muscle pain',marked))),
	send(A,append,new(Fatigue,menu(fatigue))),
	send(A,append,new(Neasuea,menu(neasuea,marked))),
	send(A,append,new(Vomitting,menu(vomitting,marked))),
	send(A,append,new(Skin_rash,menu('skin rash',marked))),
	send(A,append,new(Bleeding,menu('mild bleeding',marked))),
	send(A,append,button(submit, message(@prolog, calaculate,
		Name?selection,
		Age?selection,
		Tempreture?selection,
		Travel?selection,
		High_fever?selection,
		Eye_pain?selection,
		Joint?selection,
		Fatigue?selection,
		Neasuea?selection,
		Vomitting?selection,
		Skin_rash?selection,
		Bleeding?selection
		))),

	send(Tempreture,type,int),
	send(Age,type,int),

	send(Travel 	 , append, yes), send(Travel, append, no), 
	send(High_fever  , append, yes), send(High_fever, append, no), 
	send(Eye_pain    , append, yes), send(Eye_pain, append, no), 
	send(Joint       , append, yes), send(Joint, append, no), 
	send(Fatigue     , append, yes), send(Fatigue, append, no), 
	send(Neasuea     , append, yes), send(Neasuea, append, no), 
	send(Vomitting   , append, yes), send(Vomitting, append, no), 
	send(Skin_rash   , append, yes), send(Skin_rash, append, no), 
	send(Bleeding    , append, yes), send(Bleeding, append, no), 
	send(A, open).


calaculate(Name,Age,Tempreture,Travel,High_fever,Eye_pain,Joint,Fatigue,Neasuea,Vomitting,Skin_rash,Bleeding):-
	new(B,dialog('Results')),
	send(B,append,new(L1,label)),
	send(B,append,new(L2,label)),
	send(B,append,new(L3,label)),
	send(B,append,new(L4,label)),
	Celsius is Tempreture - 32 *0.555,

	(Travel == 'yes' ->  T_val is 1; T_val is 0),
	(High_fever == 'yes' ->  HF_val is 1; HF_val is 0),
	(Eye_pain == 'yes' ->  EP_val is 1; EP_val is 0),
	(Joint == 'yes' ->  J_val is 1; J_val is 0),
	(Fatigue == 'yes' ->  F_val is 1; F_val is 0),
	(Neasuea == 'yes' ->  N_val is 1; N_val is 0),
	(Vomitting == 'yes' ->  V_val is 1; V_val is 0),
	(Skin_rash == 'yes' ->  SR_val is 1; SR_val is 0),
	(Bleeding == 'yes' ->  B_val is 1; B_val is 0),
	(Celsius > 38 -> C_val = 1; C_val =0),

	Percent is (T_val+HF_val+EP_val+J_val+F_val+N_val+V_val+SR_val+B_val+C_val) *10,
	(Travel == 'yes' -> send(L1,append, Celsius); send(L1,append,Percent)),

	send(B,append,button(save_file,message(@prolog,file_write,
		Name,Age,Tempreture,Travel,High_fever,Eye_pain,Joint,Fatigue,Neasuea,Vomitting,Skin_rash,Bleeding
	 ))),
	send(B, open).


file_write(Name,Age,Tempreture,Travel,High_fever,Eye_pain,Joint,Fatigue,Neasuea,Vomitting,Skin_rash,Bleeding):-
	open('database.txt',write,Out),
    nl(Out),               
    write(Out,' Name:'),	write(Out,Name),       
    write(Out,' Age:'),	write(Out,Age),
    write(Out, 'Tempreture'), write(Out,Tempreture),
    write(Out, 'Travel'), write(Out,Travel),
    write(Out, 'High_fever'), write(Out,High_fever),
    write(Out, 'Eye_pain'), write(Out,Eye_pain),
    write(Out, 'Joint'), write(Out,Joint),
    write(Out, 'Fatigue'), write(Out,Fatigue),
    write(Out, 'Neasuea'), write(Out,Neasuea),
    write(Out, 'Vomitting'), write(Out,Vomitting),
    write(Out, 'Skin_rash'), write(Out,Skin_rash),
    write(Out, 'Bleeding'), write(Out,Bleeding),

    close(Out),
    new(G,dialog('Database')),
    send(G,append,new(Lbl,label)),
    send(Lbl,append,'Your data has been successfully saved').
    


% howardjames908@hotmail.com
%should take tempreture
%high fever, headache
%pain behind eyes
%joint and muscle pain
%fatigue
%nausea
%vomiting
%skinrash two to five days of fever
%mild bleeding
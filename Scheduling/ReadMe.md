			Aman Aryan 	CSE C		 1651137
-----------------------------------------------------------------------------------------------------------------------


						Assignemnt 1 : Scheduling Problem
							Important Notes.

1:	Basic Idea:  
	Starting from the empty schedule 
	1-	Select a class and a room (class,room).
	2-	Checks
		a-	if class fits in the room.
		b-	check if the class fits in the room . 
			i- 	if the class is not already assigned.
			ii- 	if the room is not engaged in that ***time period***.	(temp/timeconflict.jpg)

	3-	if all condition satisy , add the (class , room) to the schedule.
	4- 	keep adding the (class , tuples)   till all classes  have been added.

2:      Finding Schedule gave too many same results in diffrent order ( temp/incorrectout.jpg ).

	So i used  findall ( X ,  fn( X ) , Result ) .
	This function saves all possible outputs using ; in Result .
	
	** So i saved all results in it and removed the duplicates.


------------------------Function Description  / Defintion / Description---------------------------------------------------



class(X)			:	All classes.
room(Y)				:	All rooms.
time(X,ST,ET)			:	Starting Time and Ending time of all classes.

fits(X,Y)			: 	X is a class and it can be held in Y list of rooms.

exist(X,Y)			:	whether a room is present in the list of rooms //Same function search() taught in class//

fitsin(C, R) 			:	Checks whether class C fits in room R , uses exist().

calctime([SH,SM], [EH,EM], R)	:	Calulates time diffrence between two times  ( Start and End )  and return in minutes(R).

checktime(S1, S2, E1, E2)	: 	Check if there the two time slots can exist together or not.
					If X class start before the Y ends or
					If Y class ends after the Y starts.

*	notimeconflict(C1, C2) 	: 	returns true if two class can be possible in same day . i.e. no conflict in time.



---------Checking in  already created schedule(list)  for conflicts

ifroompresent(	[C,R], List )	:   	checks whether any room R is empty for Class C . ( used notimeconflict()) .

ifclasspresent( C , List )	: 	checks if class C is already assigned in list.

*   checkroutine( [C,R], List )	: 	Checks if pair [C,R] is possible with respect to the list. 


lengthlist(N,L)			: 	Length of a list 				// Same function written in class//

insert(E , T, R)		:  	Inserting element E in T and saving in R	// Same function written in class//


*	schedule(X ,Y)		:	class(C), room(R), fitsin(C,R), checkroutine([C,R],X), insert([C,R],X,Y1).

					-Take a pair of [C , R],
					-check if fits , checks if [C,R] is possible in already created schedule X
					-If true then insert  it in X


					schedule(X,X) :- findall( Y, class(Y), R) , lengthlist(N, X) , lengthlist(N, R),! 
					-- It stops when the no of elements in schedule == no of classes.


-------- This schedule can give all possible orders but generate many repetetive results -----
-------- So the functions below removes duplicates	--------------------------------------


checkequal( [C,R], T )		:	Check if [C,R] exist in T.
arrcheck( X , Y )		:	Check if two schedules X and Y are equal .  uses checkequal() . 
searcharr( X , Y ) 		:	Searches if a schedule X is already present in the list of schedules Y , uses arrcheck().
rmduplicates(X, Y)		:	Stores unique schedules/list from X into Y.


----------              Main Function			--------------------------------------

*	start(R)		:-	findall(X , (schedule([],X)) , R1), rmduplicates( R1 ,R),!.


findall(X , (schedule([],X)) , R1)	: It finds all possible schedules using schedule(X,Y) and store them in R1.
rmduplicates( R1 ,R)			: Removes Duplicates schedules and return using R.



					
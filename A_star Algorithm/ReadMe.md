			Aman Aryan 	CSE C		 1651137
-----------------------------------------------------------------------------------------------------------------------


						Assignemnt 2 : Puzzle Problem using A*
							Important Notes.

1:	Working
	- From a state , find all neigbour states
	- Find the state with minimum cost + heuristic
	- Make this next state and run the code again for next state
	- Repeat till goal is reached


	Edit : Solved -------------Issue Description--------
	
	For small solvable problem , it is working.
	But if problem is complex , chances are that if states are as  A -> B -> C -> D -> A -> B -> C -> D ---->
	Code is going in infinite loop. Therefore code was incomplete.

	Incomplete Code-------------Attempted Solution------------

	**Remove the neighbouring states already present in the Path. or already traversed. 


------------------------Function Description  / Defintion / Description---------------------------------------------------



moveup 				: move blank tile up
movedown			: move blank tile down
moveleft			: move blank tile left
moveright			: move blank tile right

findneighbour(X,Y) 		: find all neighbour of X 
allneighbour(X,Y) 		: store all neighbour of X in Y

heurfun()			: calculates heuristic or mismatch from goal 

findmin(ListState , State , Val): return state with min heurfun from a list of states

deletel()			: delete an element if present


setdiff(X,Y,Z)			: Set Diffrence of X and Y
match(Element, Path , Y)	: Returns the element which comes before ele in Path

*changestate(CurrState , PrevState , NewState , Path)	
				: move to next suitable neighbour
					-find all neighbour 
					-delete previous node , so to avoid  
					- find all match or previous accessed node with respect to CurrState
					- Remove already passed cases from neighbor list
					- find min of neighbour list



*puzzle(CurrState, PrevStates ,  TPath , Number):-
				: Find Next State
					Stop if empty next state error,
					Stop if goal found
					Repeat with next state as currstate.

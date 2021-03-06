moveup([[X1|T1],[0|T2],[X3|T3]],[[0|T1],[X1|T2],[X3|T3]]):-!.
moveup([[X1|T1],[X2|T2],[0|T3]],[[X1|T1],[0|T2],[X2|T3]]):-!.
moveup([[X1|T1],[X2|T2],[X3|T3]],[[X1|T11],[X2|T22],[X3|T33]]):-
    moveup([T1,T2,T3],[T11,T22,T33]).


movedown([[0|T1],[X2|T2],[X3|T3]],[[X2|T1],[0|T2],[X3|T3]]):-!.
movedown([[X1|T1],[0|T2],[X3|T3]],[[X1|T1],[X3|T2],[0|T3]]):-!.
movedown([[X1|T1],[X2|T2],[X3|T3]],[[X1|T11],[X2|T22],[X3|T33]]):-
    movedown([T1,T2,T3],[T11,T22,T33]).


moveleft([[X1,0,X3]|T],[[0,X1,X3]|T]):-!.
moveleft([[X1,X2,0]|T],[[X1,0,X2]|T]):-!.
moveleft([[X1,X2,X3]|T],[[X1,X2,X3]|T1]):-
    moveleft(T,T1).

moveright([[X1,0,X3]|T],[[X1,X3,0]|T]):-!.
moveright([[0,X2,X3]|T],[[X2,0,X3]|T]):-!.
moveright([[X1,X2,X3]|T],[[X1,X2,X3]|T1]):-
    moveright(T,T1).


findneighbor(X,Y):-
    moveleft(X,Y);
    moveright(X,Y);
    moveup(X,Y);
    movedown(X,Y).


allneighbor(X,Z):- findall(Y,findneighbor(X,Y),Z).


checkequal( X , X, 0):-!.
checkequal( X , Y, 1).

heurfun([] , [] , 0).
heurfun( [[X1,X2,X3]|T] ,[[Y1,Y2,Y3]|T1] , N ):-
    heurfun(T,T1,N1) ,
    checkequal( X1, Y1, Z1),
    checkequal( X2, Y2, Z2),
    checkequal( X3, Y3, Z3),
    N is Z1+Z2+Z3+N1.


goal([[1,2,3],[4,5,6],[7,8,0]]).


findmin([],[],1000).

findmin( [X|T] ,NextState ,Value ):-
    findmin( T ,Ntemp ,PrevVal ),goal(Goal),heurfun(X,Goal,NewVal),
    ( ( PrevVal >= NewVal , Value = NewVal , NextState = X);
    (PrevVal < NewVal, Value = PrevVal ,NextState = Ntemp) ),!.


deletel(X,[],[]) :- !.
deletel(X,[X|T],T) :- !.
deletel(K,[X|T],[X|T1]):-deletel(K,T,T1).


search(H,[H|T]).
search(X,[H|T]):-search(X,T).
setdiff([],[],[]):-!.
setdiff([],L,[]):-!.
setdiff(L,[],L):-!.
setdiff([H1|T1],[H2|T2],R):-search(H1,[H2|T2]),!,setdiff(T1,[H2|T2],R).
setdiff([H1|T1],[H2|T2],[H1|R]):-setdiff(T1,[H2|T2],R),!.



match( X , [Y,X|T] , Y ).
match( X , [Y,Z|T] , Q ):- match(X, [Z|T] , Q).

changestate(CurrState , PrevState , NewState , Path) :-
    allneighbor(CurrState , AllState) ,
    deletel(PrevState ,  AllState , PossibleStates ),
    findall(X , match( CurrState ,  Path , X) ,  TempNodes),
    setdiff(PossibleStates , TempNodes , FinalState),
    findmin(FinalState,NewState,Value) .

empty([]).

puzzle(CurrState, PrevStates ,  TPath , Number):-
    changestate(CurrState , PrevStates , NState , TPath ),write("->   "),write(NState),write("\n"),
    (
        (empty(NState),Number=0,write("Invalid"),!);
        ((goal(NState)), Number = 0,! ) ;
        (not(goal(NState)), puzzle(NState , CurrState, [NState|TPath] ,Ntemp ), Number is Ntemp+1  )
    ).


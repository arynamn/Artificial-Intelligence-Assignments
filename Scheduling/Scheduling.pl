class(c1).
class(c2).
class(c3).
class(c4).

room(r1).
room(r2).
room(r3).

fits( c1, [r1, r2, r3] ).
fits( c2, [r1, r2, r3] ).
fits( c3, [r1, r2] ).
fits( c4, [r1]).

fitsin( C , R ) :- fits( C, X ), exist( R, X ).

exist(X,[X|T]).
exist(X,[Y|T]) :- exist(X,T).


time( c1, [8,00], [10,30] ).
time( c2, [9,00], [11,30] ).
time( c3, [10,00], [12,30] ).
time( c4, [11,00], [13,30] ).



calctime([SH,SM], [EH,EM], R) :- HT is EH - SH, M is EM - SM, H is HT * 60, R is H+M.
checktime(S1, S2, E1, E2):- calctime(S1, E2, R1), calctime(E1, S2, R2), R is R1*R2, R>0.
notimeconflict(C1, C2) :- time(C1,S1,E1),time(C2,S2,E2),checktime(S1,S2,E1,E2).



ifroompresent( [C,R] , [ ]).
ifroompresent( [C,R] , [[C1,R] | T] ) :- notimeconflict(C,C1),!, ifroompresent( [C,R], T).
ifroompresent( [C,R] , [[C1,R1] | T] ) :- not(R=R1), ifroompresent( [C,R] , T).


ifclasspresent(C,[[C,R]|T]).
ifclasspresent(C, [ [C1,R] |T ]):-ifclasspresent(C,T).

checkroutine([C,R],X):-not(ifclasspresent(C,X)),ifroompresent([C,R],X).


lengthlist(0,[]).
lengthlist(X,[Y|T]):-lengthlist(X1,T),X is X1+1.

insert(E,T,[E|T]).

schedule(X,X) :- findall( Y, class(Y), R) , lengthlist(N, X) , lengthlist(N, R),! .
schedule(X,Y) :- class(C),room(R),fitsin(C,R),checkroutine([C,R],X),insert([C,R],X,Y1),schedule(Y1,Y).


checkequal([C,R],[[C,R]|T]):-!.
checkequal([C,R],[[C1,R1]|T]) :- not(C=C1),checkequal([C,R],T).
arrcheck([],Y).
arrcheck([[C,R]|T],Y):-checkequal([C,R],Y),arrcheck(T,Y).


searcharr(X,[Y|T]):- arrcheck(X,Y),!.
searcharr(X,[Y|T]):- searcharr(X,T).


rmduplicates([],[]).
rmduplicates([H|T],Y):-(searcharr(H,T),rmduplicates(T,Y)).
rmduplicates([H|T],[H|T1]):-(not(searcharr(H,T)),rmduplicates(T,T1)).


start(R):-findall(X , (schedule([],X)) , R1),rmduplicates( R1 ,R),!.

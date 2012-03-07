quantity(x,x,x).

writeN(0,_) :- !. 
writeN(N,T) :- write(T), NN is N-1, writeN(NN,T). 

start :- 
    consult(foutput),
    first(X),
    write(' ;'), printAll(head,X),
    writeN(8,'-'),write(' ;'), printAll(line,X),
    write('min;'), printAll(min,X),
    write('max;'), printAll(max,X),
    write('workload;'), printAll(workload,X),
    writeN(8,'-'),write(' ;'), printAll(line,X),
    forall(in_action(E),(write(E),write(;),printAll(e(E),X))),
    writeN(8,'-'),write(' ;'), printAll(line,X),
    write('sum;'), printAll(sum,X).


printAll(What,Node) :- 
    printOne(What,Node),
    (edge(Node,Next) ->
    printAll(What,Next); 
    nl). 

printOne(line,X) :- 
    atom_length(X,N),
    writeN(N,'-'), write(';').

printOne(head,X) :- 
    write(X), write(';').

printOne(min,X) :- 
    work(X,_,N,_),
    write(N),write(';').

printOne(max,X) :- 
    work(X,_,_,N),
    write(N),write(';').

printOne(workload,X) :- 
    work(X,W,_,_),
    write(W),write(';').

printOne(e(X),Task) :-
    (assign(X,Task,Workload) ->
        (
        findall(Z,assign(_,Task,Z),L),
        sumlist(L,Sum),
        work(Task,Total,_,_),
        Actual is ceiling(Workload * min(1,Total/Sum)),
        write(Actual),
        (quantity(X,Task,Quantity) ->
        (QQ is Quantity + 1,
            write(' ('),
            write(QQ),
            write(')')
        );true),
        write(';')
    );
    write(' ;')).

printOne(sum,Task) :-
    findall(X,assign(_,Task,X),L),
    sumlist(L,Sum),
    work(Task,Workload,_,_),
    ( Sum > Workload ->
      write(Workload);
      write(Sum)
    ),
    write(' ('),
    Fraction is round(100*Sum/Workload),
    write(Fraction),
    write('%)'), 
    write(';').

first(registrering). 
edge(registrering,lis_makro).
edge(lis_makro,bi_makro).
edge(bi_makro,fremforing).
edge(fremforing,stoping).
edge(stoping,mikro).
edge(mikro,farging).
edge(farging,flyt).
edge(flyt,bord).
edge(bord,immun).

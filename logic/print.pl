writeN(0,_) :- !. 
writeN(N,T) :- write(T), NN is N-1, writeN(NN,T). 

start :- 
    consult('tmp/foutput.tmp'),
    first(X),
    write(' ;'), printAll(head,X),
    writeN(8,'-'),write(' ;'), printAll(line,X),
    write('min;'), printAll(min,X),
    write('max;'), printAll(max,X),
    write('workload;'), printAll(workload,X),
    writeN(8,'-'),write(' ;'), printAll(line,X),
    forall(in_action(E),(write(E),write(;),printAll(e(E),X))).

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
    (write(Workload),write(';'));
    write(' ;')).

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
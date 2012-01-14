writeA(X) :- write('\"'), string_to_atom(X,Y),write(Y), write('\"'). 
write2(X,Y) :- write('\"'), write(X), write(' \('), write(Y), write('\)\"').
write3(X,Y) :- write('\"'), write(X), write(' \('), write(Y), write('%\)\"').

start :- 
    consult('tmp/foutput.tmp'),
    first(First),
    write('\{\"cells\":\['),
    findall(X,in_action(X),[A|Es]),
    printAll(e(A),First),
    forall(member(E,Es),(write(',\n'),printAll(e(E),First))),
    write('\],\n\"sum_row\":\['),
    printAll(sum,First),
    write('\n\]\}\n').

printAll(What,Node) :- 
    printOne(What,Node),
    (edge(Node,Next) ->
    printAll(What,Next); 
    true). 

printOne(e(X),Task) :-
    (assign(X,Task,Workload) ->
        (
        findall(Z,assign(_,Task,Z),L),
        sumlist(L,Sum),
        work(Task,Total,_,_),
        Actual is ceiling(Workload * min(1,Total/Sum)),
        write('\{'),
        writeA('cell'),
        write(':{\"name\":'),
        writeA(X),
        write(',\"task\":'),
        writeA(Task),
        write(',\"work_amount\":'),
        write2(Actual,Workload),
        write('\}\}')
    );
    true).

printOne(sum,Task) :-
    findall(X,assign(_,Task,X),L),
    sumlist(L,Sum),
    work(Task,Workload,_,_),
    Fraction is round(100*Sum/Workload),
    (first(Task)->true;write(',')),
    write('\{'),
    writeA('sum_cell'),
    write(':\{\"task\":'),
    writeA(Task),
    write(',\"sum_work\":'),
    write3(Sum,Fraction),
    write('\}\}').


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

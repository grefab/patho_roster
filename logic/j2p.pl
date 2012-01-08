:-use_module(library(http/json)).
:-use_module(library(http/json_convert)).

start(P) :-
    open(P,read,Stream),
    json_read(Stream,J),
    J = json([A,B]), 
    traverse(A), traverse(B),
    close(Stream). 

traverse(workload_per_employees=L) :-
    !,
    traverse(L). 

traverse(tasks=L) :-
    !,
    traverse(L). 

traverse([]) :- !. 
traverse([json(X)|T]) :-
    !,
    writeTask(X),
    %write(X), nl,
    traverse(T). 

writeTask([task=json([name=Task,cap_min=Min,cap_max=Max,workload=Workload])]) :-
    !,
    writeF([work,Task,Workload,Min,Max]).

writeTask([workload_per_employee=json([name=Name,task_name=Task,task_workload=Workload])]) :-
    !,
    writeF([perform,Name,Task,Workload]).

writeF([H|T]) :-
    write(H),
    write('('),
    writeL(T),
    write(').'),
    nl. 

writeL([]).
writeL([H|T]) :- 
    write(H),
    (T = [] -> true ; write(',')), 
    writeL(T). 

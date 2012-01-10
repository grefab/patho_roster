% input work(task,workload,min,max).
% input perform(employee,task,workload). 

employee(E) :- perform(E,_,_).
task(T) :- work(T,_,_,_). 


{ assign(E,S,W) : perform(E,S,W) } 1  :- employee(E).

assign(E,T) :- assign(E,T,_). 
in_action(E) :- assign(E,_). 

:- work(Task,_,_,Max), Max+1 { assign(_,Task) }.
min(Task) :- work(Task,_,Min,_), { assign(_,Task) } Min-1.

understaffed(Task) :- work(Task,Workload,_,_), #sum [ assign(_,Task,Work) = Work ] Workload-1.

ground(Employee,Task,(100*Work)/Workload) :- perform(Employee,Task,Work), work(Task,Workload,_,_). 

understaffed(Employee,Task,Work) :- understaffed(Task), ground(Employee,Task,Work), assign(Employee,Task). 

#maximize[assign(Employee,Task) : ground(Employee,Task,Work)  = Work @1].

#maximize[understaffed(Employee,Task,Workload) : ground(Employee,Task,Workload) = Workload @2].

#minimize[understaffed(Task) : task(Task) @3].

#minimize[min(_) @4].

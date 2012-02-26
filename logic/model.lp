% input work(task,workload,min,max).
% input history(employee,task,history).
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

understaffed(Employee,Task) :- understaffed(Task), assign(Employee,Task). 

% assign at least min people
#minimize[min(_) @4].

% no understaffed
#minimize[understaffed(Task) : task(Task) @3].

% if understaffed, equal distribution of workload in % 
#maximize[understaffed(Employee,Task) : ground(Employee,Task,Workload) = Workload @2].

% increase workload as much as possible in %
#maximize[assign(Employee,Task) : ground(Employee,Task,Work) = Work @1].

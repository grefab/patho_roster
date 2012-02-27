% input work(task,workload,min,max).
% input quantity(employee,task,quantity).
% input perform(employee,task,workload). 

employee(E) :- perform(E,_,_).
task(T) :- work(T,_,_,_). 

quantity_min(Task,MQ) :-  
    task(Task), 
    quantity(_,Task,MQ),
    MQ <= Q : quantity(_,Task,Q).
    

quantity_assign(E,Task,((Q-MQ)*100)/TQ) :- 
    TQ = #sum [quantity(_,Task,Q_) = Q_],
    quantity_min(Task,MQ),
    perform(E,Task,Q).

{ assign(E,S,W) : perform(E,S,W) } 1  :- employee(E).

assign(E,T) :- assign(E,T,_). 
in_action(E) :- assign(E,_). 

:- work(Task,_,_,Max), Max+1 { assign(_,Task) }.
min(Task) :- work(Task,_,Min,_), { assign(_,Task) } Min-1.

understaffed(Task) :- 
    work(Task,Workload,_,_), 
    #sum [ assign(_,Task,Work) = Work ] Workload-1.

ground(Employee,Task,(100*Work)/Workload) :- 
    perform(Employee,Task,Work), 
    work(Task,Workload,_,_). 

understaffed(Employee,Task) :- 
    understaffed(Task), 
    assign(Employee,Task). 

% assign at least min people
#minimize[min(_) @5].

% no understaffed
#minimize[understaffed(Task) : task(Task) @4].

% of the understaffed tasks, maximize workload
#maximize[understaffed(Employee,Task) : ground(Employee,Task,Workload) = Workload @3].

% respect the quantity
#minimize[quantity_assign(E,T,W) = W*W @2].

% increase workload as much as possible in %
#maximize[assign(Employee,Task) : ground(Employee,Task,Work) = Work @1].

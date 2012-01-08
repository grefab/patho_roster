work(registration,150,1).
work(grossing_bi,(4*X)/5, 2)  :- work(registration,X,_).
work(grossing_lis,X/5, 2)     :- work(registration,X,_).
work(processing_bi,3*X,1)   :- work(grossing_bi,X,_).
work(processing_lis,12*X,1) :- work(grossing_lis,X,_).
work(embedding_bi,X,1)      :- work(processing_bi,X,_). 
work(embedding_lis,X,1)     :- work(processing_lis,X,_). 
work(cutting,X+Y,6)         :- work(embedding_bi,X,_),
                                   work(embedding_lis,Y,_).
work(staining,(11*X)/10,2)  :- work(cutting,X,_).

type(2,registration,150). 
type(2,grossing_bi,40).
type(2,grossing_lis,0). 
type(2,processing_bi,360). 
type(2,processing_lis,0). 
type(2,embedding_bi,360). 
type(2,embedding_lis,360). 
type(2,cutting,100). 
type(2,staining,0). 

type(1,registration,150). 
type(1,grossing_bi,80).
type(1,grossing_lis,30). 
type(1,processing_bi,360). 
type(1,processing_lis,360). 
type(1,embedding_bi,360). 
type(1,embedding_lis,360). 
type(1,cutting,300). 
type(1,staining,500). 

e(good(1..5),1).
e(learning(1..5),2).
e(friedemann,1).

good(E) :- e(E,1). 

employeeOfType(X,T) :- e(X,T). 
perform(E,S,W) :- employeeOfType(E,T), type(T,S,W). 

%:- not assign(friedemann,cutting). 

%formatting
first(registration). 
edge(registration,grossing_bi).
edge(grossing_bi,grossing_lis). 
edge(grossing_lis,processing_bi). 
edge(processing_bi,processing_lis). 
edge(processing_lis,embedding_bi).
edge(embedding_bi,embedding_lis).
edge(embedding_lis,cutting). 
edge(cutting,staining). 

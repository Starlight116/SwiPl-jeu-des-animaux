
%-----------Représentation de larbre--------------

racine("Pattes").
arbre("Pattes","Grandes_Oreilles", animal(vipere)).
arbre("Grandes_Oreilles","Trompe",animal(chien)).
arbre("Trompe",animal(elephant), animal(ane)).

%-------------gestion questions/réponses----------------

% permet dafficher  une question et de saisir la réponse

poserQuestion(Question,Reponse) :- writeln(Question), read(Reponse), !.

% permet de proposer une animal et de saisir la reponse

proposerAnimal(Animal) :- writeln(Animal), read(Reponse), traiterReponseAnimal(Animal,Reponse).

traiterReponseAnimal(A,oui):-writeln("J'ai gagné").
traiterReponseAnimal(A,non):-writeln("J'ai perdu"), nouvelleQuestion(A).

nouvelleQuestion(A) :- writeln("A quoi pensiez vous ?"),read(R1), 
							  writeln("donnez une question pour deviner cet animal"),read(R2), 
							  ajouterQuestion(A,R1,R2).
							  
ajouterQuestion(A,R,Q):- retract(arbre(Racine,animal(A),Question)), !,
								 asserta(arbre(Racine,Q,Question)), 
								 asserta(arbre(Q,animal(R),animal(A))).
								 
ajouterQuestion(A,R,Q):- retract(arbre(Racine,Question,animal(A))),
								 asserta(arbre(Racine,Question,Q)), 
								 asserta(arbre(Q,animal(R),animal(A))).
								 
								 
%------------------gestion du jeu----------------------------

jeu :- racine(R),etapeJeu(R).

etapeJeu(animal(A)) :- proposerAnimal(A), !.
etapeJeu(Q) :- poserQuestion(Q,R), traiterReponse(Q,R).

traiterReponse(Q,oui) :- arbre(Q,A,_), etapeJeu(A).
traiterReponse(Q,non) :- arbre(Q,_,B), etapeJeu(B).

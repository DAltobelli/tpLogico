
pareja(marsellus, mia).
pareja(pumkin,honeyBunny).
pareja(bernardo,bianca).
pareja(bernardo,charo).

%------1--------
saleCon(Quien,Cual):- pareja(Quien,Cual).
saleCon(Quien,Cual):- pareja(Cual,Quien).
%--------------3-----------
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

trabajaPara(Quien,bernardo):-
	trabajaPara(marsellus,Quien),
	Quien \= jules.
trabajaPara(Quien,george):-
	saleCon(bernardo,Quien).
%------4-------
conQuienesSale(Personaje,Personajes):-
	saleCon(Personaje,_),
	findall(OtroPersonaje, saleCon(Personaje,OtroPersonaje),Personajes).

esFiel(Personaje):-
	conQuienesSale(Personaje,Personajes),
	length(Personajes,Cantidad),
	Cantidad < 2.	
%-------5-----
%acataOrden es recursiva
acataOrden(Empleador,Empleado):- trabajaPara(Empleador,Empleado). %caso base
acataOrden(Empleador,Empleado):-
		trabajaPara(OtroEmpleador,Empleado),
		acataOrden(Empleador,OtroEmpleador). %caso recursivo
%--------------------------------------------------------------2da entrega---------------------------------------------------------
personaje(pumkin,     ladron([estacionesDeServicio, licorerias])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).
personaje(bernardo,   mafioso(cerebro)).
personaje(bianca,     actriz([elPadrino1])).
personaje(elVendedor, vender([humo, iphone])).
personaje(jimmie,     vender([auto])).


encargo(bernardo, vincent, buscar(jules, fuerteApache)).
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(bernardo, winston, buscar(jules, sanMartin)).
encargo(bernardo, winston, buscar(jules, lugano)).

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).
%--------------1-------------
esPeligroso(Personaje):-
	personaje(Personaje,mafioso(maton)).
esPeligroso(Personaje):-
	personaje(Personaje,ladron(Lista)),
	member(licorerias,Lista).
esPeligroso(Personaje):-
	trabajaPara(Personaje,Empleado),
	esPeligroso(Empleado).
%-------------2--------------
%asi anda 
sanCayetano(UnPersonaje):-
			amigoOEmpleado(UnPersonaje,OtroPersonaje),
			forall(amigoOEmpleado(UnPersonaje,OtroPersonaje),tarea(UnPersonaje,OtroPersonaje)).

tarea(UnPersonaje,OtroPersonaje):-encargo(UnPersonaje,OtroPersonaje,ayudar(_)).
tarea(UnPersonaje,OtroPersonaje):-encargo(UnPersonaje,OtroPersonaje,cuidar(_)).
tarea(UnPersonaje,OtroPersonaje):-encargo(UnPersonaje,OtroPersonaje,buscar(_,_)).
	
amigoOEmpleado(UnPersonaje,OtroPersonaje):- amigo(OtroPersonaje,UnPersonaje).
amigoOEmpleado(UnPersonaje,OtroPersonaje):- trabajaPara(OtroPersonaje,UnPersonaje).
%---------------------3----------------
nivelDeRespeto(UnPersonaje,NivelDeRespeto):-
	personaje(UnPersonaje,     actriz(Lista)),
	length(Lista,Cantidad),
	NivelDeRespeto is Cantidad / 10.
nivelDeRespeto(UnPersonaje,10):-
	personaje(UnPersonaje,  mafioso(Profesion)),
	Profesion = resuelveProblemas.
nivelDeRespeto(UnPersonaje,20):-
	personaje(UnPersonaje,  mafioso(Profesion)),
	Profesion = capo.
nivelDeRespeto(vincent,15).

	
	
	
	






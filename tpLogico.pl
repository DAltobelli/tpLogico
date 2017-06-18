
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
	personaje(Personaje,Ocupacion),
	ocupacionPeligrosa(Ocupacion).
	
esPeligroso(Personaje):-
	trabajaPara(Empleador,Personaje),
	esPeligroso(Empleador).
	
ocupacionPeligrosa(mafioso(maton)).

ocupacionPeligrosa(ladron(Lista)):-
	member(licorerias,Lista).

%-------------2--------------

sanCayetano(UnPersonaje):-
	esCercano(UnPersonaje,_),
	forall(esCercano(UnPersonaje,OtroPersonaje),encargo(UnPersonaje,OtroPersonaje,_)).

esCercano(UnPersonaje,PersonajeCercano):- sonAmigos(PersonajeCercano,UnPersonaje).
esCercano(UnPersonaje,PersonajeCercano):- trabajaPara(PersonajeCercano,UnPersonaje).

sonAmigos(Personaje,OtroPersonaje):-amigo(Personaje,OtroPersonaje).
sonAmigos(Personaje,OtroPersonaje):-amigo(OtroPersonaje,Personaje).

%---------------------3----------------

nivelDeRespeto(vincent,15).

nivelDeRespeto(Personaje,Nivel):-
	personaje(Personaje,Ocupacion),
	niveldeOcupacion(Ocupacion,Nivel).
	
niveldeOcupacion(actriz(Lista),Nivel):-
	length(Lista,Largo),
	Nivel is Largo/10.
	
niveldeOcupacion(mafioso(resuelveProblemas),10).

niveldeOcupacion(mafioso(capo),20).

%--------------------4-------------------

respetabilidad(Respetables,NoRespetables):-
	findall(PersonajeRespetable,esRespetable(PersonajeRespetable),ListaRespetables),
	findall(Personaje,personaje(Personaje,_),ListaPersonajesTotales),
	length(ListaRespetables,Respetables),
	length(ListaPersonajesTotales,PersonajesTotales),
	NoRespetables is PersonajesTotales-Respetables.

esRespetable(Personaje):-
	nivelDeRespeto(Personaje,Nivel),
	Nivel > 9.
	
%------------------5-------------------

masAtareado(Personaje):-
	cantidadEncargos(Personaje,_),
	forall(cantidadEncargos(Personaje,Cant),mayorCantidadDeEncargos(Cant)).

mayorCantidadDeEncargos(Cantidad):-
	findall(Cant,cantidadEncargos(_,Cant),Lista),
	max_list(Lista,Cantidad).

cantidadEncargos(Personaje,Cantidad):-
	encargo(_,Personaje,_),
	findall(Encargo,encargo(_,Personaje,Encargo),ListaDeEncargos),
	length(ListaDeEncargos,Cantidad).


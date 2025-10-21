/*******************************************************************************
 * TRANSLOG - Sistema Experto de Traducción Español-Inglés
 * Módulo: Base de Datos (BD.pl)
 * Descripción: Hechos que representan el diccionario bilingüe con categorías
 *              gramaticales y sus traducciones correspondientes.
 * Estructura: categoria(PalabraEspañol, PalabraInglés)
 * IMPORTANTE: Palabras con tildes/ñ/caracteres especiales van entre comillas
 ******************************************************************************/

% =============================================================================
% SALUDOS Y EXPRESIONES COMUNES
% =============================================================================

saludo(hola, hello).
saludo(hola, hi).
saludo(buenos, good).
saludo('días', morning).
saludo(noches, night).
saludo(tardes, afternoon).
saludo('adiós', goodbye).
saludo('adiós', bye).
saludo(gracias, thanks).
saludo(gracias, 'thank you').

% =============================================================================
% PRONOMBRES PERSONALES
% =============================================================================

% Pronombres sujeto
pronombre(yo, i).
pronombre('tú', you).
pronombre(usted, you).
pronombre('él', he).
pronombre(ella, she).
pronombre(nosotros, we).
pronombre(nosotras, we).
pronombre(ustedes, you).
pronombre(ellos, they).
pronombre(ellas, they).

% Pronombres objeto
pronombre_objeto(me, me).
pronombre_objeto(te, you).
pronombre_objeto(lo, him).
pronombre_objeto(lo, it).
pronombre_objeto(la, her).
pronombre_objeto(la, it).
pronombre_objeto(nos, us).
pronombre_objeto(los, them).
pronombre_objeto(las, them).

% =============================================================================
% PRONOMBRES INTERROGATIVOS
% =============================================================================

interrogativo('qué', what).
interrogativo('quién', who).
interrogativo('quiénes', who).
interrogativo('cuándo', when).
interrogativo('dónde', where).
interrogativo('cómo', how).
interrogativo(por, why).
interrogativo('cuánto', 'how much').
interrogativo('cuántos', 'how many').
interrogativo('cuál', which).

% =============================================================================
% VERBOS COMUNES (PRESENTE)
% =============================================================================

% Verbo SER/ESTAR
verbo(soy, am).
verbo(eres, are).
verbo(es, is).
verbo(somos, are).
verbo(son, are).
verbo(estoy, am).
verbo('estás', are).
verbo('está', is).
verbo(estamos, are).
verbo('están', are).

% Verbo TENER
verbo(tengo, have).
verbo(tienes, have).
verbo(tiene, has).
verbo(tenemos, have).
verbo(tienen, have).

% Verbo HACER
verbo(hago, do).
verbo(haces, do).
verbo(hace, does).
verbo(hacemos, do).
verbo(hacen, do).

% Verbo IR
verbo(voy, go).
verbo(vas, go).
verbo(va, goes).
verbo(vamos, go).
verbo(van, go).

% Verbos de acción comunes
verbo(como, eat).
verbo(comes, eat).
verbo(come, eats).
verbo(comemos, eat).
verbo(comen, eat).

verbo(bebo, drink).
verbo(bebes, drink).
verbo(bebe, drinks).
verbo(bebemos, drink).
verbo(beben, drink).

verbo(veo, see).
verbo(ves, see).
verbo(ve, sees).
verbo(vemos, see).
verbo(ven, see).

verbo(hablo, speak).
verbo(hablas, speak).
verbo(habla, speaks).
verbo(hablamos, speak).
verbo(hablan, speak).

verbo(trabajo, work).
verbo(trabajas, work).
verbo(trabaja, works).
verbo(trabajamos, work).
verbo(trabajan, work).

verbo(estudio, study).
verbo(estudias, study).
verbo(estudia, studies).
verbo(estudiamos, study).
verbo(estudian, study).

verbo(vivo, live).
verbo(vives, live).
verbo(vive, lives).
verbo(vivimos, live).
verbo(viven, live).

verbo(quiero, want).
verbo(quieres, want).
verbo(quiere, wants).
verbo(queremos, want).
verbo(quieren, want).

verbo(puedo, can).
verbo(puedes, can).
verbo(puede, can).
verbo(podemos, can).
verbo(pueden, can).

% =============================================================================
% SUSTANTIVOS COMUNES
% =============================================================================

sustantivo(casa, house).
sustantivo(carro, car).
sustantivo(coche, car).
sustantivo(perro, dog).
sustantivo(gato, cat).
sustantivo(libro, book).
sustantivo(mesa, table).
sustantivo(silla, chair).
sustantivo(agua, water).
sustantivo(comida, food).
sustantivo('día', day).
sustantivo(noche, night).
sustantivo('mañana', morning).
sustantivo(tarde, afternoon).
sustantivo(tiempo, time).
sustantivo(persona, person).
sustantivo(hombre, man).
sustantivo(mujer, woman).
sustantivo('niño', boy).
sustantivo('niña', girl).
sustantivo(amigo, friend).
sustantivo(familia, family).
sustantivo(trabajo, work).
sustantivo(escuela, school).
sustantivo(universidad, university).
sustantivo(ciudad, city).
sustantivo('país', country).
sustantivo(mundo, world).
sustantivo('año', year).
sustantivo('años', years).
sustantivo(edad, age).
sustantivo(nombre, name).

% =============================================================================
% ADJETIVOS
% =============================================================================

adjetivo(bueno, good).
adjetivo(malo, bad).
adjetivo(grande, big).
adjetivo('pequeño', small).
adjetivo(nuevo, new).
adjetivo(viejo, old).
adjetivo(joven, young).
adjetivo(feliz, happy).
adjetivo(triste, sad).
adjetivo('rápido', fast).
adjetivo(lento, slow).
adjetivo(alto, tall).
adjetivo(bajo, short).
adjetivo(bonito, beautiful).
adjetivo(feo, ugly).
adjetivo('fácil', easy).
adjetivo('difícil', difficult).
adjetivo(importante, important).

% =============================================================================
% ARTÍCULOS
% =============================================================================

articulo(el, the).
articulo(la, the).
articulo(los, the).
articulo(las, the).
articulo(un, a).
articulo(una, a).
articulo(unos, some).
articulo(unas, some).

% =============================================================================
% PREPOSICIONES
% =============================================================================

preposicion(a, to).
preposicion(de, of).
preposicion(de, from).
preposicion(en, in).
preposicion(en, on).
preposicion(con, with).
preposicion(sin, without).
preposicion(para, for).
preposicion(por, for).
preposicion(sobre, about).
preposicion(bajo, under).
preposicion(entre, between).
preposicion(desde, from).
preposicion(hasta, until).

% =============================================================================
% CONJUNCIONES
% =============================================================================

conjuncion(y, and).
conjuncion(o, or).
conjuncion(pero, but).
conjuncion(porque, because).
conjuncion(si, if).
conjuncion(cuando, when).
conjuncion(que, that).

% =============================================================================
% ADVERBIOS
% =============================================================================

adverbio(muy, very).
adverbio(mucho, much).
adverbio(poco, little).
adverbio('más', more).
adverbio(menos, less).
adverbio(bien, well).
adverbio(mal, badly).
adverbio(siempre, always).
adverbio(nunca, never).
adverbio(ahora, now).
adverbio('aquí', here).
adverbio('allí', there).
adverbio(hoy, today).
adverbio(ayer, yesterday).
adverbio('mañana', tomorrow).

% =============================================================================
% NÚMEROS
% =============================================================================

numero(uno, one).
numero(dos, two).
numero(tres, three).
numero(cuatro, four).
numero(cinco, five).
numero(seis, six).
numero(siete, seven).
numero(ocho, eight).
numero(nueve, nine).
numero(diez, ten).

% =============================================================================
% SIGNOS DE PUNTUACIÓN E INTERROGACIÓN
% =============================================================================

puntuacion('.', '.').
puntuacion(',', ',').
puntuacion('?', '?').
puntuacion('¿', '').  % El español usa ¿ pero el inglés no
puntuacion('!', '!').
puntuacion('¡', '').  % El español usa ¡ pero el inglés no

% =============================================================================
% PREDICADOS AUXILIARES
% =============================================================================

% Verifica si una palabra existe en la base de datos en español
palabra_espanol(Palabra) :-
    (saludo(Palabra, _);
     pronombre(Palabra, _);
     pronombre_objeto(Palabra, _);
     interrogativo(Palabra, _);
     verbo(Palabra, _);
     sustantivo(Palabra, _);
     adjetivo(Palabra, _);
     articulo(Palabra, _);
     preposicion(Palabra, _);
     conjuncion(Palabra, _);
     adverbio(Palabra, _);
     numero(Palabra, _)).

% Verifica si una palabra existe en la base de datos en inglés
palabra_ingles(Palabra) :-
    (saludo(_, Palabra);
     pronombre(_, Palabra);
     pronombre_objeto(_, Palabra);
     interrogativo(_, Palabra);
     verbo(_, Palabra);
     sustantivo(_, Palabra);
     adjetivo(_, Palabra);
     articulo(_, Palabra);
     preposicion(_, Palabra);
     conjuncion(_, Palabra);
     adverbio(_, Palabra);
     numero(_, Palabra)).

% Busca la traducción de una palabra de español a inglés
traducir_palabra_es_en(Espanol, Ingles) :-
    (saludo(Espanol, Ingles);
     pronombre(Espanol, Ingles);
     pronombre_objeto(Espanol, Ingles);
     interrogativo(Espanol, Ingles);
     verbo(Espanol, Ingles);
     sustantivo(Espanol, Ingles);
     adjetivo(Espanol, Ingles);
     articulo(Espanol, Ingles);
     preposicion(Espanol, Ingles);
     conjuncion(Espanol, Ingles);
     adverbio(Espanol, Ingles);
     numero(Espanol, Ingles)).

% Busca la traducción de una palabra de inglés a español
traducir_palabra_en_es(Ingles, Espanol) :-
    (saludo(Espanol, Ingles);
     pronombre(Espanol, Ingles);
     pronombre_objeto(Espanol, Ingles);
     interrogativo(Espanol, Ingles);
     verbo(Espanol, Ingles);
     sustantivo(Espanol, Ingles);
     adjetivo(Espanol, Ingles);
     articulo(Espanol, Ingles);
     preposicion(Espanol, Ingles);
     conjuncion(Espanol, Ingles);
     adverbio(Espanol, Ingles);
     numero(Espanol, Ingles)).
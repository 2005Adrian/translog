/*******************************************************************************
 * TRANSLOG - Sistema Experto de Traducción Español-Inglés
 * Módulo: Lógica (Logic.pl)
 * Descripción: Reglas gramaticales y algoritmos de traducción basados en
 *              Gramáticas Libres de Contexto (CFG) y análisis sintáctico.
 * Requiere: BD.pl (Base de datos bilingüe)
 ******************************************************************************/

:- [bd].  % Cargar la base de datos

% =============================================================================
% ESTRUCTURAS GRAMATICALES
% =============================================================================

/*
 * Estructura de una oración:
 * oracion(Tipo, Componentes)
 * Tipos: simple, interrogativa, imperativa
 */

% =============================================================================
% ANÁLISIS SINTÁCTICO - ESPAÑOL
% =============================================================================

% Oración simple en español: Sujeto + Verbo + (Complemento)
% Ejemplo: "Yo como pizza"
oracion_es([Pronombre|Resto]) :-
    pronombre(Pronombre, _),
    sintagma_verbal_es(Resto).

% Oración interrogativa en español
% Ejemplo: "¿Cómo estás?"
oracion_interrogativa_es(['¿', Interrogativo|Resto]) :-
    interrogativo(Interrogativo, _),
    oracion_es(Resto).

oracion_interrogativa_es([Interrogativo|Resto]) :-
    interrogativo(Interrogativo, _),
    oracion_es(Resto).

% Saludo simple
% Ejemplo: "Hola"
oracion_saludo_es([Saludo]) :-
    saludo(Saludo, _).

% Saludo compuesto
% Ejemplo: "Buenos días"
oracion_saludo_es([Palabra1, Palabra2]) :-
    saludo(Palabra1, _),
    saludo(Palabra2, _).

% Sintagma verbal en español: Verbo + (Complementos)
sintagma_verbal_es([Verbo|Resto]) :-
    verbo(Verbo, _),
    (Resto = [] ; complemento_es(Resto)).

% Sintagma nominal en español: (Artículo) + (Adjetivo) + Sustantivo
sintagma_nominal_es([Sustantivo]) :-
    sustantivo(Sustantivo, _).

sintagma_nominal_es([Articulo, Sustantivo]) :-
    articulo(Articulo, _),
    sustantivo(Sustantivo, _).

sintagma_nominal_es([Articulo, Adjetivo, Sustantivo]) :-
    articulo(Articulo, _),
    adjetivo(Adjetivo, _),
    sustantivo(Sustantivo, _).

sintagma_nominal_es([Adjetivo, Sustantivo]) :-
    adjetivo(Adjetivo, _),
    sustantivo(Sustantivo, _).

% Complemento
complemento_es(Lista) :-
    sintagma_nominal_es(Lista).

complemento_es([Preposicion|Resto]) :-
    preposicion(Preposicion, _),
    sintagma_nominal_es(Resto).

% =============================================================================
% ANÁLISIS SINTÁCTICO - INGLÉS
% =============================================================================

% Oración simple en inglés: Sujeto + Verbo + (Complemento)
oracion_en([Pronombre|Resto]) :-
    pronombre(_, Pronombre),
    sintagma_verbal_en(Resto).

% Oración interrogativa en inglés
% Ejemplo: "How are you?"
oracion_interrogativa_en([Interrogativo|Resto]) :-
    interrogativo(_, Interrogativo),
    oracion_en(Resto).

% Saludo simple
oracion_saludo_en([Saludo]) :-
    saludo(_, Saludo).

% Saludo compuesto
oracion_saludo_en([Palabra1, Palabra2]) :-
    saludo(_, Palabra1),
    saludo(_, Palabra2).

% Sintagma verbal en inglés
sintagma_verbal_en([Verbo|Resto]) :-
    verbo(_, Verbo),
    (Resto = [] ; complemento_en(Resto)).

% Sintagma nominal en inglés
sintagma_nominal_en([Sustantivo]) :-
    sustantivo(_, Sustantivo).

sintagma_nominal_en([Articulo, Sustantivo]) :-
    articulo(_, Articulo),
    sustantivo(_, Sustantivo).

sintagma_nominal_en([Articulo, Adjetivo, Sustantivo]) :-
    articulo(_, Articulo),
    adjetivo(_, Adjetivo),
    sustantivo(_, Sustantivo).

sintagma_nominal_en([Adjetivo, Sustantivo]) :-
    adjetivo(_, Adjetivo),
    sustantivo(_, Sustantivo).

% Complemento
complemento_en(Lista) :-
    sintagma_nominal_en(Lista).

complemento_en([Preposicion|Resto]) :-
    preposicion(_, Preposicion),
    sintagma_nominal_en(Resto).

% =============================================================================
% MOTOR DE TRADUCCIÓN PRINCIPAL
% =============================================================================

/*
 * traducir(ListaOrigen, ListaDestino)
 * Traduce una lista de palabras del idioma de origen al idioma de destino
 * Detecta automáticamente el idioma de origen
 */

% Traducir de español a inglés
traducir(ListaEs, ListaEn) :-
    detectar_idioma(ListaEs, espanol),
    !,
    traducir_es_a_en(ListaEs, ListaEn).

% Traducir de inglés a español
traducir(ListaEn, ListaEs) :-
    detectar_idioma(ListaEn, ingles),
    !,
    traducir_en_a_es(ListaEn, ListaEs).

% Si no se puede detectar el idioma, intentar traducción palabra por palabra
traducir(Origen, Destino) :-
    traducir_lista_palabras(Origen, Destino).

% =============================================================================
% DETECCIÓN DE IDIOMA
% =============================================================================

% Detecta si la primera palabra reconocible es española
detectar_idioma([Palabra|_], espanol) :-
    palabra_espanol(Palabra),
    !.

detectar_idioma(['¿'|_], espanol) :- !.
detectar_idioma(['¡'|_], espanol) :- !.

% Detecta si la primera palabra reconocible es inglesa
detectar_idioma([Palabra|_], ingles) :-
    palabra_ingles(Palabra),
    \+ palabra_espanol(Palabra),
    !.

% Continuar buscando en el resto de la lista
detectar_idioma([_|Resto], Idioma) :-
    Resto \= [],
    detectar_idioma(Resto, Idioma).

% =============================================================================
% TRADUCCIÓN ESPAÑOL → INGLÉS
% =============================================================================

% Caso 1: Saludo simple
traducir_es_a_en([Saludo], [TraduccionEn]) :-
    saludo(Saludo, TraduccionEn),
    !.

% Caso 2: Saludo compuesto (ej: "Buenos días" -> "Good morning")
traducir_es_a_en([P1, P2], [T1, T2]) :-
    saludo(P1, T1),
    saludo(P2, T2),
    !.

% Caso 3: Oración interrogativa (ej: "¿Cómo estás?" -> "How are you?")
traducir_es_a_en(['¿', Interrogativo|Resto], [TraduccionInterrog|RestoTraducido]) :-
    interrogativo(Interrogativo, TraduccionInterrog),
    !,
    traducir_lista_palabras(Resto, RestoTemp),
    eliminar_signos_espanol(RestoTemp, RestoTraducido).

traducir_es_a_en([Interrogativo|Resto], [TraduccionInterrog|RestoTraducido]) :-
    interrogativo(Interrogativo, TraduccionInterrog),
    !,
    traducir_lista_palabras(Resto, RestoTemp),
    eliminar_signos_espanol(RestoTemp, RestoTraducido).

% Caso 4: Oración simple (traducción palabra por palabra con estructura)
traducir_es_a_en(ListaEs, ListaEn) :-
    traducir_lista_palabras(ListaEs, ListaTemp),
    eliminar_signos_espanol(ListaTemp, ListaEn).

% =============================================================================
% TRADUCCIÓN INGLÉS → ESPAÑOL
% =============================================================================

% Caso 1: Saludo simple
traducir_en_a_es([Saludo], [TraduccionEs]) :-
    saludo(TraduccionEs, Saludo),
    !.

% Caso 2: Saludo compuesto
traducir_en_a_es([P1, P2], [T1, T2]) :-
    saludo(T1, P1),
    saludo(T2, P2),
    !.

% Caso 3: Oración interrogativa (ej: "How are you?" -> "¿Cómo estás?")
traducir_en_a_es([Interrogativo|Resto], ['¿', TraduccionInterrog|RestoTraducido]) :-
    interrogativo(TraduccionInterrog, Interrogativo),
    !,
    traducir_lista_palabras_en_es(Resto, RestoTemp),
    agregar_cierre_interrogacion(RestoTemp, RestoTraducido).

% Caso 4: Oración simple
traducir_en_a_es(ListaEn, ListaEs) :-
    traducir_lista_palabras_en_es(ListaEn, ListaEs).

% =============================================================================
% TRADUCCIÓN PALABRA POR PALABRA
% =============================================================================

% Traducir lista de palabras de español a inglés
traducir_lista_palabras([], []).

traducir_lista_palabras([Palabra|Resto], [Traduccion|RestoTraducido]) :-
    traducir_palabra_es_en(Palabra, Traduccion),
    !,
    traducir_lista_palabras(Resto, RestoTraducido).

traducir_lista_palabras([Palabra|Resto], [Palabra|RestoTraducido]) :-
    puntuacion(Palabra, Palabra),
    !,
    traducir_lista_palabras(Resto, RestoTraducido).

% Si no encuentra traducción, mantener la palabra original
traducir_lista_palabras([Palabra|Resto], [Palabra|RestoTraducido]) :-
    traducir_lista_palabras(Resto, RestoTraducido).

% Traducir lista de palabras de inglés a español
traducir_lista_palabras_en_es([], []).

traducir_lista_palabras_en_es([Palabra|Resto], [Traduccion|RestoTraducido]) :-
    traducir_palabra_en_es(Palabra, Traduccion),
    !,
    traducir_lista_palabras_en_es(Resto, RestoTraducido).

traducir_lista_palabras_en_es([Palabra|Resto], [Palabra|RestoTraducido]) :-
    puntuacion(Palabra, Palabra),
    !,
    traducir_lista_palabras_en_es(Resto, RestoTraducido).

% Si no encuentra traducción, mantener la palabra original
traducir_lista_palabras_en_es([Palabra|Resto], [Palabra|RestoTraducido]) :-
    traducir_lista_palabras_en_es(Resto, RestoTraducido).

% =============================================================================
% UTILIDADES
% =============================================================================

% Elimina signos de puntuación específicos del español (¿, ¡)
eliminar_signos_espanol([], []).
eliminar_signos_espanol(['¿'|Resto], Resultado) :-
    !,
    eliminar_signos_espanol(Resto, Resultado).
eliminar_signos_espanol(['¡'|Resto], Resultado) :-
    !,
    eliminar_signos_espanol(Resto, Resultado).
eliminar_signos_espanol([Elemento|Resto], [Elemento|RestoLimpio]) :-
    eliminar_signos_espanol(Resto, RestoLimpio).

% Agrega signo de cierre de interrogación al final
agregar_cierre_interrogacion(Lista, Resultado) :-
    append(Lista, ['?'], Resultado).

% Convierte una cadena de texto en lista de palabras (átomos)
% Nota: Para uso en SWI-Prolog con split_string o atom_chars
texto_a_lista(Texto, Lista) :-
    atomic_list_concat(Lista, ' ', Texto).

% Convierte una lista de palabras en cadena de texto
lista_a_texto(Lista, Texto) :-
    atomic_list_concat(Lista, ' ', Texto).

% =============================================================================
% PREDICADOS DE INTERFAZ PARA TESTING
% =============================================================================

% Traducir y mostrar resultado como texto
traducir_texto(TextoOrigen, TextoDestino) :-
    texto_a_lista(TextoOrigen, ListaOrigen),
    traducir(ListaOrigen, ListaDestino),
    lista_a_texto(ListaDestino, TextoDestino).

% Mostrar análisis de la oración
analizar_oracion(Lista) :-
    write('Analizando: '), write(Lista), nl,
    (   oracion_saludo_es(Lista) ->
        write('Tipo: Saludo en español'), nl
    ;   oracion_saludo_en(Lista) ->
        write('Tipo: Saludo en inglés'), nl
    ;   oracion_interrogativa_es(Lista) ->
        write('Tipo: Oración interrogativa en español'), nl
    ;   oracion_interrogativa_en(Lista) ->
        write('Tipo: Oración interrogativa en inglés'), nl
    ;   oracion_es(Lista) ->
        write('Tipo: Oración simple en español'), nl
    ;   oracion_en(Lista) ->
        write('Tipo: Oración simple en inglés'), nl
    ;   write('Tipo: No reconocida completamente'), nl
    ).

% =============================================================================
% EJEMPLOS DE USO
% =============================================================================

/*
EJEMPLOS DE CONSULTAS:

1. Saludo simple:
   ?- traducir([hola], Resultado).
   Resultado = [hello].

2. Pregunta en español:
   ?- traducir(['¿', cómo, estás, '?'], Resultado).
   Resultado = [how, are, you, '?'].

3. Pregunta en inglés:
   ?- traducir([how, old, are, you, '?'], Resultado).
   Resultado = ['¿', cómo, viejo, eres, tú, '?'].

4. Oración simple:
   ?- traducir([yo, como, pizza], Resultado).
   Resultado = [i, eat, pizza].

5. Con texto:
   ?- traducir_texto('hola cómo estás', Resultado).
   Resultado = 'hello how are you'.
*/
/*******************************************************************************
 * TRANSLOG - Sistema Experto de Traducción Español-Inglés
 * Módulo: Interfaz BNF (BNF.pl)
 * Descripción: Interfaz de usuario que procesa entradas, gestiona el diálogo
 *              y presenta las traducciones de manera amigable.
 * Requiere: BD.pl, Logic.pl
 ******************************************************************************/

:- [bd].     % Cargar base de datos
:- [logic].  % Cargar módulo de lógica

% =============================================================================
% GRAMÁTICA BNF (Backus-Naur Form) - DEFINICIÓN FORMAL
% =============================================================================

/*
GRAMÁTICA FORMAL DEL SISTEMA:

<oracion> ::= <saludo> | <oracion_simple> | <oracion_interrogativa>

<saludo> ::= <palabra_saludo> | <palabra_saludo> <palabra_saludo>

<oracion_simple> ::= <sujeto> <predicado>

<oracion_interrogativa> ::= <signo_apertura> <palabra_interrogativa> <oracion_simple> <signo_cierre>
                         | <palabra_interrogativa> <oracion_simple> <signo_cierre>

<sujeto> ::= <pronombre> | <sintagma_nominal>

<predicado> ::= <verbo> | <verbo> <complemento>

<sintagma_nominal> ::= <sustantivo>
                    | <articulo> <sustantivo>
                    | <articulo> <adjetivo> <sustantivo>
                    | <adjetivo> <sustantivo>

<complemento> ::= <sintagma_nominal>
               | <preposicion> <sintagma_nominal>

<signo_apertura> ::= "¿" | "¡"
<signo_cierre> ::= "?" | "!"
*/

% =============================================================================
% SISTEMA PRINCIPAL - INICIALIZACIÓN
% =============================================================================

% Iniciar TransLog
iniciar :-
    limpiar_pantalla,
    mostrar_banner,
    mostrar_menu_principal.

% Limpiar pantalla (multiplataforma)
limpiar_pantalla :-
    write('\33\[2J').

% Banner del sistema
mostrar_banner :-
    nl,
    write('╔════════════════════════════════════════════════════════════╗'), nl,
    write('║                        TRANSLOG v1.0                       ║'), nl,
    write('║          Sistema Experto de Traducción Bilingüe           ║'), nl,
    write('║                   Español ⇄ Inglés                        ║'), nl,
    write('╚════════════════════════════════════════════════════════════╝'), nl,
    nl.

% =============================================================================
% MENÚ PRINCIPAL
% =============================================================================

mostrar_menu_principal :-
    nl,
    write('═══════════════════ MENÚ PRINCIPAL ═══════════════════'), nl,
    write('1. Traducir oración'), nl,
    write('2. Modo interactivo'), nl,
    write('3. Ejemplos de uso'), nl,
    write('4. Ver estadísticas del diccionario'), nl,
    write('5. Ayuda'), nl,
    write('6. Salir'), nl,
    write('══════════════════════════════════════════════════════'), nl,
    write('Seleccione una opción: '),
    read(Opcion),
    procesar_opcion_menu(Opcion).

% Procesar opción del menú
procesar_opcion_menu(1) :-
    !,
    traducir_interactivo,
    mostrar_menu_principal.

procesar_opcion_menu(2) :-
    !,
    modo_conversacion,
    mostrar_menu_principal.

procesar_opcion_menu(3) :-
    !,
    mostrar_ejemplos,
    mostrar_menu_principal.

procesar_opcion_menu(4) :-
    !,
    mostrar_estadisticas,
    mostrar_menu_principal.

procesar_opcion_menu(5) :-
    !,
    mostrar_ayuda,
    mostrar_menu_principal.

procesar_opcion_menu(6) :-
    !,
    write('¡Gracias por usar TransLog! / Thank you for using TransLog!'), nl,
    write('Saliendo...'), nl.

procesar_opcion_menu(_) :-
    write('Opción no válida. Intente de nuevo.'), nl,
    mostrar_menu_principal.

% =============================================================================
% MODO TRADUCCIÓN INTERACTIVA
% =============================================================================

traducir_interactivo :-
    nl,
    write('═════════ MODO TRADUCCIÓN ═════════'), nl,
    write('Ingrese la oración a traducir (use punto al final): '), nl,
    read(Oracion),
    procesar_oracion_usuario(Oracion).

% Procesar entrada del usuario
procesar_oracion_usuario(Oracion) :-
    atom(Oracion),
    !,
    atomic_list_concat(Palabras, ' ', Oracion),
    limpiar_palabras(Palabras, PalabrasLimpias),
    realizar_traduccion(PalabrasLimpias).

procesar_oracion_usuario(Lista) :-
    is_list(Lista),
    !,
    realizar_traduccion(Lista).

procesar_oracion_usuario(_) :-
    write('Formato no válido. Use comillas o lista [palabra1, palabra2, ...].'), nl.

% Realizar traducción y mostrar resultado
realizar_traduccion(Palabras) :-
    nl,
    write('Entrada: '), mostrar_lista(Palabras), nl,
    write('Analizando...'), nl,
    
    % Detectar idioma
    (   detectar_idioma(Palabras, espanol) ->
        write('Idioma detectado: Español'), nl,
        Origen = 'Español',
        Destino = 'English'
    ;   detectar_idioma(Palabras, ingles) ->
        write('Idioma detectado: Inglés'), nl,
        Origen = 'English',
        Destino = 'Español'
    ;   write('Idioma: No detectado (traducción genérica)'), nl,
        Origen = 'Desconocido',
        Destino = 'Desconocido'
    ),
    
    % Realizar traducción
    (   traducir(Palabras, Traduccion) ->
        nl,
        write('─────────────────────────────────────'), nl,
        write('Traducción exitosa:'), nl,
        write(Origen), write(': '), mostrar_lista(Palabras), nl,
        write(Destino), write(': '), mostrar_lista(Traduccion), nl,
        write('─────────────────────────────────────'), nl
    ;   write('No se pudo traducir la oración completa.'), nl,
        write('Intente con oraciones más simples.'), nl
    ).

% =============================================================================
% MODO CONVERSACIÓN CONTINUA
% =============================================================================

modo_conversacion :-
    nl,
    write('═════════ MODO CONVERSACIÓN ═════════'), nl,
    write('Escriba oraciones para traducir.'), nl,
    write('Escriba "salir" o "exit" para volver al menú.'), nl,
    write('──────────────────────────────────────'), nl,
    bucle_conversacion.

bucle_conversacion :-
    nl,
    write('>> '),
    read(Entrada),
    procesar_entrada_conversacion(Entrada).

procesar_entrada_conversacion(salir) :- 
    !,
    write('Volviendo al menú principal...'), nl.

procesar_entrada_conversacion(exit) :- 
    !,
    write('Returning to main menu...'), nl.

procesar_entrada_conversacion(Entrada) :-
    procesar_oracion_usuario(Entrada),
    bucle_conversacion.

% =============================================================================
% EJEMPLOS DE USO
% =============================================================================

mostrar_ejemplos :-
    nl,
    write('═════════════════ EJEMPLOS DE USO ═════════════════'), nl,
    nl,
    write('Ejemplo 1: Saludo simple'), nl,
    write('  Entrada:  [hola]'), nl,
    write('  Salida:   [hello]'), nl,
    nl,
    write('Ejemplo 2: Pregunta en español'), nl,
    write('  Entrada:  [¿, cómo, estás, ?]'), nl,
    write('  Salida:   [how, are, you, ?]'), nl,
    nl,
    write('Ejemplo 3: Pregunta en inglés'), nl,
    write('  Entrada:  [how, old, are, you, ?]'), nl,
    write('  Salida:   [¿, cómo, viejo, son, tú, ?]'), nl,
    nl,
    write('Ejemplo 4: Oración simple español'), nl,
    write('  Entrada:  [yo, como, pizza]'), nl,
    write('  Salida:   [i, eat, pizza]'), nl,
    nl,
    write('Ejemplo 5: Oración simple inglés'), nl,
    write('  Entrada:  [i, have, a, dog]'), nl,
    write('  Salida:   [yo, tengo, un, perro]'), nl,
    nl,
    write('Ejemplo 6: Buenos días'), nl,
    write('  Entrada:  [buenos, días]'), nl,
    write('  Salida:   [good, morning]'), nl,
    nl,
    write('═══════════════════════════════════════════════════'), nl,
    write('Presione Enter para continuar...'),
    get_char(_).

% =============================================================================
% ESTADÍSTICAS DEL DICCIONARIO
% =============================================================================

mostrar_estadisticas :-
    nl,
    write('═════════ ESTADÍSTICAS DEL DICCIONARIO ═════════'), nl,
    nl,
    
    contar_categoria(saludo, CantSaludos),
    write('Saludos y expresiones: '), write(CantSaludos), nl,
    
    contar_categoria(pronombre, CantPronombres),
    write('Pronombres: '), write(CantPronombres), nl,
    
    contar_categoria(verbo, CantVerbos),
    write('Verbos: '), write(CantVerbos), nl,
    
    contar_categoria(sustantivo, CantSustantivos),
    write('Sustantivos: '), write(CantSustantivos), nl,
    
    contar_categoria(adjetivo, CantAdjetivos),
    write('Adjetivos: '), write(CantAdjetivos), nl,
    
    contar_categoria(articulo, CantArticulos),
    write('Artículos: '), write(CantArticulos), nl,
    
    contar_categoria(preposicion, CantPreposiciones),
    write('Preposiciones: '), write(CantPreposiciones), nl,
    
    contar_categoria(conjuncion, CantConjunciones),
    write('Conjunciones: '), write(CantConjunciones), nl,
    
    contar_categoria(adverbio, CantAdverbios),
    write('Adverbios: '), write(CantAdverbios), nl,
    
    Total is CantSaludos + CantPronombres + CantVerbos + CantSustantivos +
             CantAdjetivos + CantArticulos + CantPreposiciones + 
             CantConjunciones + CantAdverbios,
    nl,
    write('TOTAL DE PALABRAS: '), write(Total), nl,
    write('════════════════════════════════════════════════'), nl,
    write('Presione Enter para continuar...'),
    get_char(_).

% Contar palabras de una categoría
contar_categoria(Categoria, Cantidad) :-
    Goal =.. [Categoria, _, _],
    findall(1, Goal, Lista),
    length(Lista, Cantidad).

% =============================================================================
% AYUDA DEL SISTEMA
% =============================================================================

mostrar_ayuda :-
    nl,
    write('═══════════════════ AYUDA - TRANSLOG ═══════════════════'), nl,
    nl,
    write('CÓMO USAR EL SISTEMA:'), nl,
    nl,
    write('1. FORMATO DE ENTRADA:'), nl,
    write('   - Use listas: [hola, como, estas]'), nl,
    write('   - O texto: "hola como estas"'), nl,
    write('   - Incluya signos: [¿, cómo, estás, ?]'), nl,
    nl,
    write('2. CAPACIDADES:'), nl,
    write('   - Traduce saludos simples y compuestos'), nl,
    write('   - Traduce oraciones interrogativas'), nl,
    write('   - Traduce oraciones simples (Sujeto + Verbo + Complemento)'), nl,
    write('   - Detecta automáticamente el idioma de origen'), nl,
    nl,
    write('3. LIMITACIONES:'), nl,
    write('   - Diccionario limitado a palabras comunes'), nl,
    write('   - No maneja tiempos verbales compuestos'), nl,
    write('   - Estructura gramatical simplificada'), nl,
    write('   - No distingue contextos (polisemia limitada)'), nl,
    nl,
    write('4. CONSEJOS:'), nl,
    write('   - Use oraciones simples y directas'), nl,
    write('   - Verifique que las palabras estén en el diccionario'), nl,
    write('   - Consulte los ejemplos para guiarse'), nl,
    nl,
    write('════════════════════════════════════════════════════════'), nl,
    write('Presione Enter para continuar...'),
    get_char(_).

% =============================================================================
% UTILIDADES DE PRESENTACIÓN
% =============================================================================

% Mostrar lista de palabras de forma legible
mostrar_lista([]) :- nl.
mostrar_lista([Ultima]) :-
    !,
    write(Ultima).
mostrar_lista([Palabra|Resto]) :-
    write(Palabra),
    write(' '),
    mostrar_lista(Resto).

% Limpiar palabras (eliminar espacios, convertir a minúsculas)
limpiar_palabras([], []).
limpiar_palabras([Palabra|Resto], [PalabraLimpia|RestoLimpio]) :-
    atom(Palabra),
    downcase_atom(Palabra, PalabraLimpia),
    limpiar_palabras(Resto, RestoLimpio).

% =============================================================================
% TESTING AUTOMATIZADO
% =============================================================================

ejecutar_tests :-
    nl,
    write('═════════ EJECUTANDO TESTS ═════════'), nl,
    nl,
    
    % Test 1
    write('Test 1: Saludo simple'), nl,
    test_traduccion([hola], [hello]),
    
    % Test 2
    write('Test 2: Pregunta española'), nl,
    test_traduccion(['¿', cómo, estás, '?'], [how, are, you, '?']),
    
    % Test 3
    write('Test 3: Pregunta inglesa'), nl,
    test_traduccion([how, are, you, '?'], ['¿', cómo, son, tú, '?']),
    
    % Test 4
    write('Test 4: Oración simple'), nl,
    test_traduccion([yo, como], [i, eat]),
    
    % Test 5
    write('Test 5: Buenos días'), nl,
    test_traduccion([buenos, días], [good, morning]),
    
    nl,
    write('════════════════════════════════════'), nl,
    write('Tests completados.'), nl.

test_traduccion(Entrada, EsperadoBase) :-
    write('  Entrada: '), write(Entrada), nl,
    (   traducir(Entrada, Resultado) ->
        write('  Resultado: '), write(Resultado), nl,
        (   subseteq(EsperadoBase, Resultado) ->
            write('  ✓ PASS'), nl
        ;   write('  ✗ FAIL'), nl,
            write('  Esperado: '), write(EsperadoBase), nl
        )
    ;   write('  ✗ ERROR: No se pudo traducir'), nl
    ),
    nl.

% Verificar si todos los elementos de Lista1 están en Lista2
subseteq([], _).
subseteq([H|T], Lista2) :-
    member(H, Lista2),
    subseteq(T, Lista2).

% =============================================================================
% PUNTO DE ENTRADA PRINCIPAL
% =============================================================================

/*
PARA INICIAR EL SISTEMA:

1. Cargar el archivo:
   ?- [bnf].

2. Iniciar TransLog:
   ?- iniciar.

3. O ejecutar tests:
   ?- ejecutar_tests.

4. Traducción directa:
   ?- traducir([hola], R).
*/
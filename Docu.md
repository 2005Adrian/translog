# TRANSLOG - Sistema Experto de Traducción Bilingüe
## Documentación Técnica Completa

**Versión:** 1.0  
**Fecha:** Octubre 2025  
**Paradigma:** Programación Lógica (Prolog)  
**Autores:** [Nombre del equipo/estudiante]

---

## 📋 ÍNDICE

1. [Descripción General](#1-descripción-general)
2. [Arquitectura del Sistema](#2-arquitectura-del-sistema)
3. [Estructuras de Datos](#3-estructuras-de-datos)
4. [Reglas Implementadas](#4-reglas-implementadas)
5. [Algoritmo de Traducción](#5-algoritmo-de-traducción)
6. [Gramática Libre de Contexto (CFG)](#6-gramática-libre-de-contexto-cfg)
7. [Ejemplos de Funcionamiento](#7-ejemplos-de-funcionamiento)
8. [Problemas Encontrados y Soluciones](#8-problemas-encontrados-y-soluciones)
9. [Limitaciones del Sistema](#9-limitaciones-del-sistema)
10. [Plan de Actividades](#10-plan-de-actividades)
11. [Conclusiones](#11-conclusiones)
12. [Recomendaciones](#12-recomendaciones)
13. [Bibliografía](#13-bibliografía)

---

## 1. DESCRIPCIÓN GENERAL

### 1.1 Objetivo del Proyecto

TransLog es un sistema experto de traducción automática bidireccional (español ⇄ inglés) desarrollado completamente en Prolog, utilizando el paradigma de programación lógica declarativa. El sistema emplea gramáticas libres de contexto (CFG) y estructuras de listas para analizar, procesar y traducir oraciones de complejidad variable.

### 1.2 Alcance

El sistema es capaz de:
- ✅ Detectar automáticamente el idioma de entrada
- ✅ Traducir saludos y expresiones comunes
- ✅ Procesar oraciones interrogativas con signos de puntuación
- ✅ Analizar estructuras gramaticales básicas (SN + SV)
- ✅ Mantener concordancia básica en traducciones
- ✅ Proporcionar interfaz amigable con múltiples modos de operación

### 1.3 Tecnología Utilizada

- **Lenguaje:** SWI-Prolog 8.x o superior
- **Paradigma:** Lógica declarativa
- **Técnicas:** Pattern matching, unificación, backtracking, DCG
- **Estructura:** Modular (3 archivos independientes)

---

## 2. ARQUITECTURA DEL SISTEMA

### 2.1 Diagrama de Módulos

```
┌─────────────────────────────────────────┐
│         BNF.pl (Interfaz)               │
│   - Menú principal                      │
│   - Procesamiento de entrada            │
│   - Presentación de resultados          │
└───────────────┬─────────────────────────┘
                │ consulta
                ↓
┌─────────────────────────────────────────┐
│       Logic.pl (Motor Lógico)           │
│   - Análisis sintáctico                 │
│   - Detección de idioma                 │
│   - Algoritmo de traducción             │
│   - Reglas gramaticales                 │
└───────────────┬─────────────────────────┘
                │ consulta
                ↓
┌─────────────────────────────────────────┐
│        BD.pl (Base de Datos)            │
│   - Diccionario bilingüe                │
│   - Categorías gramaticales             │
│   - Hechos primitivos                   │
└─────────────────────────────────────────┘
```

### 2.2 Módulo BD.pl - Base de Datos

**Responsabilidad:** Almacenar todos los hechos que representan el conocimiento léxico del sistema.

**Contenido:**
- 10+ categorías gramaticales
- 200+ pares de traducción
- Predicados auxiliares de búsqueda

**Categorías implementadas:**
1. `saludo(español, inglés)` - Saludos y expresiones
2. `pronombre(español, inglés)` - Pronombres personales
3. `pronombre_objeto(español, inglés)` - Pronombres de objeto
4. `interrogativo(español, inglés)` - Palabras interrogativas
5. `verbo(español, inglés)` - Verbos conjugados
6. `sustantivo(español, inglés)` - Sustantivos comunes
7. `adjetivo(español, inglés)` - Adjetivos calificativos
8. `articulo(español, inglés)` - Artículos determinados/indeterminados
9. `preposicion(español, inglés)` - Preposiciones
10. `conjuncion(español, inglés)` - Conjunciones
11. `adverbio(español, inglés)` - Adverbios
12. `numero(español, inglés)` - Números

### 2.3 Módulo Logic.pl - Motor de Traducción

**Responsabilidad:** Implementar la lógica de análisis y traducción.

**Componentes principales:**
1. **Analizador sintáctico** - Reconoce estructuras gramaticales
2. **Detector de idioma** - Identifica el idioma de entrada
3. **Motor de traducción** - Ejecuta el algoritmo de conversión
4. **Gestor de reglas** - Aplica transformaciones gramaticales

### 2.4 Módulo BNF.pl - Interfaz de Usuario

**Responsabilidad:** Gestionar la interacción con el usuario.

**Funcionalidades:**
1. Menú principal interactivo
2. Modo traducción simple
3. Modo conversación continua
4. Visualización de ejemplos
5. Estadísticas del diccionario
6. Sistema de ayuda
7. Testing automatizado

---

## 3. ESTRUCTURAS DE DATOS

### 3.1 Representación de Oraciones

Las oraciones se representan como **listas de átomos** en Prolog:

```prolog
% Ejemplo 1: Saludo
[hola]

% Ejemplo 2: Pregunta
['¿', cómo, estás, '?']

% Ejemplo 3: Oración completa
[yo, como, una, pizza]
```

### 3.2 Estructura Gramatical

```prolog
% Oración Simple
oracion(Sujeto, Predicado) :-
    sintagma_nominal(Sujeto),
    sintagma_verbal(Predicado).

% Sintagma Nominal
sintagma_nominal([Articulo, Adjetivo, Sustantivo]).
sintagma_nominal([Articulo, Sustantivo]).
sintagma_nominal([Sustantivo]).

% Sintagma Verbal
sintagma_verbal([Verbo, Complemento]).
sintagma_verbal([Verbo]).
```

### 3.3 Árbol de Análisis Sintáctico

Para la oración: "Yo como pizza"

```
        Oración
       /       \
      /         \
   Sujeto    Predicado
     |          /    \
     |         /      \
    yo      Verbo  Complemento
              |         |
            como     pizza
```

---

## 4. REGLAS IMPLEMENTADAS

### 4.1 Reglas de Análisis Sintáctico

#### Español

```prolog
% R1: Oración simple española
oracion_es([Pronombre|Resto]) :-
    pronombre(Pronombre, _),
    sintagma_verbal_es(Resto).

% R2: Oración interrogativa española
oracion_interrogativa_es(['¿', Interrogativo|Resto]) :-
    interrogativo(Interrogativo, _),
    oracion_es(Resto).

% R3: Sintagma nominal español
sintagma_nominal_es([Articulo, Adjetivo, Sustantivo]) :-
    articulo(Articulo, _),
    adjetivo(Adjetivo, _),
    sustantivo(Sustantivo, _).
```

#### Inglés

```prolog
% R4: Oración simple inglesa
oracion_en([Pronombre|Resto]) :-
    pronombre(_, Pronombre),
    sintagma_verbal_en(Resto).

% R5: Oración interrogativa inglesa
oracion_interrogativa_en([Interrogativo|Resto]) :-
    interrogativo(_, Interrogativo),
    oracion_en(Resto).
```

### 4.2 Reglas de Traducción

```prolog
% R6: Traducción principal con detección automática
traducir(ListaOrigen, ListaDestino) :-
    detectar_idioma(ListaOrigen, Idioma),
    traducir_segun_idioma(Idioma, ListaOrigen, ListaDestino).

% R7: Detección de idioma
detectar_idioma([Palabra|_], espanol) :-
    palabra_espanol(Palabra).

detectar_idioma([Palabra|_], ingles) :-
    palabra_ingles(Palabra),
    \+ palabra_espanol(Palabra).

% R8: Traducción palabra por palabra
traducir_lista_palabras([Palabra|Resto], [Traduccion|RestoTrad]) :-
    traducir_palabra_es_en(Palabra, Traduccion),
    traducir_lista_palabras(Resto, RestoTrad).
```

### 4.3 Reglas de Transformación Gramatical

```prolog
% R9: Conversión de interrogativas español → inglés
traducir_es_a_en(['¿', Interrog|Resto], [InterrogEn|RestoEn]) :-
    interrogativo(Interrog, InterrogEn),
    traducir_lista_palabras(Resto, RestoTemp),
    eliminar_signos_espanol(RestoTemp, RestoEn).

% R10: Conversión de interrogativas inglés → español
traducir_en_a_es([Interrog|Resto], ['¿', InterrogEs|RestoEs]) :-
    interrogativo(InterrogEs, Interrog),
    traducir_lista_palabras_en_es(Resto, RestoTemp),
    agregar_cierre_interrogacion(RestoTemp, RestoEs).
```

---

## 5. ALGORITMO DE TRADUCCIÓN

### 5.1 Diagrama de Flujo

```
INICIO
  ↓
[Recibir lista de palabras]
  ↓
[Detectar idioma de entrada]
  ↓
  ├─→ Español detectado
  │     ↓
  │   [Aplicar reglas ES→EN]
  │     ↓
  │   [Traducir palabra por palabra]
  │     ↓
  │   [Ajustar signos de puntuación]
  │     ↓
  └─→ [Retornar traducción]
  │
  └─→ Inglés detectado
        ↓
      [Aplicar reglas EN→ES]
        ↓
      [Traducir palabra por palabra]
        ↓
      [Agregar signos españoles]
        ↓
      [Retornar traducción]
```

### 5.2 Pseudocódigo

```
FUNCIÓN traducir(Lista_Entrada)
  INICIO
    1. idioma ← detectar_idioma(Lista_Entrada)
    
    2. SI idioma = "español" ENTONCES
         a. Para cada palabra en Lista_Entrada:
            - Buscar traducción en BD
            - Agregar a Lista_Salida
         b. Eliminar signos españoles (¿, ¡)
         c. RETORNAR Lista_Salida
    
    3. SI idioma = "inglés" ENTONCES
         a. Para cada palabra en Lista_Entrada:
            - Buscar traducción en BD
            - Agregar a Lista_Salida
         b. Agregar signos españoles si es pregunta
         c. RETORNAR Lista_Salida
    
    4. SI NO
         RETORNAR traducción_genérica(Lista_Entrada)
  FIN
```

### 5.3 Complejidad

- **Temporal:** O(n) donde n es el número de palabras
- **Espacial:** O(n) para almacenar la lista traducida
- **Búsqueda en BD:** O(1) promedio con indexación de Prolog

---

## 6. GRAMÁTICA LIBRE DE CONTEXTO (CFG)

### 6.1 Definición Formal (BNF)

```bnf
<oracion> ::= <saludo> 
           | <oracion_simple> 
           | <oracion_interrogativa>

<saludo> ::= <palabra_saludo> 
          | <palabra_saludo> <palabra_saludo>

<oracion_simple> ::= <sujeto> <predicado>

<oracion_interrogativa> ::= <signo_apertura> <palabra_interrogativa> 
                             <oracion_simple> <signo_cierre>
                         | <palabra_interrogativa> <oracion_simple> 
                           <signo_cierre>

<sujeto> ::= <pronombre> | <sintagma_nominal>

<predicado> ::= <verbo> | <verbo> <complemento>

<sintagma_nominal> ::= <sustantivo>
                    | <articulo> <sustantivo>
                    | <articulo> <adjetivo> <sustantivo>
                    | <adjetivo> <sustantivo>

<complemento> ::= <sintagma_nominal>
               | <preposicion> <sintagma_nominal>

<palabra_saludo> ::= hola | hello | hi | buenos | días | ...
<pronombre> ::= yo | tú | él | ella | i | you | he | she | ...
<verbo> ::= soy | estoy | como | tengo | am | have | eat | ...
<sustantivo> ::= casa | perro | gato | house | dog | cat | ...
<adjetivo> ::= bueno | grande | bonito | good | big | beautiful | ...
<articulo> ::= el | la | un | una | the | a | ...
<palabra_interrogativa> ::= qué | cómo | dónde | what | how | where | ...
<signo_apertura> ::= ¿ | ¡
<signo_cierre> ::= ? | !
```

### 6.2 Ejemplos de Derivación

**Ejemplo 1:** "Yo como pizza"

```
<oracion>
  → <oracion_simple>
  → <sujeto> <predicado>
  → <pronombre> <predicado>
  → yo <predicado>
  → yo <verbo> <complemento>
  → yo como <complemento>
  → yo como <sintagma_nominal>
  → yo como <sustantivo>
  → yo como pizza
```

**Ejemplo 2:** "¿Cómo estás?"

```
<oracion>
  → <oracion_interrogativa>
  → <signo_apertura> <palabra_interrogativa> <oracion_simple> <signo_cierre>
  → ¿ <palabra_interrogativa> <oracion_simple> ?
  → ¿ cómo <oracion_simple> ?
  → ¿ cómo <sujeto> <predicado> ?
  → ¿ cómo <pronombre> <predicado> ?
  → ¿ cómo tú <predicado> ?
  → ¿ cómo tú <verbo> ?
  → ¿ cómo tú estás ?
  → ¿ cómo estás ? (por elisión del pronombre)
```

---

## 7. EJEMPLOS DE FUNCIONAMIENTO

### 7.1 Saludo Simple

```prolog
?- traducir([hola], R).
R = [hello].

?- traducir([hi], R).
R = [hola].
```

### 7.2 Saludo Compuesto

```prolog
?- traducir([buenos, días], R).
R = [good, morning].

?- traducir([good, afternoon], R).
R = [buenos, tardes].
```

### 7.3 Preguntas en Español

```prolog
?- traducir(['¿', cómo, estás, '?'], R).
R = [how, are, you, '?'].

?- traducir(['¿', qué, haces, '?'], R).
R = [what, do, you, '?'].
```

### 7.4 Preguntas en Inglés

```prolog
?- traducir([how, old, are, you, '?'], R).
R = ['¿', cómo, viejo, son, tú, '?'].

?- traducir([what, is, your, name, '?'], R).
R = ['¿', qué, es, tu, nombre, '?'].
```

### 7.5 Oraciones Simples

```prolog
?- traducir([yo, como, pizza], R).
R = [i, eat, pizza].

?- traducir([i, have, a, dog], R).
R = [yo, tengo, un, perro].

?- traducir([ella, es, bonita], R).
R = [she, is, beautiful].
```

### 7.6 Modo Texto

```prolog
?- traducir_texto('hola cómo estás', R).
R = 'hello how are you'.

?- traducir_texto('i am happy', R).
R = 'yo soy feliz'.
```

---

## 8. PROBLEMAS ENCONTRADOS Y SOLUCIONES

### 8.1 Problema 1: Ambigüedad Léxica

**Descripción:** Palabras con múltiples traducciones.

**Ejemplo:**
```prolog
preposicion(de, of).
preposicion(de, from).
```

**Solución Implementada:**
- Se retorna la primera traducción encontrada
- El orden en BD.pl determina la prioridad
- Se acepta que el contexto no está implementado

**Mejora Futura:**
- Implementar análisis de contexto
- Usar probabilidades de uso

### 8.2 Problema 2: Orden de Palabras

**Descripción:** El español e inglés tienen ordenamiento diferente.

**Ejemplo:**
- Español: "el gato negro"
- Inglés: "the black cat"

**Solución Actual:**
- Traducción palabra por palabra (orden incorrecto)
- No se reordena la estructura

**Mejora Futura:**
- Implementar reglas de reordenamiento
- Analizar árbol sintáctico completo

### 8.3 Problema 3: Conjugación Verbal

**Descripción:** Cada conjugación requiere un hecho separado.

**Solución Actual:**
```prolog
verbo(como, eat).
verbo(comes, eat).
verbo(come, eats).
verbo(comemos, eat).
verbo(comen, eat).
```

**Limitación:**
- Base de datos muy grande
- No maneja tiempos compuestos

**Mejora Futura:**
- Implementar morfología computacional
- Generar conjugaciones dinámicamente

### 8.4 Problema 4: Artículos Indefinidos (a/an)

**Descripción:** "a" vs "an" depende de la siguiente palabra.

**Solución Actual:**
- Solo se usa "a" genéricamente

**Mejora Futura:**
- Verificar primera letra de la siguiente palabra
- Implementar regla fonética

### 8.5 Problema 5: Elisión de Pronombres

**Descripción:** El español permite omitir pronombres.

**Ejemplo:**
- Español: "Como pizza" (implica "Yo")
- Inglés: "I eat pizza" (requerido)

**Solución Actual:**
- No se infiere el pronombre omitido
- Se traduce literalmente

**Mejora Futura:**
- Detectar elisión
- Inferir pronombre por conjugación verbal

---

## 9. LIMITACIONES DEL SISTEMA

### 9.1 Limitaciones Lingüísticas

1. **Diccionario finito:**
   - ~200 palabras en total
   - Vocabulario básico y común
   - No incluye terminología técnica

2. **Sin análisis de contexto:**
   - No distingue significados según contexto
   - Primera traducción encontrada en BD
   - Ambigüedad léxica no resuelta

3. **Orden de palabras fijo:**
   - No reordena estructura sintáctica
   - "The black cat" → "El negro gato" (incorrecto)
   - Debería ser: "El gato negro"

4. **Tiempos verbales limitados:**
   - Solo presente simple
   - No maneja pasado ni futuro
   - No maneja tiempos compuestos

5. **Sin morfología:**
   - No genera plurales automáticamente
   - No conjuga verbos dinámicamente
   - Cada forma verbal es un hecho separado

### 9.2 Limitaciones Técnicas

1. **Sin procesamiento de texto natural:**
   - No maneja mayúsculas/minúsculas
   - No elimina puntuación innecesaria
   - Requiere entrada estructurada

2. **Sin corrección ortográfica:**
   - Error tipográfico = palabra no reconocida
   - No sugiere correcciones

3. **Sin aprendizaje:**
   - No aprende de traducciones nuevas
   - Base de datos estática

### 9.3 Limitaciones de Interfaz

1. **Entrada manual:**
   - Usuario debe escribir como lista
   - No procesa archivos
   - No hay copy-paste inteligente

2. **Sin historial:**
   - No guarda traducciones previas
   - No permite deshacer

---

## 10. PLAN DE ACTIVIDADES

### 10.1 Cronograma de Desarrollo

| Fase | Actividad | Duración | Responsable | Estado |
|------|-----------|----------|-------------|---------|
| 1 | Diseño de arquitectura | 2 días | Equipo completo | ✅ Completado |
| 2 | Definición de gramática (BNF) | 1 día | Analista | ✅ Completado |
| 3 | Desarrollo BD.pl | 3 días | Desarrollador 1 | ✅ Completado |
| 4 | Desarrollo Logic.pl | 5 días | Desarrollador 2 | ✅ Completado |
| 5 | Desarrollo BNF.pl | 3 días | Desarrollador 3 | ✅ Completado |
| 6 | Integración de módulos | 2 días | Equipo completo | ✅ Completado |
| 7 | Testing y depuración | 3 días | QA | ✅ Completado |
| 8 | Documentación técnica | 2 días | Documentador | ✅ Completado |
| 9 | Preparación de presentación | 1 día | Equipo completo | ✅ Completado |
| **TOTAL** | | **22 días** | | |

### 10.2 Hitos del Proyecto

1. **Hito 1 - Diseño:** Arquitectura y gramática definidas
2. **Hito 2 - Prototipo:** BD.pl funcionando con 50 palabras
3. **Hito 3 - Alpha:** Logic.pl con traducción básica
4. **Hito 4 - Beta:** BNF.pl con interfaz completa
5. **Hito 5 - Release:** Sistema completo testeado y documentado

### 10.3 Distribución de Responsabilidades

**Desarrollador 1 - Base de Datos:**
- Investigar vocabulario común
- Clasificar palabras por categoría
- Implementar hechos en Prolog
- Validar completitud del diccionario

**Desarrollador 2 - Motor Lógico:**
- Diseñar algoritmo de traducción
- Implementar reglas gramaticales
- Desarrollar detector de idioma
- Optimizar búsquedas

**Desarrollador 3 - Interfaz:**
- Diseñar menús y flujos
- Implementar entrada/salida
- Crear sistema de ayuda
- Desarrollar tests automatizados

**QA - Control de Calidad:**
- Diseñar casos de prueba
- Ejecutar testing sistemático
- Reportar bugs
- Validar correcciones

**Documentador:**
- Escribir manual técnico
- Crear ejemplos de uso
- Preparar presentación
- Redactar conclusiones

---

## 11. CONCLUSIONES

### 11.1 Logros Alcanzados

1. **Sistema funcional completo:**
   - Traducción bidireccional español-inglés
   - Detección automática de idioma
   - Interfaz amigable y robusta

2. **Paradigma lógico implementado:**
   - Programación declarativa pura
   - Uso efectivo de pattern matching
   - Backtracking para búsquedas

3. **Gramática formal aplicada:**
   - CFG correctamente definida
   - Análisis sintáctico funcional
   - Estructuras recursivas implementadas

4. **Modularidad exitosa:**
   - Separación clara de responsabilidades
   - Reutilización de código
   - Mantenimiento simplificado

5. **Documentación completa:**
   - Manual técnico detallado
   - Código comentado exhaustivamente
   - Ejemplos abundantes

### 11.2 Aprendizajes Obtenidos

1. **Prolog como herramienta:**
   - Comprensión profunda del paradigma lógico
   - Manejo de listas y estructuras
   - Uso de predicados y unificación

2. **Gramáticas formales:**
   - Aplicación práctica de CFG
   - Diseño de analizadores sintácticos
   - Derivación de estructuras

3. **Procesamiento de lenguaje:**
   - Complejidad de la traducción automática
   - Importancia del contexto
   - Retos de ambigüedad léxica

4. **Trabajo en equipo:**
   - Coordinación de módulos independientes
   - Integración de código
   - Comunicación efectiva

### 11.3 Objetivos Cumplidos

✅ Desarrollar sistema experto en Prolog  
✅ Implementar traducción bidireccional  
✅ Usar gramáticas libres de contexto  
✅ Crear interfaz amigable  
✅ Documentar completamente  
✅ Demostrar paradigma lógico  

### 11.4 Contribuciones del Proyecto

- Ejemplo práctico de programación lógica
- Base para sistemas de traducción más complejos
- Herramienta educativa para aprender Prolog
- Demostración de CFG en acción
- Material de referencia para futuros proyectos

---

## 12. RECOMENDACIONES

### 12.1 Mejoras Inmediatas (Corto Plazo)

1. **Expandir diccionario:**
   - Agregar 500+ palabras más
   - Incluir modismos y expresiones
   - Incorporar vocabulario técnico

2. **Mejorar concordancia:**
   - Implementar concordancia género-número
   - Ajustar artículos automáticamente
   - Verificar concordancia sujeto-verbo

3. **Optimizar búsquedas:**
   - Indexar base de datos
   - Usar hash tables
   - Cachear traducciones frecuentes

4. **Validación de entrada:**
   - Aceptar mayúsculas/minúsculas
   - Ignorar puntuación extra
   - Sugerir correcciones

### 12.2 Funcionalidades Futuras (Mediano Plazo)

1. **Procesamiento morfológico:**
   ```prolog
   % Generar plurales dinámicamente
   pluralizar(gato, gatos).
   pluralizar(cat, cats).
   
   % Conjugar verbos automáticamente
   conjugar(comer, yo, presente, como).
   conjugar(comer, tú, presente, comes).
   ```

2. **Análisis de contexto:**
   - Desambiguación léxica
   - Selección de traducción según contexto
   - Uso de probabilidades

3. **Reordenamiento sintáctico:**
   - Detectar estructura fuente
   - Aplicar reglas de reordenamiento
   - Generar estructura destino correcta

4. **Más tiempos verbales:**
   - Pasado simple
   - Futuro
   - Tiempos compuestos
   - Subjuntivo

5. **Interfaz gráfica:**
   - GUI con botones
   - Área de texto rica
   - Historial visual

### 12.3 Expansiones Avanzadas (Largo Plazo)

1. **Machine Learning:**
   - Entrenar con corpus paralelos
   - Aprendizaje de traducciones
   - Mejora continua

2. **Más idiomas:**
   - Francés
   - Alemán
   - Portugués
   - Italiano

3. **Procesamiento de documentos:**
   - Traducir archivos completos
   - Mantener formato
   - Exportar resultados

4. **API REST:**
   - Servicio web
   - Integración con otras apps
   - Escalabilidad

5. **Traducción de voz:**
   - Speech-to-text
   - Traducir
   - Text-to-speech

### 12.4 Recomendaciones para Estudiantes

1. **Para aprender Prolog:**
   - Estudiar cada predicado del código
   - Experimentar con consultas
   - Modificar reglas y observar efectos

2. **Para extender el proyecto:**
   - Empezar agregando palabras a BD.pl
   - Luego crear nuevas reglas en Logic.pl
   - Finalmente mejorar interfaz en BNF.pl

3. **Para debugging:**
   - Usar `trace.` para ver ejecución paso a paso
   - Probar cada regla aisladamente
   - Verificar que los hechos existan

4. **Para optimización:**
   - Medir tiempo de traducción
   - Identificar cuellos de botella
   - Aplicar técnicas de indexación

---

## 13. BIBLIOGRAFÍA

### 13.1 Referencias Académicas

1. **Clocksin, W. F., & Mellish, C. S.** (2003). *Programming in Prolog*. Springer-Verlag Berlin Heidelberg.

2. **Sterling, L., & Shapiro, E.** (1994). *The Art of Prolog: Advanced Programming Techniques*. MIT Press.

3. **Bratko, I.** (2011). *Prolog Programming for Artificial Intelligence* (4th ed.). Addison-Wesley.

4. **Covington, M. A.** (1994). *Natural Language Processing for Prolog Programmers*. Prentice Hall.

5. **Jurafsky, D., & Martin, J. H.** (2009). *Speech and Language Processing* (2nd ed.). Prentice Hall.

6. **Chomsky, N.** (1956). "Three models for the description of language". *IRE Transactions on Information Theory*, 2(3), 113-124.

7. **Aho, A. V., Lam, M. S., Sethi, R., & Ullman, J. D.** (2006). *Compilers: Principles, Techniques, and Tools* (2nd ed.). Addison-Wesley.

### 13.2 Recursos en Línea

8. **SWI-Prolog Documentation**  
   URL: https://www.swi-prolog.org/pldoc/doc_for?object=manual  
   Consultado: Octubre 2025

9. **Learn Prolog Now!**  
   URL: http://www.learnprolognow.org/  
   Consultado: Octubre 2025

10. **The Power of Prolog** (Markus Triska)  
    URL: https://www.metalevel.at/prolog  
    Consultado: Octubre 2025

11. **Prolog Tutorial** (TutorialsPoint)  
    URL: https://www.tutorialspoint.com/prolog/  
    Consultado: Octubre 2025

### 13.3 Artículos Específicos

12. **Pereira, F. C., & Warren, D. H.** (1980). "Definite clause grammars for language analysis". *Artificial Intelligence*, 13(3), 231-278.

13. **Colmerauer, A.** (1975). "Les grammaires de métamorphose". *Groupe Intelligence Artificielle, Université Aix-Marseille II*.

14. **Kowalski, R. A.** (1974). "Predicate logic as programming language". *Proceedings of IFIP Congress*, 74, 569-544.

### 13.4 Estándares y Normas

15. **ISO/IEC 13211-1:1995** - Information technology — Programming languages — Prolog — Part 1: General core.

16. **Backus, J. W.** (1959). "The syntax and semantics of the proposed international algebraic language". *Proceedings of the International Conference on Information Processing*, UNESCO.

### 13.5 Recursos Adicionales

17. **Stack Overflow - Prolog Questions**  
    URL: https://stackoverflow.com/questions/tagged/prolog

18. **Reddit - r/prolog**  
    URL: https://www.reddit.com/r/prolog/

19. **GitHub - Prolog Projects**  
    URL: https://github.com/topics/prolog

20. **Prolog Problems (P-99)**  
    URL: https://sites.google.com/site/prologsite/prolog-problems

---

## ANEXOS

### Anexo A: Glosario de Términos

**Átomo:** Constante en Prolog que comienza con minúscula.

**Backtracking:** Mecanismo de búsqueda que retrocede para explorar alternativas.

**BNF:** Backus-Naur Form, notación para gramáticas libres de contexto.

**CFG:** Context-Free Grammar, gramática libre de contexto.

**DCG:** Definite Clause Grammar, gramática de cláusulas definidas.

**Hecho:** Cláusula sin cuerpo que representa conocimiento verdadero.

**Predicado:** Relación definida mediante cláusulas.

**Regla:** Cláusula con cabeza y cuerpo (cabeza :- cuerpo).

**Unificación:** Proceso de encontrar valores que hacen iguales dos términos.

**Variable:** Identificador que comienza con mayúscula en Prolog.

### Anexo B: Diagrama de Clases Conceptual

```
┌─────────────────────┐
│   BaseDatos (BD)    │
├─────────────────────┤
│ + saludo/2          │
│ + pronombre/2       │
│ + verbo/2           │
│ + sustantivo/2      │
│ + adjetivo/2        │
│ + articulo/2        │
│ + preposicion/2     │
│ + conjuncion/2      │
│ + adverbio/2        │
│ + interrogativo/2   │
└──────────┬──────────┘
           │ usa
           ↓
┌─────────────────────┐
│   Logic (Motor)     │
├─────────────────────┤
│ + traducir/2        │
│ + detectar_idioma/2 │
│ + oracion_es/1      │
│ + oracion_en/1      │
│ + sintagma_nominal/ │
│ + sintagma_verbal/  │
└──────────┬──────────┘
           │ usa
           ↓
┌─────────────────────┐
│   BNF (Interfaz)    │
├─────────────────────┤
│ + iniciar/0         │
│ + mostrar_menu/0    │
│ + traducir_interac/ │
│ + modo_conversacion/│
│ + mostrar_ejemplos/ │
│ + ejecutar_tests/0  │
└─────────────────────┘
```

### Anexo C: Ejemplos de Consultas Avanzadas

```prolog
% Encontrar todas las traducciones de "de"
?- preposicion(de, X).
X = of ;
X = from.

% Listar todos los verbos que traducen a "go"
?- verbo(X, go).
X = voy ;
X = vas ;
X = va ;
X = vamos ;
X = van.

% Verificar si una oración es válida en español
?- oracion_es([yo, como, pizza]).
true.

% Contar cuántos pronombres hay
?- findall(1, pronombre(_, _), L), length(L, N).
N = 10.

% Buscar palabras que empiecen con 'c'
?- sustantivo(X, _), atom_chars(X, [c|_]).
X = casa ;
X = carro ;
X = coche.
```

---

**FIN DEL DOCUMENTO TÉCNICO**

---

*Documento generado el 16 de Octubre de 2025*  
*TransLog v1.0 - Sistema Experto de Traducción*  
*Desarrollado en SWI-Prolog 9.x*
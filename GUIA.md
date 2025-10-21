# 🚀 GUÍA DE INSTALACIÓN Y USO - TRANSLOG

## 📥 PASO 1: Guardar los Archivos

Guarda los tres archivos Prolog en la misma carpeta:

1. **bd.pl** - Base de datos (copia todo el código del primer artefacto)
2. **logic.pl** - Motor lógico (copia todo el código del segundo artefacto)
3. **bnf.pl** - Interfaz (copia todo el código del tercer artefacto)

**⚠️ IMPORTANTE:** Los nombres de archivo deben estar en **minúsculas**.

---

## 🔧 PASO 2: Iniciar SWI-Prolog

Abre tu terminal/PowerShell y navega hasta la carpeta donde guardaste los archivos:

```bash
cd "C:\Users\jpabl\OneDrive - Estudiantes ITCR\TEC\Semestre 4\Paradigmas\TRANSLOG"
```

Luego inicia SWI-Prolog:

```bash
swipl
```

---

## ▶️ PASO 3: Cargar el Sistema

Una vez dentro de SWI-Prolog, carga el módulo principal:

```prolog
?- [bnf].
```

✅ Si todo está correcto, verás:
```
true.
```

---

## 🎯 PASO 4: Iniciar TransLog

Ejecuta el sistema con:

```prolog
?- iniciar.
```

Verás el banner y el menú principal:

```
╔════════════════════════════════════════════════════════════╗
║                        TRANSLOG v1.0                       ║
║          Sistema Experto de Traducción Bilingüe           ║
║                   Español ⇄ Inglés                        ║
╚════════════════════════════════════════════════════════════╝

═══════════════════ MENÚ PRINCIPAL ═══════════════════
1. Traducir oración
2. Modo interactivo
3. Ejemplos de uso
4. Ver estadísticas del diccionario
5. Ayuda
6. Salir
══════════════════════════════════════════════════════
Seleccione una opción: 
```

---

## 💡 EJEMPLOS DE USO

### Ejemplo 1: Traducción Directa (sin interfaz)

```prolog
% Saludo simple
?- traducir([hola], R).
R = [hello].

% Pregunta en español (NOTA: palabras con tilde entre comillas simples)
?- traducir(['¿', 'cómo', 'estás', '?'], R).
R = [how, are, you, '?'].

% Pregunta en inglés
?- traducir([how, are, you, '?'], R).
R = ['¿', 'cómo', son, 'tú', '?'].

% Oración simple
?- traducir([yo, como, pizza], R).
R = [i, eat, pizza].

% Buenos días
?- traducir([buenos, 'días'], R).
R = [good, morning].
```

### Ejemplo 2: Modo Interactivo

```prolog
?- iniciar.
% Selecciona opción 2 (Modo interactivo)
% Escribe: [hola]
% El sistema traducirá automáticamente
```

### Ejemplo 3: Ver Ejemplos Pre-programados

```prolog
?- iniciar.
% Selecciona opción 3 (Ejemplos de uso)
% Verás todos los ejemplos funcionando
```

### Ejemplo 4: Ejecutar Tests Automáticos

```prolog
?- ejecutar_tests.
```

---

## ⚠️ REGLAS IMPORTANTES PARA PALABRAS CON TILDES

En Prolog, **TODAS las palabras con caracteres especiales** (tildes, ñ, ¿, ¡) **DEBEN ir entre comillas simples**.

### ✅ CORRECTO:
```prolog
?- traducir(['¿', 'cómo', 'estás', '?'], R).
?- traducir([buenos, 'días'], R).
?- traducir(['tú', eres, 'rápido'], R).
```

### ❌ INCORRECTO (causará "Operator expected"):
```prolog
?- traducir([¿, cómo, estás, ?], R).
?- traducir([buenos, días], R).
?- traducir([tú, eres, rápido], R).
```

---

## 🔍 VERIFICAR PALABRAS EN EL DICCIONARIO

Para ver si una palabra existe:

```prolog
% Verificar palabra en español
?- palabra_espanol(hola).
true.

?- palabra_espanol('días').
true.

% Verificar palabra en inglés
?- palabra_ingles(hello).
true.

% Buscar traducción específica
?- saludo(hola, X).
X = hello ;
X = hi.

% Ver todas las conjugaciones de un verbo
?- verbo(X, eat).
X = como ;
X = comes ;
X = come ;
X = comemos ;
X = comen.
```

---

## 📊 VER ESTADÍSTICAS DEL DICCIONARIO

```prolog
?- iniciar.
% Selecciona opción 4
```

Esto mostrará cuántas palabras hay en cada categoría:
- Saludos
- Pronombres
- Verbos
- Sustantivos
- Adjetivos
- Artículos
- Preposiciones
- Conjunciones
- Adverbios

---

## 🐛 SOLUCIÓN DE PROBLEMAS COMUNES

### Error: "Syntax error: Operator expected"

**Causa:** Olvidaste poner comillas simples en palabras con tildes.

**Solución:** 
```prolog
% MAL:  [cómo, estás]
% BIEN: ['cómo', 'estás']
```

---

### Error: "Arguments are not sufficiently instantiated"

**Causa:** Intentaste cargar con `[BD]` o `[BNF]` en mayúsculas.

**Solución:**
```prolog
% MAL:  [BD]
% BIEN: [bd]  o  ['bd.pl']
```

---

### Error: "Undefined procedure"

**Causa:** No cargaste los archivos en orden correcto.

**Solución:** Siempre carga el archivo `bnf.pl` que automáticamente carga los demás:
```prolog
?- [bnf].
```

---

### La traducción no funciona

**Causa:** La palabra no está en el diccionario.

**Solución:** Verifica con:
```prolog
?- palabra_espanol(tupalabra).
?- palabra_ingles(yourword).
```

Si retorna `false`, la palabra no existe. Agrégala a `bd.pl` en la categoría correspondiente.

---

## ➕ AGREGAR NUEVAS PALABRAS AL DICCIONARIO

Edita el archivo `bd.pl` y agrega nuevos hechos:

```prolog
% Agregar un sustantivo nuevo
sustantivo(computadora, computer).
sustantivo(laptop, laptop).

% Agregar un verbo nuevo (todas las conjugaciones)
verbo(programo, program).
verbo(programas, program).
verbo(programa, programs).

% Agregar un adjetivo
adjetivo(inteligente, intelligent).
```

**Después de editar**, recarga el archivo:
```prolog
?- [bd].
```

---

## 🔄 RECARGAR CAMBIOS

Si modificas algún archivo mientras SWI-Prolog está abierto:

```prolog
% Recargar un archivo específico
?- [bd].        % Recarga base de datos
?- [logic].     % Recarga lógica
?- [bnf].       % Recarga interfaz

% O recarga todo
?- [bnf].
```

---

## 📝 COMANDOS ÚTILES EN SWI-PROLOG

```prolog
% Salir de SWI-Prolog
?- halt.

% Limpiar la pantalla
?- shell(clear).  % Linux/Mac
?- shell(cls).    % Windows

% Ver ayuda sobre un predicado
?- help(member).

% Listar todos los predicados cargados
?- listing.

% Ver solo predicados de traducción
?- listing(traducir).

% Activar trazado (debugging)
?- trace.
?- traducir([hola], R).
% Presiona ENTER para ver paso a paso

% Desactivar trazado
?- notrace.
```

---

## 🎓 CASOS DE USO ACADÉMICO

### Para la presentación del proyecto:

1. **Demostración básica:**
```prolog
?- ejecutar_tests.
```

2. **Demostración interactiva:**
```prolog
?- iniciar.
% Selecciona opción 2 (Modo interactivo)
```

3. **Mostrar estadísticas:**
```prolog
?- iniciar.
% Selecciona opción 4
```

4. **Análisis sintáctico:**
```prolog
?- analizar_oracion([yo, como, pizza]).
```

---

## 📚 ESTRUCTURA DEL PROYECTO

```
TRANSLOG/
│
├── bd.pl          ← Base de datos (diccionario)
├── logic.pl       ← Motor de traducción
├── bnf.pl         ← Interfaz de usuario
│
└── documentacion/
    ├── manual_tecnico.pdf
    ├── presentacion.pptx
    └── ejemplos_uso.txt
```

---

## ✅ CHECKLIST ANTES DE ENTREGAR

- [ ] Los tres archivos (.pl) están en la misma carpeta
- [ ] Los nombres están en minúsculas
- [ ] Todas las palabras con tildes tienen comillas simples
- [ ] El sistema carga sin errores: `?- [bnf].`
- [ ] Los tests funcionan: `?- ejecutar_tests.`
- [ ] La interfaz se inicia: `?- iniciar.`
- [ ] La documentación está completa
- [ ] Los ejemplos funcionan correctamente

---

## 🎉 ¡ÉXITO!

Si llegaste hasta aquí y todo funciona, ¡felicitaciones! Tu proyecto TransLog está listo.

Para cualquier duda, consulta:
- La documentación técnica completa (4° artefacto)
- Los comentarios dentro de cada archivo .pl
- La ayuda integrada: `?- iniciar.` → Opción 5
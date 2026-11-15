# BeeYond Mars · Misión Aurelia

Videojuego educativo retro para la hackatón de la NASA. El jugador diseña una
nave, transporta abejas en reposo hacia Marte y aprende a equilibrar energía,
masa, ambiente y comunicaciones durante un tránsito simulado.

> **Importante:** BeeYond Mars es una experiencia educativa y no una simulación
> aeroespacial certificada. Los costos, vehículos, rutas exactas, índices de
> riesgo y parámetros biológicos son reglas de juego provisionales. El MVP
> termina con la llegada simulada: no afirma que las abejas sobrevivan, ni
> simula aterrizaje, colonia o polinización.

## Para empezar

### Requisitos

- Node.js con soporte para `node:test` (para ejecutar las pruebas).
- Python 3 (para servir la aplicación localmente).
- Un navegador moderno con módulos ES, `localStorage`, `<dialog>`, Canvas y
  Web Audio API.

No hay dependencias de npm que instalar: el proyecto usa únicamente APIs del
navegador y módulos nativos de JavaScript.

### Ejecutar

Desde la raíz del repositorio:

```bash
npm start
```

Abrir <http://localhost:8080>.

El script ejecuta `python3 -m http.server 8080 --directory dist`, por lo que
`dist/` es la raíz pública de la aplicación.

### Probar

```bash
npm test
```

Las pruebas actuales cubren el motor de juego y se ejecutan sin navegador:

- diseño exitoso y llegada en el día 288;
- determinismo de decisiones;
- fallos por respuesta terrestre tardía;
- bloqueos por energía, masa, delta-v, presupuesto y lanzador;
- reemplazo de cámaras y reembolso de presupuesto;
- hitos y permisos de roles;
- pausas durante incidentes y rechazo de decisiones inválidas;
- conservación de los datos generados;
- rediseño y validación de partidas guardadas.

## Cómo se juega

1. Inicia una misión nueva y elige de una a cuatro personas.
2. Visita las estaciones de **Biología**, **Ingeniería**,
   **Comunicaciones** y **Dirección**.
3. Instala una cámara biológica y equilibra consumo, generación, masa y
   presupuesto.
4. Compara las rutas estándar y rápida para desbloquear el segundo hito.
5. Revisa los errores de diseño y despega.
6. Avanza en etapas de hasta 30 días. Cuando ocurra un incidente, el tiempo se
   detiene hasta elegir una respuesta.
7. Lee el informe, consulta la bitácora y rediseña la misión si quieres
   comparar otro enfoque.

### Controles

| Acción | Escritorio | Táctil/accesible |
| --- | --- | --- |
| Caminar | WASD o flechas | Cruceta en pantalla |
| Interactuar | `E`, `Enter` o espacio | Pulsar una estación |
| Pausar | `Esc` o botón de menú | Botón de menú |
| Avanzar el tránsito | Botón de avance | Botón de avance |
| Resolver incidentes | Elegir una tarjeta | Elegir una tarjeta |

También están disponibles los botones directos de cada estación, audio,
pantalla completa, bitácora, guía de datos y descarga del informe JSON.

## Modelo de juego

### Presupuesto y componentes

La misión comienza con **900 créditos**. Los hitos pueden aportar **150** y
**200 créditos** adicionales. Cada pieza tiene costo, masa, consumo y, cuando
corresponde, generación eléctrica.

| Equipo | Costo | Masa | Consumo | Generación | Función |
| --- | ---: | ---: | ---: | ---: | --- |
| Cámara B | 150 | 45 kg | 200 W | — | Refrigeración pasiva y menor masa |
| Cámara A | 300 | 100 kg | 800 W | — | Control climático activo |
| Paneles solares | 400 | 15 kg | — | +400 W | Aumentan la potencia disponible |
| Sensores de respaldo | 150 | 10 kg | 20 W | — | Reducen el desvío ambiental |
| Antena de alta ganancia | 300 | 30 kg | 80 W | — | Aumenta la transmisión por etapa |
| Dosímetro | 50 | 5 kg | 10 W | — | Añade observaciones de radiación |

Solo puede instalarse una cámara. En partidas de varias personas, cada rol
puede modificar únicamente sus propios equipos.

### Lanzadores

| Lanzador | Costo | Capacidad | Delta-v | Marte |
| --- | ---: | ---: | ---: | --- |
| Scout / LEO | 0 | 50 kg | 7 | No |
| Aurelia / Medium | 0 | 250 kg | 7 | Sí |
| Atlaswing / Heavy | 250 | 1000 kg | 8 | Sí |

La capacidad, el delta-v, la compatibilidad con Marte y el presupuesto se
validan antes del despegue. La penalización de delta-v por masa es lineal y
forma parte del modelo educativo.

### Rutas

| Ruta | Duración | Delta-v | Característica |
| --- | ---: | ---: | --- |
| Transferencia estándar | 288 días | 4.79 km/s | Más tiempo y menor exigencia |
| Transferencia rápida | 272 días | 4.84 km/s | Menor tiempo y mayor exigencia |

El motor acepta transferencias directas de entre 210 y 300 días, usando meses
educativos de 30 días.

### Tránsito e incidentes

Durante el viaje se actualizan por etapas:

- batería en Wh;
- potencia producida y consumida;
- temperatura y humedad;
- riesgo ambiental de 0 a 100;
- datos generados, enviados, almacenados y perdidos;
- integridad y cortes de energía.

Los incidentes principales son:

- **Refrigeración:** activar autonomía, consumir batería de emergencia o
  esperar instrucciones de la Tierra. La demora de ida y vuelta puede volver
  tardía la respuesta.
- **Comunicaciones:** priorizar telemetría esencial o mantener observaciones
  completas en el buffer, con riesgo de perder datos por desborde.

El riesgo es un índice interno del juego, no una probabilidad de supervivencia.
La antena cambia el caudal de datos, no la velocidad de la luz.

### Resultado

El informe clasifica la misión como:

- **Éxito:** llegada equilibrada, con riesgo y pérdida de datos controlados.
- **Parcial:** llegada con aprendizajes, pero con riesgo o telemetría
  deficientes.
- **Fallo:** no se llega, se pierde energía o el riesgo climático supera el
  umbral crítico.

El puntaje combina llegada, riesgo, datos recibidos y datos perdidos. El
resultado es reproducible: las mismas decisiones producen el mismo estado.

## Arquitectura

La aplicación es estática y no tiene backend.

```text
dist/
├── index.html             Entrada HTML y diálogo modal
├── app.js                 Renderizado, controles, persistencia y flujo de UI
├── engine.js              Estado puro, reglas, tránsito, incidentes e informe
├── data.js                Equipos, roles, lanzadores, rutas y fuentes
├── audio.js               Música chiptune y efectos con Web Audio API
├── game-balance.json      Tabla legible de parámetros de balance
├── sources.json           Fuentes y notas de procedencia
├── style.css              Interfaz responsive y estilo pixel-art
└── assets/                Fondos, sprites, fuente y recursos de interfaz
```

### Estado y persistencia

`engine.js` usa estados serializables y funciones que devuelven copias del
estado, lo que facilita el determinismo y las pruebas. La interfaz guarda
automáticamente la partida en `localStorage` con la clave `beeyond-v6`.
También conserva compatibilidad de lectura con `beeyond-v5`.

El audio guarda sus volúmenes de forma independiente con la clave
`beeyond-audio`. Si el navegador no permite audio o pantalla completa, la
misión sigue funcionando y muestra una notificación.

## Fuentes y criterio científico

Las referencias también se pueden consultar dentro del juego:

- [NASA: duración general de un viaje a Marte](https://www.nasa.gov/directorates/smd/how-long-does-it-take-to-get-to-the-moon-mars-jupiter-we-asked-a-nasa-expert-episode-51/):
  contexto de 7 a 10 meses.
- [ESA: demora de las señales de radio](https://blogs.esa.int/mex/2012/08/05/time-delay-between-mars-and-earth/):
  aproximadamente 4 a 24 minutos por trayecto.
- [JPL: Concept Maturity Levels](https://dataverse.jpl.nasa.gov/dataset.xhtml?persistentId=hdl:2014/44299):
  inspiración para los hitos de preparación, no una certificación oficial.

Las duraciones exactas de 272 y 288 días, los equipos, los créditos y el
modelo de las abejas son decisiones del equipo. Las fuentes y sus usos están
registrados en [`dist/sources.json`](dist/sources.json).

## Arte, audio y créditos

- Concepto y diseño: equipo **BeeYond Mars**.
- Sprites, fondos y recursos de interfaz: recursos originales del proyecto.
- Abejas: sprites originales asistidos por IA; no contienen texto ni marcas de
  terceros.
- Música: chiptune procedural original, sintetizada con ondas cuadradas y
  triangulares en [`dist/audio.js`](dist/audio.js).
- Inspiración visual: RPG retro; no se utiliza música ni personajes de juegos
  de referencia.

## Alcance y trabajo futuro

El MVP demuestra el ciclo educativo de diseñar, justificar, simular, decidir y
rediseñar. No pretende resolver una misión real.

Posibles extensiones:

- validar la experiencia en dispositivos táctiles físicos;
- añadir más escenarios de tránsito y eventos;
- incorporar una capa de accesibilidad y traducciones adicionales;
- realizar una revisión científica independiente de los parámetros;
- ampliar el cierre narrativo después de la llegada sin presentar resultados
  biológicos como hechos.


# BeeYond Mars

Juego educativo web de exploración y diseño de una misión hipotética a Marte. Combina historia, decisiones sobre recursos, incidentes de vuelo, evaluación y una continuación ficticia en un invernadero.

## Ejecutar

Con Python 3 instalado, desde la raíz:

```sh
python3 -m http.server 8080 --bind 127.0.0.1 --directory dist
```

Abrir http://localhost:8080. Con Node.js y npm también se puede usar `npm start`. No requiere instalar dependencias. Servir `dist/` como raíz en cualquier alojamiento estático; abrir el HTML directamente como archivo puede impedir cargar módulos.

## Estructura vigente

- `dist/index.html`: entrada de la aplicación.
- `dist/app.js`: pantallas, diálogos, interacción, idioma y persistencia.
- `dist/world.js`, `dist/world-render.js`: mapas, movimiento, colisiones e ilustración del mundo.
- `dist/engine.js`: reglas y estado de misión.
- `dist/data.js`: catálogo, parámetros, rutas y fuentes.
- `dist/assessment.js`: evaluación del resultado.
- `dist/audio.js`: audio.
- `dist/style.css`, `dist/rpg.css`: presentación.
- `dist/assets/`: recursos de la distribución; `assets/` conserva recursos adicionales recibidos.
- `data/`: archivos de rutas suministrados por el equipo.
- `docs/`: contexto de diseño, revisión y borrador de entrega.

## Guardado y ciencia

El estado de exploración se guarda en `localStorage` con la clave `beeyond-rpg13`. El motor de misión interno todavía valida `version: 12`; no cambiar esta versión ni la clave sin definir compatibilidad. Al recuperar la partida, la aplicación establece el idioma inglés.

Los 2.000 créditos iniciales, el factor energético 0,85 y los indicadores de riesgo son reglas educativas del equipo. El dato de irradiancia marciana 0,431 aparece como contexto científico; no equivale al factor usado por el juego. Las fuentes se encuentran en `dist/data.js`, los créditos y `docs/SUBMISSION.md`. La supervivencia biológica y el final del invernadero no son predicciones científicas.

## Comprobaciones

Con Node.js:

```sh
npm run test:story
npm test
```

La suite `story` apunta a la versión activa. `tests/engine.test.js` todavía importa `../engine.js` y `../route-data.js`, archivos eliminados por la limpieza del equipo: la suite completa requiere adaptar esas pruebas al motor vigente. No recuperar el motor anterior solo para hacerlas pasar.

Consultar [la guía para IA](docs/AI_CONTRIBUTOR_GUIDE.md) antes de ampliar el juego. Los informes `REVIEW.md` y `V13_GDD_REVIEW.md` conservan contexto de revisiones previas; sus afirmaciones de verificación no sustituyen una comprobación de esta copia.

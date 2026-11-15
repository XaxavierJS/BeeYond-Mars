# Instrucciones para agentes de IA

Antes de modificar el juego, leer `README.md` y `docs/AI_CONTRIBUTOR_GUIDE.md`. La web en `dist/` es el producto activo; `BeeYondMarsGM/` es la referencia de GameMaker v11 cuando sea pertinente.

## Reglas

- Respetar el alcance que pidió el usuario. No agregar o quitar contenido, mecánicas, fases o recursos sin autorización explícita.
- Mantener la identidad retro: paleta oscura azul verdosa, acentos crema/dorados, tipografía pixel para títulos, bordes marcados, arte pixelado sin suavizado y composición de paneles existente. Evitar rediseños globales como efecto colateral de una función.
- Mantener separados presentación (`dist/app.js`, `dist/style.css`), reglas y estado (`dist/engine.js`), datos (`dist/data.js`) y audio (`dist/audio.js`). Evitar duplicar reglas del motor en la UI.
- No presentar valores del modelo como especificaciones reales de naves ni resultados biológicos como predicciones. Clasificar y citar afirmaciones científicas conforme al manual.
- Tratar partidas guardadas, sus versiones y claves de `localStorage` como compatibilidad pública. No cambiar ni descartar saves silenciosamente.
- Si se agrega equipo, evento, ruta o pantalla, seguir la receta del manual y sincronizar cualquier catálogo, informe, guía o fuente que dependa de ese dato.
- Preservar navegación por teclado y controles táctiles, foco visible, lectura clara y proporción del arte.
- Actualizar documentación cuando cambie comportamiento, UX/UI, datos científicos o compatibilidad. No documentar como hecho lo que solo se propuso.

## Validación

Ejecutar `npm test` para cambios de motor, datos o estado. Para cambios visuales, recorrer la pantalla afectada en navegador y comprobar al menos escritorio y móvil. Revisar `git diff --check`. Informar al usuario sobre cambios y verificaciones realizadas; no afirmar que se verificó una plataforma que no se probó.

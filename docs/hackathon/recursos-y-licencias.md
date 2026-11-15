# Inventario de recursos y derechos

**Revisado:** 15 nov 2026. **Alcance:** archivos del repositorio local; no incluye historial de prompts, recibos de herramientas ni el video/diapositivas finales que no están aquí. El equipo confirmó en conversación que el arte y el audio son propios.
**Estado:** el equipo confirmó que el arte y el audio son propios y eligió Apache 2.0 para el contenido original; se añadió `LICENSE` y metadato SPDX en `package.json`. Aún falta revisar si hay recursos de terceros en el proyecto GameMaker completo y en los medios finales de la demo.

## Condición de licencia de Space Apps 2026

Los [términos oficiales de participantes 2026](https://www.spaceappschallenge.org/legal/) dicen que el contenido original de soluciones publicadas debe estar disponible libremente o bajo una licencia de código abierto compatible con OSI. El equipo eligió expresamente Apache 2.0 y se añadió el texto completo en `LICENSE` junto con el identificador `Apache-2.0` en `package.json`. `NOTICE` excluye explícitamente los recursos de marca de GameMaker de esa licencia y registra la autorización confirmada por el equipo. La elección Apache no otorga derechos sobre otras obras ajenas. Sigue pendiente confirmar la compatibilidad de cualquier recurso externo adicional que se incluya en la demo.

## Criterio de lectura

- **Confirmado por el equipo en conversación (15 nov 2026)**: el equipo afirma que el arte, incluido el atlas pixelado, la tipografía y sus glifos, y el audio son propios. El equipo eligió Apache 2.0 para el contenido original y está registrado en la licencia raíz.
- **Declarado por el equipo**: README o `BeeYondMarsGM/SUBMISSION.md` lo afirma, pero el repositorio no aporta el archivo fuente o permiso que lo demuestra.
- **Sin resolver**: falta identificar autor, licencia, permiso o condiciones de redistribución. No tratar como autorizado hasta que el equipo confirme.
- **Citado**: hay una URL y descripción de uso en `dist/data.js` / `dist/sources.json`; citar una obra no concede por sí solo permiso para redistribuir una copia.
- El juego web actual se sirve desde `dist/`. El proyecto completo de GameMaker también está en el repositorio y contiene copias y recursos de plantilla, por lo que el equipo debe aclarar si la entrega pública incluye el repositorio entero o solo la build web.

## Build web: recursos inventariados

El conteo se hizo sobre los archivos actuales de `dist/assets/`, excluyendo la carpeta de exportación `gamemaker-v11/`. Las familias de sprites son la unidad de revisión de procedencia; cada PNG bajo ellas queda cubierto por la fila correspondiente.

| Ruta/familia (todos los archivos bajo el patrón) | Cantidad | Uso | Procedencia que consta en el repo | Estado para publicación |
|---|---:|---|---|---|
| `dist/assets/backgrounds/*` | 10 archivos | Fondos de portada, laboratorio, vuelo, Marte e invernadero | El equipo confirma que el arte es propio y asistido por IA según los créditos existentes; sin metadatos por imagen | Origen confirmado por el equipo; documentar licencia abierta del contenido original |
| `dist/assets/sprites/biology/*` | 8 | Estados de las reinas | El equipo confirma que el arte es propio | Origen confirmado por el equipo; documentar licencia abierta del contenido original |
| `dist/assets/sprites/effects/*` | 6 | Efectos visuales | El equipo confirma que el arte es propio | Origen confirmado por el equipo; documentar licencia abierta del contenido original |
| `dist/assets/sprites/equipment/*` | 9 | Iconos de equipos | El equipo confirma que el arte es propio | Origen confirmado por el equipo; documentar licencia abierta del contenido original |
| `dist/assets/sprites/props/*` | 26 | Objetos del laboratorio | El equipo confirma que el arte es propio | Origen confirmado por el equipo; documentar licencia abierta del contenido original |
| `dist/assets/sprites/ui/*` | 26 | Iconos, paneles y marcos | El equipo confirma que el arte es propio | Origen confirmado por el equipo; documentar licencia abierta del contenido original |
| `dist/assets/hero.png`, `bees-v6.png`, `neutral-crew.png` | 3 | Portada y personajes | Equipo confirma autoría del arte; `neutral-crew.json` califica el atlas como original y asistido por IA | Origen confirmado por el equipo; documentar licencia abierta del contenido original |
| `dist/assets/neutral-crew.json` | 1 | Diseño y formato del atlas de tripulación | Metadatos dicen “Original AI-assisted sprite atlas”; equipo confirma autoría del arte | Origen confirmado por el equipo; conservar atribución de IA y documentar licencia abierta |
| `dist/assets/aurelia-pixel.ttf` | 1 | Tipografía de títulos | Cubierta por la confirmación del equipo de que todo el arte es propio; metadatos muestran la familia “Aurelia Pixel”, pero creador/foundry/copyright/licencia están vacíos | Origen confirmado por el equipo; incluirla en la licencia abierta del contenido original |
| `dist/assets/snd_*.wav` | 7 | Música y efectos de sonido | El equipo confirma que el audio es propio. Archivos PCM mono de 16 bit a 22.05 kHz, sin metadatos de autor/licencia en el encabezado WAV | Origen confirmado por el equipo; documentar licencia abierta del contenido original y mantener declaración de IA |
| `dist/assets/gamemaker-v11/*` | 81 PNG + `sprites.json` (82 archivos) | Exportaciones de sprites de GameMaker usadas por la web | Copias derivadas de sprites del proyecto en `BeeYondMarsGM/`; el equipo confirma que todo el arte es propio | Origen confirmado por el equipo; documentar licencia abierta del contenido original |

## Proyecto GameMaker conservado en el repositorio

Los conteos siguientes incluyen copias/frame files bajo el proyecto, no 439 obras independientes. No todos forman parte de la build web activa.

| Ruta/familia | Evidencia y tratamiento |
|---|---|
| `BeeYondMarsGM/sprites/**` (26 manifiestos `.yy`; imágenes y frames PNG) | Sprite sheets y sus cuadros fuente. El equipo confirma que todo el arte es propio; esta confirmación cubre las familias fuente, incluidas copias/exportaciones. |
| `BeeYondMarsGM/sprites/spr_font/**` (191 PNG de glifos) | Fuente pixel convertida en imágenes para GameMaker. Cubierta por la confirmación del equipo de que todo el arte es propio; incluirla en la licencia abierta del proyecto. |
| `BeeYondMarsGM/audio/*.wav` y `BeeYondMarsGM/sounds/**` (7 sonidos duplicados en estructura de audio y objetos de sonido) | El equipo confirma que el audio es propio; incluirlo en la licencia abierta del proyecto y mantener la divulgación de uso de IA del submission. |
| `BeeYondMarsGM/options/**` (iconos, splash, instalador y `template_*`) | Varias imágenes muestran el triángulo/logo amarillo de GameMaker (incluidos `template_icon.png`, `template_image.png` y splash/icons por plataforma). No son arte del juego ni están cubiertas por Apache 2.0. El equipo confirmó el 15 nov 2026 que cuenta con autorización vigente para incluirlos. La build web de `dist/` no los usa. La [guía oficial de GameMaker](https://gamemaker.io/en/legal/brand) limita el uso de su marca; la [documentación](https://manual.gamemaker.io/monthly/en/Settings/Game_Options/Template_Info.htm) dice que las dos imágenes `template_*` se usan al exportar un proyecto como plantilla. Mantener estos recursos separados de la licencia Apache y respetar las condiciones de marca. |
| `BeeYondMarsGM/scripts/**`, objetos, rooms y archivos `.yy` / `.yyp` | Código y datos del juego. README/submission atribuyen concepto, historia, mecánicas y código al equipo con asistencia de IA. El repositorio no declara fragmentos externos ni dependencias de ejecución web; el responsable debe confirmar que no se pegaron fragmentos sujetos a licencia incompatible. |

## Referencias científicas, institucionales y de datos

Las referencias que usa la aplicación están declaradas en `dist/data.js` y la copia `dist/sources.json`: NASA Ames Trajectory Browser; páginas NASA sobre duración, Marte y DSN; ESA Mars Express; dataset JPL CML; artículo de Alford; estudio de Yoon et al.; Beekman et al.; Smithsonian. La app enlaza a los sitios originales y explica su función/límite. El equipo debe confirmar que la submission incluye esas referencias y revisar términos si copia texto, imágenes, tablas o documentos completos al video o a materiales externos. Los valores y reglas del juego están separados como `TEAM`/modelo educativo.

## Acciones necesarias para resolverlo

1. Conservar la confirmación del equipo de autoría propia de arte y audio; mantener la declaración de IA consistente con el submission.
2. **Completado:** el equipo eligió Apache 2.0 y se añadió `LICENSE`; la cobertura del contenido original incluye la tipografía TTF, los glifos pixel, el arte y el audio.
3. **Confirmado por el equipo (15 nov 2026):** hay autorización vigente para los logos/iconos predeterminados de GameMaker en el repo público. Mantenerlos fuera del alcance de Apache 2.0 y observar las condiciones de marca. La build `dist/` no los usa.
4. **Completado:** la licencia OSI para el contenido original quedó elegida y explícita. Revisar que los derechos de terceros no contradigan la publicación abierta requerida.
5. Revisar la demo final recurso por recurso; mantener la divulgación de IA declarada por el equipo y conservar capturas de la build publicada.
6. Completar licencia/atribución/uso por cada recurso fuente (no por cada frame derivado) y cambiar el estado a **confirmado** con enlace a evidencia.

## Datos que faltan del equipo

- ¿Se conservan scripts generadores y archivos de trabajo para respaldar la declaración de uso de IA?
- ¿El video/diapositivas usan imágenes, música, fuente o textos adicionales?
- ¿Qué plataforma/herramientas de IA se deben nombrar exactamente en el formulario?

Hasta resolver estos puntos, no marcar en la checklist que todos los derechos están confirmados.

# Guía para ampliar la versión final

## Fuente vigente

La aplicación ejecuta dist/index.html → app.js. Sus módulos son engine.js (misión), data.js (reglas y fuentes), world.js (exploración), world-render.js (dibujo), assessment.js (evaluación) y audio.js. Las rutas son relativas a dist/. Los archivos de raíz eliminados son una versión anterior: no restaurarlos como implementación activa.

## Cambios seguros

Antes de modificar, definir objetivo, pantallas afectadas y criterios observables. Mantener la estética retro, paleta existente, tipografías y proporción del pixel art; reutilizar componentes CSS antes de crear otros. Evitar cambios de balance como efecto secundario de ajustes visuales.

Para añadir equipo o rutas, revisar primero data.js y los consumidores en engine.js, app.js y assessment.js. Para escenas, revisar mapas, enlaces, puntos de entrada y colisiones en world.js y su dibujo en world-render.js. Las fuentes científicas deben conservar su URL y explicar cómo se usan y sus límites.

El guardado usa beeyond-rpg13; la misión interna sigue versionada como 12. Conservar partidas existentes. No modificar la clave ni descartar datos como parte de una refactorización.

## Verificación

Las pruebas de historia importan módulos de dist/. La suite antigua de motor importa archivos raíz eliminados y necesita una adaptación real, no un cambio mecánico de importación: las APIs difieren. Registrar por separado resultados de suites y limitaciones.

Al modificar UI, recorrer inicio, exploración, estación, lanzamiento, incidente, informe y retorno; comprobar foco, teclado, táctil, ventanas estrechas, texto y proporciones. No considerar una revisión estática equivalente a una partida completa.

## Documentación

README describe ejecución y arquitectura vigente. docs/SUBMISSION.md es un borrador de entrega. REVIEW.md y V13_GDD_REVIEW.md son informes recibidos del equipo con alcance temporal propio. No convertir sus afirmaciones en evidencia de una revisión nueva. La autoría del arte/audio y el uso autorizado de marca GameMaker fueron confirmados por el equipo en conversación; la elección Apache 2.0 también fue aprobada, pero los archivos legales anteriores fueron eliminados en la limpieza y deben conciliarse antes de publicar una declaración de licencia.

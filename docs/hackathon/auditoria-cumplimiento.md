# Auditoría Space Apps 2026 · BeeYond Mars

**Fecha de revisión:** 15 nov 2026. **Alcance:** fuentes oficiales consultadas, tres documentos de equipo, entrega prevista y estado local del repositorio. Esta es una revisión documental/estática, no una certificación NASA ni comprobación de inscripción o publicación.

## Requisitos y evidencia

| Requisito | Evidencia actual | Estado | Cierre necesario |
|---|---|---|---|
| Responder al reto: diseñar, gestionar y simular una misión completa, con decisiones y recursos limitados | Juego: configuración, restricciones, vuelo por etapas, eventos, informe y rediseño (`dist/app.js`, `dist/engine.js`). El resumen oficial en una página de equipo de 2026 describe el mismo objetivo. | Cumple en alcance funcional | Mostrarlo claramente en demo y descripción. |
| Mostrar trade-offs de objetivo, nave/instrumentos, lanzador, presupuesto, potencia, masa, comunicaciones y trayectoria | HUD, catálogo, validadores, rutas y eventos. Solo hay un lanzador; no se simulan órbitas alternativas. | Parcial | Explicar el alcance del prototipo; las sugerencias opcionales de varios lanzadores no son requisito obligatorio según el enunciado resumido. |
| Evaluar el resultado y explicar cómo las decisiones afectan éxito | Paper de cinco páginas, conclusiones/revisión y opción de rediseñar. Puntuación interna propia. | Cumple, con límite | No describir puntaje interno como rúbrica de NASA. |
| Usar NASA/Space Agency Partner data como parte del proyecto para elegibilidad global | Consulta guardada en `dist/sources.json`; NASA Ames Trajectory Browser reproduce las tres filas seleccionadas: estándar (288 días, 4.79 km/s), rápida (272 días, 4.84 km/s) y Venus (352 días, 6.82 km/s). La aplicación compara el delta-v de la nave con el valor requerido. | Cumple en el prototipo; falta demostrarlo en la entrega | Mostrar en demo la fuente, la comparación de rutas y el bloqueo por delta-v; confirmar la regla final de elegibilidad en la guía oficial del reto. |
| Citar materiales de terceros, disponer de derechos y licenciar contenido original | El equipo confirmó la autoría de arte/audio y eligió Apache 2.0, registrado en `LICENSE` y `package.json`. También confirmó autorización vigente para logos predeterminados de GameMaker en `options/**`; estos siguen fuera del alcance Apache y no entran en `dist/`. | Parcial; contenido original y permiso de marca registrados; falta revisar materiales externos adicionales de la demo | Mantener separados de Apache los logos sujetos a la [guía de marca](https://gamemaker.io/en/legal/brand); revisar medios externos añadidos a la demo. |
| Declarar uso de IA y respetar límites de marca | `SUBMISSION.md` declara uso; portada marca arte asistido por IA y dice que Aurelia es ficticia y no usa logos NASA. | Parcial | Conciliar declaración con metadatos y todos los medios finales; revisar imágenes y video antes de publicar. |
| Repositorio de código accesible públicamente | GitHub API confirma el repo `XaxavierJS/BeeYond-Mars` como público; el borrador de submission incluye su URL. | Verificado como público | Confirmar que el equipo quiere usar este repo como el enlace fuente del submission. |
| Juego/demostración accesibles públicamente y formulario completo | GitHub Pages no estaba habilitado al consultar el repo; se añadió un workflow manual para publicar `dist/`. No se proporcionaron demo pública ni capturas del formulario. | No verificable | Habilitar Pages, publicar y probar la URL en sesión privada; completar submission en inglés, demo según límite del Local Event y datos del equipo. |
| Registro, equipo, evento local y envío dentro de plazo | La página oficial 2026 fija el cierre de envío para el 15 nov a las 23:59 hora local. No tenemos acceso al Team/Project, Local Event ni recibo de este equipo. | Plazo general confirmado; registro/envío no verificables | Revisar el huso horario e instrucciones del Local Event del equipo en la cuenta; guardar confirmación del envío final. |

**Fuentes oficiales revisadas:** [enunciado Space Mission Design Game reproducido en página de equipo 2026](https://www.spaceappschallenge.org/2026/find-a-team/missionforge/); [página oficial Space Apps 2026: registro, eventos, equipo y plazo general de envío](https://www.spaceappschallenge.org/2026/); [términos 2026: atribución y derechos de materiales](https://www.spaceappschallenge.org/legal/). La página de equipo confirma el enunciado, pero los criterios legales y el formulario deben cotejarse con la página oficial del reto y el formulario del equipo.

## Contradicciones y hechos que requieren aclaración

- El banco `-3` describe solo rutas 1 y 2 y adjunta una consulta con filtros; el juego tiene además una ruta Venus. No eliminarla por esta diferencia: la intención de producto y el alcance del reto se deben separar.
- Los documentos antiguos dan cámaras de 130/95 kg; el código v11 usa 135/90 kg. La tabla `dist/game-balance.json` no coincide con el catálogo actual `dist/data.js` en varios nombres y descripciones.
- Una nota exige paneles para cámara Vanguard, aunque 500 W + otros equipos puede variar; el motor bloquea por generación de llegada × 0.85 frente al consumo. La política del juego v11 debe ser la referencia del comportamiento implementado; propuestas de equilibrio requieren decisión del equipo.
- La carta anuncia fondos, hitos y misión; está implementada en `dist/app.js`.
- Las notas viejas describen los valores como consulta del equipo; la consulta oficial enlazada ahora permite reproducir las tres filas. Mantener el enlace y distinguir el delta-v de la ruta NASA (desde órbita baja terrestre) del balance simplificado del cohete del juego.
- La tabla de puntuación 40/40/20 está en un documento del equipo, pero el enunciado define cinco criterios de evaluación de proyecto (Impact, Creativity, Validity, Relevance, Presentation), no esa rúbrica de puntos de gameplay.

## Resultado

El prototipo cubre el núcleo funcional del reto y mantiene una misión jugable con gestión de recursos, decisiones y evaluación. El punto más sensible para elegibilidad global es demostrar el uso integrado y reproducible de datos NASA; los puntos de entrega, equipo, publicación y materiales no pueden cerrarse desde el repositorio. No declarar «cumplimiento total» hasta cerrar los pendientes de la checklist.

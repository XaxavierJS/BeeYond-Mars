# Plan para cerrar pendientes y preparar nuevas mejoras

**Base del plan:** estado del repositorio y documentos revisados el 15 nov 2026.
**Objetivo:** completar evidencia de entrega de Space Apps y preparar el juego para nuevas funciones con riesgo bajo para la estética, la jugabilidad y la accesibilidad.
**Regla:** este plan no afirma que el proyecto ya se envió. El equipo confirmó que el arte y el audio son propios y eligió Apache 2.0 para su contenido original; el estado del formulario y de la publicación requiere verificarse en la cuenta de Space Apps.

## Estado de partida

Ya están implementados y documentados el ciclo de misión, las restricciones y eventos, la comparación de rutas con consulta reproducible de NASA Ames, el informe variable, el reinicio/rediseño y la extensión hipotética de invernadero. Hay pruebas automatizadas del motor y se verificó en navegador la reanudación de una partida v11.

Quedan pendientes de evidencia o validación:

- Estado de inscripción, equipo, envío y hora límite en la cuenta del evento.
- URL pública del juego y demo final; comprobación de acceso sin iniciar sesión.
- El equipo confirmó que el arte y el audio son propios, eligió Apache 2.0 (registrado en `LICENSE`) y confirmó autorización vigente para los logos predeterminados de GameMaker presentes en el repo. Estos logos quedan fuera de Apache y no entran en la web `dist/`; queda mantener su uso acorde a la guía de marca. Ver `docs/hackathon/recursos-y-licencias.md`.
- Concordancia final entre declaración de uso de IA, metadatos y medios que se publiquen.
- Recorrido manual sobre la build pública candidata, confirmación en dispositivo/puntero táctil y capturas de evidencia para submission. El flujo local completo y las vistas principales 390×844, 1024×768 y 1440×900 ya se comprobaron. El guion modular está listo en `docs/hackathon/guion-demo.md`, pero faltan el enlace público, formato/tiempo final y medios aprobados.
- Revisión integral de accesibilidad de teclado, foco y ventanas; se verificó el flujo de reanudar, abrir Mission Lead y cerrar la ventana, pero quedan otras pantallas/estados.
- Revisión final de consistencia documental: la discrepancia antigua de la guía IA se corrigió y la consulta/rutas se dejó en `docs/hackathon/evidencia-rutas-nasa.md`; falta comprobar cada cifra descriptiva y copia derivada en una revisión final.

Trabajo de cierre ya realizado en este ciclo: inventario técnico inicial de recursos creado; consulta NASA registrada con los resultados usados; comando `npm run sync:data` añadido como fuente repetible para los JSON derivados; solapamiento del botón de música corregido y revisado a 390×844; flujo manual local completo recorrido en un origen aislado, incluyendo fallo por comunicaciones, rediseño, llegada exitosa, invernadero y paper actualizado. Se mejoró la distribución vertical de la escena 16:9 en móvil y el monitor se compacta en 1024×768 para despejar Mission Lead; comprobado en 390×844, 1024×768 y 1440×900. Se corrigió el atajo global que bloqueaba Enter en botones y se mejoró la conservación/restauración del foco tras acciones, cambios de estado y ventanas; se verificó con teclado en compra de equipo, revisión, rutas, avance de viaje y retorno del paper al control exacto que lo abrió. Se aclaró en la guía del juego y el borrador de submission que el factor de energía de llegada del 85% es una regla ficticia independiente del dato NASA de irradiancia (~43%). La página oficial confirma el plazo general de 23:59 del 15 nov, hora local. Aún falta confirmar el huso horario e instrucciones del Local Event del equipo, una revisión en dispositivo/puntero táctil, teclado en todas las pantallas y repetir el recorrido sobre la build pública candidata.

## Orden de ejecución

### Fase 0 — Congelar la versión candidata y asignar responsables

**Acciones**

1. Elegir el commit/build que se presentará; anotar hash, fecha y versión.
2. Designar responsables del portal/entrega, publicación, recursos y prueba del juego.
3. Usar `docs/hackathon/checklist-entrega.md` como registro único de estado y enlazar cada casilla cerrada a su evidencia.

**Aceptación:** la versión a revisar está identificada y cada pendiente tiene responsable y fuente de evidencia. No se mezclan cambios de alcance con correcciones de cierre.

**Depende del equipo:** quién es responsable de la cuenta y qué build corresponde a la candidata.

### Fase 1 — Cerrar elegibilidad y formulario en la plataforma

**Acciones**

1. Revisar en la cuenta del equipo el reto, Local Event, integrantes visibles, límite de integrantes y campos obligatorios.
2. Confirmar con la guía oficial del evento el idioma, formato, duración y límite de la demo; las notas locales mencionan 7 diapositivas o 30 segundos, dato que no se debe dar por vigente sin comprobarlo.
3. Adaptar al formulario el título, resumen y descripción en inglés ya redactados en `BeeYondMarsGM/SUBMISSION.md`. Ajustar límites de caracteres/campos y confirmar el nombre final y las herramientas de IA con el equipo; mantener los límites científicos del juego.
4. Publicar el build web y abrirlo en una sesión privada/dispositivo sin permisos previos.
5. Enviar para evaluación solo desde la cuenta del equipo; guardar pantalla/recibo, URL, fecha y hora, y revisar que el estado quede confirmado.

**Aceptación:** inscripción, elegibilidad, formulario y envío tienen evidencia guardada; URL y demo son accesibles y cumplen la guía vigente.

**Bloqueo externo:** acceso del miembro responsable a Space Apps y datos reales del equipo. Ninguna comprobación del repositorio sustituye esa evidencia.

### Fase 2 — Asegurar derechos, referencias y declaración de IA

**Acciones**

1. Mantener `docs/hackathon/recursos-y-licencias.md` actualizado. Registra la confirmación de autoría y Apache 2.0; falta confirmar atribuciones y compatibilidad de materiales externos añadidos a la build o demo.
2. La autoría propia del arte del juego, la tipografía y el audio ya fue confirmada; Apache 2.0 está registrado. El equipo confirmó autorización para los logos de GameMaker en `options/**`; mantenerlos fuera del alcance de Apache. Revisar fragmentos/código externo, bibliografía y todo material del video/demo. Clasificar como propio, IA asistida/generado, tercero con licencia, tercero con permiso o sin resolver.
3. Para recursos sin evidencia, localizar el archivo de origen o sustituirlo por uno con derechos claros antes de publicar; no marcarlo como propio por estar dentro del repositorio.
4. La licencia Apache 2.0 del contenido original está elegida y registrada; mantener separado el permiso de marca confirmado para GameMaker y revisar materiales externos restantes.
5. Revisar arte y video finales; mantener la divulgación de IA declarada por el equipo y ausencia de logos/identificadores NASA no autorizados.
6. Conciliar el campo de uso de IA con la declaración del submission y los créditos. Distinguir generación de arte, asistencia de código y medios creados con código.

**Aceptación:** el equipo registra la licencia de contenido original requerida por los términos; cada recurso publicado tiene procedencia y permiso/licencia suficientes para su uso; y la declaración de IA coincide con el material final. Los elementos no resueltos no aparecen en la entrega.

**Bloqueo externo:** confirmación de autoría/permiso de integrantes y licencias de cualquier proveedor o material incorporado.

### Fase 3 — Reconciliar datos y documentos

**Acciones**

1. Mantener actualizada la sección “Evidencia y límites de las rutas” de `docs/AI_CONTRIBUTOR_GUIDE.md` junto a `docs/hackathon/evidencia-rutas-nasa.md`, que registra consulta, fecha y valores.
2. Comparar `dist/data.js`, `dist/game-balance.json`, `dist/sources.json`, la guía del juego, `README.md` y `BeeYondMarsGM/SUBMISSION.md`. `data.js` es la fuente que consume la app; los JSON/documentos son vistas derivadas y deben concordar.
3. Documentar correctamente que 0.85 es un factor de regla de juego del equipo, no irradiancia marciana real; aclarar que el delta-v del Trajectory Browser y el modelo simplificado del lanzador no representan la misma maniobra física.
4. Confirmar números de catálogo frente a v11 y evitar copiar valores de documentos antiguos cuando contradigan el proyecto actual.
5. Regenerar las copias JSON derivadas con `npm run sync:data`; el comando ya está implementado y documentado.

**Aceptación:** no hay afirmaciones contradictorias entre app, fuentes, balance, submission y guía; la fuente y las limitaciones de cada cifra están claras.

### Fase 4 — Validar experiencia de juego y corregir bloqueos

**Acciones**

1. Ejecutar `npm test` sobre el build candidato.
2. Recorrer el flujo manual completo: portada/continuar, carta, estaciones, instalar equipo, revisiones, rutas, lanzamiento bloqueado y permitido, incidente durante el viaje, paper/revisión, rediseño e invernadero cuando aplique.
3. Revisar escritorio (1440×900 y 1024×768) y móvil (390×844), incluyendo scroll, texto cortado, paneles que tapan acciones, botones difíciles de tocar y orientación.
4. Repetir el flujo básico solo con teclado: tabulación, foco visible, activación, cierre/retorno de ventanas y recuperación del foco. Confirmar que estados no dependan solo del color.
5. Revisar contraste y movimiento reducido, especialmente animaciones, audio y mensajes de riesgo. Registrar los fallos con captura, pantalla, pasos y severidad.
6. Corregir primero fallos P0/P1 de bloqueo, legibilidad o acceso. Para cada ajuste visual, comparar antes/después con la captura de referencia y revisar las tres anchuras definidas en la guía.

**Aceptación:** el recorrido puede completarse sin bloqueo; no hay texto/acción importante ocultos; los controles son accesibles con teclado y táctil; las pruebas existentes pasan. Registrar lo no probado.

### Fase 5 — Preparar el sistema de cambios futuros

**Acciones**

1. Mantener `AGENTS.md` y `docs/AI_CONTRIBUTOR_GUIDE.md` como instrucciones base para cualquier IA; cada tarea nueva debe declarar objetivo, alcance, pantallas/reglas afectadas y cosas que no debe cambiar.
2. Antes de implementar una función, escribir criterios de aceptación funcionales, visuales, de accesibilidad, ciencia/fuentes y compatibilidad con guardados, según el tipo de cambio.
3. Para propuestas de UX del backlog existente, abordar una por vez: reducir obstrucción del laboratorio; explicar métricas y bloqueos; unificar lenguaje/instrucciones; revisar teclado, contraste, movimiento reducido y pantallas estrechas.
4. Para equipo/rutas/incidentes/pantallas, seguir las recetas de ampliación de la guía y mantener el motor como autoridad de reglas. No sumar mecánicas opcionales para aparentar mayor cumplimiento.
5. Tras cada cambio, ejecutar las pruebas de motor/datos pertinentes, `git diff --check` y revisión visual en escritorio y móvil; anotar evidencia en checklist o guía.
6. Si cambia la estructura de una partida, definir migración versionada antes de tocar saves v11; probar datos válidos, antiguos, incompletos e inválidos sin sobrescribir partidas previas silenciosamente.

**Aceptación:** las nuevas contribuciones parten de una especificación pequeña y verificable, preservan la estética pixel-art y no degradan flujo, guardados ni acceso.

## Priorización y dependencias

| Prioridad | Entregable | Responsable típico | Depende de |
|---|---|---|---|
| P0 | Elegibilidad, formulario, demo y confirmación del envío | Responsable de submission | Acceso a la cuenta y guía del evento |
| P0 | Inventario de derechos y revisión de declaración IA | Artista/productor + equipo | Archivos fuente y confirmación de autoría/licencias |
| P0 | URL pública sin login y build candidata | Responsable web | Plataforma de hosting y publicación |
| P1 | Recorrido completo y prueba móvil/teclado | QA/equipo | Build candidata estable |
| P1 | Conciliación de fuentes, balance y docs | Responsable técnico/científico | Valores y decisiones finales del equipo |
| P2 | Mejoras de UX/UI priorizadas con criterios | Diseño + desarrollo | Hallazgos del recorrido y alcance acordado |
| Continua | Protección de estética, pruebas y compatibilidad | Toda persona/IA que contribuya | Especificación corta por cambio |

## Información que necesito del equipo

Para cerrar sin inventar estados o permisos, compartir o confirmar:

- URL del proyecto/equipo en Space Apps y quién puede verificar el formulario.
- Integrantes registrados, Local Event elegido y estado visible del envío (no compartir contraseñas ni datos sensibles innecesarios).
- URL pública candidata, si ya existe; plataforma usada y build desplegada.
- Guía/instrucciones vigentes de envío recibidas por el equipo, en especial el formato y duración de la demo.
- Indicar qué herramientas de IA deben declararse; el equipo ya confirmó que su arte y audio son propios.
- Material de demo final (diapositivas/video) y declaración IA que ingresarán.
- Decisiones aprobadas que afecten números de juego si v11, los documentos antiguos y el material final discrepan.

## Criterio de cierre

El plan se considera cerrado cuando la checklist enlaza evidencia para cada requisito aplicable, las dudas de derechos y plataforma están resueltas por personas con acceso/autoridad, la build pública se puede jugar y el recorrido validado no tiene fallos críticos. Las mejoras adicionales de producto se registran aparte; no se presentan como requisito oficial de la hackatón sin evidencia del enunciado.

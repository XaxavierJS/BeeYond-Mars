# Auditoría de hackatón · BeeYond Mars

Fecha: 15 noviembre 2026. Base: copia de trabajo actual posterior a `fbbde3d`, incluyendo las eliminaciones locales del equipo. Revisión documental, código y pruebas; no se ejecutó una partida completa en navegador ni se accedió a la cuenta Space Apps. No es certificación de elegibilidad. Las conclusiones de revisiones anteriores no se trasladan automáticamente a esta versión.

## Investigación del evento y fiabilidad de fuentes

| Tema | Hallazgo y fuente | Alcance |
|---|---|---|
| Edición | [Space Apps 2026](https://www.spaceappschallenge.org/2026/): 14–15 noviembre; tema The Next Frontier; cierre general de proyectos 15 noviembre 23:59 hora local | Página global consultada mediante búsqueda. No determina el plazo adicional del evento de este equipo |
| Registro | La página global pide cuenta, registro, Local Event y equipo de hasta seis participantes; la edición del proyecto se hace en Project de la página del equipo | No se verificó la inscripción de BeeYond Mars |
| Reto | [Space Mission Design Game reproducido en una página de equipo 2026](https://www.spaceappschallenge.org/2026/find-a-team/missionforge/): juego interactivo que permita diseñar, gestionar y simular una misión completa, decidir con recursos limitados y evaluar consecuencias | Es una reproducción del resumen dentro de contenido de equipo, no la especificación completa. La URL directa del reto y Resources devolvieron 502 en esta consulta |
| Evaluación | [Ajmer 2026](https://www.spaceappschallenge.org/2026/local-events/ajmer/) e [Islamabad 2026](https://www.spaceappschallenge.org/2026/local-events/islamabad/) enumeran Impact, Creativity, Validity, Relevance y Presentation | Contenido de Local Leads alojado en el sitio oficial. Confirmar guía global y rúbrica local aplicable; no inventar ponderaciones |
| NASA y entrega | Islamabad pide explicar uso de fuente NASA del reto, demo pública, referencias y declaración IA | Evidencia de reglas de ese evento, no prueba del requisito exacto del Local Event del equipo |
| Formato de demo | Hay instrucciones locales 2026 de siete diapositivas o 30 segundos; [Gorakhpur](https://www.spaceappschallenge.org/2026/local-events/gorakhpur/) pide diapositivas en inglés o subtítulos ingleses para video | No se localizó una guía global 2026 accesible que permita afirmar ese límite como universal. El borrador de 30 segundos es provisional |
| Derechos | [Términos de participantes 2026](https://www.spaceappschallenge.org/legal/): atribución, derechos de publicación, contenido original abierto/OSI; Apache 2.0 si no se declara otra licencia | Texto recuperado por búsqueda; apertura directa dio 502. Evitar contenido sensible y comprobar consentimiento para personas identificables en medios; términos restringen imágenes/voces/nombres reconocibles de menores |
| Plazos locales | Islamabad exige además formulario local antes del cierre global | Ejemplo de que la entrega global no sustituye requisitos locales; no aplicar su horario a este equipo |

No se trataron guías 2020/2022 ni páginas de staging como reglas vigentes. Queda pendiente obtener el enlace exacto del reto seleccionado, su Resources y las instrucciones recibidas por el equipo. No se establecieron como hechos globales reglas detalladas sobre marcado IA que no se pudieron verificar en guía vigente.

## Qué está y qué falta

| Aspecto | Estado | Evidencia actual y límite |
|---|---|---|
| Interactivo | Implementado en código | `dist/app.js`, `world.js`: movimiento, objetos, conversaciones, estaciones y decisiones. `engine.js`: acciones y consecuencias. Falta recorrido visual completo de esta copia |
| Educativo | Implementado; eficacia no medida | Restricciones de masa/potencia/presupuesto, rutas, incidentes e informe. El resultado permite revisar decisiones; no hay evidencia de aprendizaje con usuarios externos |
| Misión completa | Implementado en código | Diseño, validación de lanzamiento, viaje por etapas, incidentes, report y rediseño en `engine.js`; evaluación y continuación ficticia en `assessment.js` |
| Opciones de ingeniería | Implementado | Catálogo y varios lanzadores en `data.js`; dos rutas activas, estándar 288 días/4,79 km/s y rápida 272/4,84. No exigir Venus por aparecer en una versión anterior |
| Datos NASA | Referencias presentes; integración demostrable pendiente | `data.js` y `sources.json` citan NASA Ames, Mars Fact Sheet, duración de viaje y JPL. La app usa días/delta-v de escenarios, pero su procedencia exacta sigue declarada como no verificada. El valor NASA 0,431 es contexto: la regla energética activa es 0,85 del equipo |
| Datos de ruta adicionales | Presentes, no conectados al runtime observado | `data/BeeYond_Datos_Ruta_*.json` contienen IDs y reconstrucción GMAT preliminar; sus propios supuestos indican validación pendiente. Tener JSON no demuestra consumo por el juego ni certifica trayectorias |
| Honestidad científica | Mayormente explícita | `credits.html`, fuentes y submission distinguen ficción y riesgo de juego. Alinear todos los textos antiguos: REVIEW describe factor 0,431 integrado, mientras `data.js` usa 0,85 |
| Recursos visuales | Incompletos en esta copia | No existen `dist/assets/aurelia-pixel.ttf` ni `dist/assets/bees-v6.png`, solicitados por CSS/render. El fondo launchpad sí existe. No se auditó cada referencia dinámica ni cada frame |
| Pruebas | Parcial, fallo confirmado | `npm run test:story`: 4/4 pasan. `npm test`: 4 pasan y una suite falla al cargar; `tests/engine.test.js` importa `../engine.js` y `../route-data.js`, ausentes. No demuestra cobertura del motor final |
| Guardados | Implementado; compatibilidad parcial comprobada | `beeyond-rpg13` en app; misión interna `version:12`; pruebas de historia rechazan estados antiguos/malformados. No se validaron todos los saves reales |
| Accesibilidad/móvil | Pendiente de validación completa | Controles y CSS presentes; no declarar conformidad ni experiencia táctil verificada por revisión estática |
| Arte y audio | Autoría confirmada por el equipo | Confirmación previa en conversación: propios. No volver a exigir procedencia de estos recursos. Créditos existentes deben reflejar esa confirmación y la asistencia IA declarada |
| Licencia | Decisión aprobada; archivo ausente | Equipo eligió Apache 2.0 en conversación, pero `LICENSE` y `NOTICE` no están en la copia final. La decisión no equivale a distribuir el texto de licencia |
| Demo | Borrador únicamente | `docs/SUBMISSION.md` tiene storyboard de 30 segundos, no archivo ni URL de demo verificada |
| Publicación | No verificada | No se confirmó URL candidata actual ni despliegue de esta versión. Anteriormente el equipo informó no tener administración para habilitar Pages; revisar hosting con quien tenga acceso |
| Formulario y elegibilidad | No verificables desde archivos | Faltan enlace equipo/proyecto, Local Event, miembros registrados, reto seleccionado, campos finales y confirmación Submit for Judging |

## Riesgos frente a la evaluación

- **Impact:** propósito educativo claro; falta público objetivo concreto, objetivos de aprendizaje y observación breve con jugadores.
- **Creativity:** narrativa, misión biológica y exploración muestran una propuesta propia; explicarlo con capturas reales.
- **Validity:** mayor brecha: trazabilidad NASA, suite de motor rota, recursos faltantes y afirmaciones divergentes de revisiones anteriores.
- **Relevance:** el ciclo de misión corresponde al resumen disponible; cotejar contra el enunciado completo antes de afirmar cumplimiento total.
- **Presentation:** hay borrador en inglés; faltan demo final y URL pública comprobada.

Estas son valoraciones de auditoría, no puntuaciones del jurado ni requisitos nuevos.

## Acciones ordenadas

1. **P0, equipo/portal:** confirmar Local Event, reto, miembros, plazo y campos; completar envío y guardar recibo. No esperar mejoras opcionales para comprobar el estado del portal.
2. **P0, web:** recuperar de la entrega final los dos assets faltantes y auditar referencias restantes; probar la build completa y publicar con alguien que tenga acceso al hosting.
3. **P0, ciencia:** conservar consulta/export verificable NASA Ames para las dos rutas activas; mostrar dato → regla → efecto en la demo. No llamar al factor 0,85 dato NASA ni a la reconstrucción GMAT trayectoria validada.
4. **P0, entrega:** grabar demo real con fuentes visibles, decisión y resultado; confirmar duración/idioma y acceso público según evento.
5. **P1, desarrollo:** adaptar la suite del motor a su API actual y cubrir rutas viables, restricciones, incidentes, contabilidad, temporizadores, roles y rediseño. No recuperar el motor eliminado para hacer pasar pruebas antiguas.
6. **P1, documentación:** conciliar REVIEW, V13_GDD_REVIEW y SUBMISSION con la ejecución actual; incorporar licencia aprobada y declaración IA exacta. Mantener contexto histórico identificado.
7. **P1, experiencia:** recorrer teclado y móvil, foco, diálogos, guardado/reanudación, lanzamiento, decisiones, informe y cierre. Registrar navegador/tamaño y resultado.

## Información necesaria del equipo

- URL del proyecto/equipo, reto seleccionado y Local Event; instrucciones vigentes y estado del envío, sin contraseñas.
- Quién puede publicar la build y URL pública candidata.
- Archivo/enlace de demo final y herramientas IA a declarar.
- Consulta/export NASA o reporte original que permita reproducir las rutas.
- Copia completa de los assets finales que la limpieza retiró.

La auditoría está terminada como diagnóstico de la copia actual. El cumplimiento total sigue sin acreditarse: depende de evidencias y acciones indicadas arriba. No se alteró el juego ni se publicaron cambios durante esta auditoría.

# Plan de cierre de la versión final

Base: AUDITORIA.md, 15 noviembre 2026. No añadir mecánicas ni rediseñar la estética durante el cierre.

| Orden | Trabajo | Evidencia para cerrarlo | Responsable/dependencia |
|---|---|---|---|
| 1 · P0 | Publicar dist con Pages | Workflow exitoso, URL pública y recursos principales responden | Desarrollo; Pages configurado con Actions |
| 2 · P0 | Completar assets de esta entrega | Resolver tipografía ausente y atlas de abejas, revisar rutas de imágenes/audio; captura sin recursos rotos | Desarrollo + archivos fuente del equipo |
| 3 · P0 | Confirmar entrega Space Apps | Evento, reto, miembros, horario, campos y recibo del envío | Responsable con acceso al portal |
| 4 · P0 | Probar build pública | Inicio, conversación, estación, compra, lanzamiento, incidente, informe, rediseño, guardado y retorno; escritorio/móvil/teclado | Desarrollo y equipo con dispositivo táctil |
| 5 · P0 | Evidenciar NASA | Consulta/export que reproduzca fechas/días/delta-v y demo de cómo afectan la decisión | Responsable científico; reporte/consulta original |
| 6 · P0 | Crear demo final | Archivo real, formato vigente confirmado, inglés/subtítulos según evento y enlace sin permisos | Equipo; instrucciones Local Event |
| 7 · P1 | Adaptar pruebas de motor | Suite importa API actual, valida restricciones, rutas viables, recursos, incidentes, roles, tiempo y rediseño | Desarrollo; no recuperar motor eliminado |
| 8 · P1 | Conciliar documentación y licencia | README, fuentes, créditos y submission describen la misma versión; incluir Apache 2.0 ya aprobado y atribuciones aplicables | Desarrollo; autoría propia ya confirmada |
| 9 · P2 | Validar aprendizaje y UX | Ensayo con jugadores: entienden por qué falló la nave y logran corregirla; registrar bloqueos y mejoras | Equipo/diseño |

## Publicación

`.github/workflows/pages.yml` publica únicamente `dist/`. Cada push a main actualiza el sitio; también permite ejecución manual desde Actions. Revisar la ejecución antes de compartir el enlace. URL esperada: https://xaxavierjs.github.io/BeeYond-Mars/ . No confundir página publicada con envío al jurado.

## Información externa pendiente

Enlace del equipo/proyecto, Local Event y guía de entrega; acceso de quien envía; consulta/export NASA; demo final y herramientas IA declaradas. La aprobación de Apache y la autoría de arte/audio ya están confirmadas; no volver a pedirlas.

## Condición de cierre

Cerrar cada fila con evidencia concreta. El despliegue no cierra pruebas, NASA ni formulario. Registrar lo no probado y no convertir una hipótesis científica o una propuesta de diseño en un hecho validado.

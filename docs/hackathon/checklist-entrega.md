# Checklist de entrega Space Apps 2026

Estado al 15 nov 2026. Los estados que requieren acceso al equipo o a la plataforma quedan **PENDIENTES DE CONFIRMACIÓN**.

Para responsables, dependencias y criterios de cierre, seguir el [plan de pendientes](plan-cierre-pendientes.md).

## Proyecto y demo

- [ ] Nombre del proyecto confirmado en el formulario.
- [x] Borradores en inglés de resumen y descripción detallada preparados en [`SUBMISSION.md`](../../BeeYondMarsGM/SUBMISSION.md), consistentes con la versión web y sus límites.
- [ ] Adaptar los borradores al texto exacto y límite de caracteres del formulario; confirmar título y herramientas de IA con el equipo.
- [x] Preparar guion de demo en inglés: esquema de 7 diapositivas y locución de 30 segundos, pendientes de ajustar a los requisitos del Local Event.
- [ ] Demo enlazada y pública, dentro de los límites y formato vigentes en Project Submission Guide. La nota de bases del equipo indica hasta 7 diapositivas o video de 30 segundos; validar con guía oficial actual antes de finalizar.
- [ ] Enlace del producto público, accesible sin login/permisos; probado en ventana privada.
- [x] Repositorio de código público localizado y añadido al borrador; confirmar que el equipo lo usará en el formulario.
- [x] Preparación de publicación manual en GitHub Pages desde `dist/`; requiere que alguien con acceso habilite Pages y ejecute el workflow. La URL no se considera activa hasta verificar el primer despliegue. Ver [guía de publicación](publicacion-github-pages.md).
- [ ] Capturas revisadas y legibles; sin elementos temporales, errores de consola visibles ni afirmaciones sin respaldo.

## Datos, ciencia y derechos

- [x] Recurso NASA identificado y explicado: la consulta del Trajectory Browser queda enlazada en fuentes y sus fechas/duraciones/delta-v alimentan la comparación y el bloqueo de lanzamiento.
- [x] Consulta NASA reproducible archivada en la URL de la fuente; las tres filas seleccionadas corresponden a las rutas del juego.
- [x] Evidencia de consulta y límites de interpretación registrados en [NASA route evidence](evidencia-rutas-nasa.md).
- [x] Licencia OSI elegida: Apache 2.0 para el contenido original; `LICENSE` y `package.json` actualizados. El equipo confirmó que el arte y el audio son propios.
- [x] Recurso de marca GameMaker en `BeeYondMarsGM/options/**`: el equipo confirmó autorización vigente para incluir los logos/icons/splash predeterminados en el repo público. No están cubiertos por Apache 2.0; la web `dist/` no los usa. Ver el [inventario de recursos y licencias](recursos-y-licencias.md).
- [ ] Revisar cualquier recurso externo adicional que aparezca en el video/diapositivas de demo y mantener su atribución/licencia.
- [ ] Uso de IA descrito en el campo correspondiente y reflejado en metadatos según reglas vigentes.
- [ ] Arte/video con IA marcado visiblemente cuando corresponda; no usar/modificar logos, banderas o identificadores de misión NASA.
- [x] Límites claros en documentación de submission/juego: Aurelia ficticia, riesgo no es supervivencia, resultados de invernadero hipotéticos; el factor de energía de llegada del 85% está separado del dato NASA de luz solar (~43%).

## Elegibilidad y envío

- [ ] Integrantes registrados en el mismo Local Event, miembros visibles y equipo dentro del máximo de 6.
- [ ] Campos obligatorios del formulario completos en inglés.
- [x] Plazo general de Space Apps 2026 verificado: 15 de noviembre a las 11:59 p. m., hora local (página oficial). [Confirmar el huso horario aplicable y cualquier entrega adicional con el Local Event del equipo.](https://www.spaceappschallenge.org/2026/)
- [ ] Casillas de términos y trabajo original revisadas por el equipo responsable.
- [ ] Pulsar Submit for Judging y comprobar confirmación/estado guardado.
- [ ] Guardar enlace, fecha/hora y copia del material enviado.

## Verificación del juego

- [x] La web sirve localmente desde `dist/` (`npm start`).
- [x] Suite automatizada existente: 12 pruebas pasan; incluye catálogo, restricciones, eventos, retraso con llegada, invernadero y guardados.
- [x] La portada muestra «Continue mission» al detectar un guardado v11 válido; se comprobó reanudarlo y entrar al laboratorio en navegador.
- [x] La barra de avance y los días del siguiente paso usan la duración total con retraso de comunicaciones.
- [x] La composición móvil reduce el monitor de abejas y el panel de objetivo; la escena 16:9 queda encima del espacio reservado para controles táctiles, sin recortar estaciones. Vista comprobada en 390×844.
- [x] En 390×844, el control de música de la portada ya no se superpone con el texto superior; se verificó visualmente después del ajuste.
- [x] Revisión visual del laboratorio en 1440×900 y 1024×768; en tamaño intermedio el monitor se compacta y deja visible el rótulo Mission Lead.
- [x] En 390×844, el botón de estación abre el diálogo de equipo dentro de la pantalla sin cortar tarjetas ni botón de regreso.
- [x] En 1024×768, reanudar con Enter, recorrer botones con Tab, abrir Mission Lead con Enter, cerrar con Escape y devolver el foco al botón que abrió la ventana.
- [x] Comprobación adicional solo con teclado: comprar equipo conserva el foco en el control actualizado; cerrar Biology devuelve foco a esa estación; aprobar un hito mueve foco al siguiente control habilitado; seleccionar rutas y avanzar etapas conserva foco; abrir/cerrar el paper desde el informe devuelve foco al botón exacto que lo abrió.
- [ ] Confirmar en dispositivo/puntero táctil que el pad de movimiento respeta su espacio reservado y comprobar navegación completa con teclado/foco en todas las pantallas.
- [x] Recorrer en navegador local aislado portada/carta, diseño, bloqueo y permiso de lanzamiento, dos rutas/revisiones, vuelo con pérdida de señal e impacto, paper, rediseño, segunda misión exitosa e invernadero con paper actualizado. Este flujo no tocó la partida guardada del navegador habitual.
- [ ] Repetir el recorrido de humo en la build candidata publicada y guardar evidencia/captura para el submission.
- [ ] Completar el recorrido de accesibilidad por todas las pantallas y estados; lo verificado con teclado ahora cubre inicio, compra, hitos, rutas, vuelo, informe y retorno de foco. Faltan otras ventanas/estados y un dispositivo táctil real.

**No inferir envío completo a partir de una URL pública o de un borrador.** El estado de formulario/registro solo lo puede confirmar la página del equipo y la confirmación final de Space Apps.

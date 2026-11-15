# Guía de contribución con IA · BeeYond Mars

## Propósito y estado del producto

BeeYond Mars es un juego educativo retro sobre diseñar una nave para transportar reinas de *Bombus terrestris* en diapausa hacia Marte. La edición web es la base activa; el proyecto `BeeYondMarsGM/` sirve para contrastar la migración desde GameMaker v11. La captura del laboratorio compartida por el equipo es una referencia de composición, legibilidad e identidad visual, no una instrucción para copiar defectos de solapamiento.

Las ampliaciones deben mejorar claridad y uso sin cambiar el contenido o las mecánicas que no estén en el alcance solicitado. Las mejoras de UX/UI propuestas más abajo son backlog, no funcionalidades ya implementadas.

## Mapa del sistema

- `dist/app.js`: pantallas, navegación, controles, ventanas, logbook, exportación y dibujo del laboratorio.
- `dist/style.css`: composición adaptable, componentes, estados, tipografía y estilo visual.
- `dist/engine.js`: estado serializable, fórmulas, restricciones, calendario de incidentes, informes, invernadero y validación de partidas.
- `dist/data.js`: parámetros, roles, equipamiento, rutas, guía y fuentes usadas por la aplicación.
- `dist/audio.js`: música, efectos, volumen y ciclo de pistas.
- `dist/assets/`: fondos, personajes, equipo, efectos, fuente y audio. `dist/assets/gamemaker-v11/` guarda recursos extraídos de GameMaker v11.
- `dist/game-balance.json` y `dist/sources.json`: copias de referencia/documentación. No asumir que la aplicación los lee en ejecución; `dist/data.js` es la fuente maestra. Después de cambiarlo, ejecutar `npm run sync:data`.
- `tests/engine.test.js`: pruebas de reglas, flujo, guardados e incidentes.

La aplicación no tiene backend ni dependencias runtime npm; se sirve como web estática desde `dist/`. Ejecutar con `npm start`; abrir `http://localhost:8080`.

## Flujo y estado

El recorrido principal es portada → carta de financiación → laboratorio y estaciones → revisiones y comparación de rutas → lanzamiento → etapas de viaje e incidentes → informe/paper y revisión por pares → rediseño o extensión hipotética del invernadero. `engine.js` es la autoridad de las reglas; la UI representa su estado y no debe decidir resultados por su cuenta.

El motor guarda el progreso localmente bajo `beeyond-v11`; también reconoce la existencia de saves v5/v6 sin sobrescribirlos. Una partida puede persistir en fases de laboratorio, lanzamiento, viaje, informe o invernadero. Si cambia la forma del estado, planear una migración explícita y versionada, conservar los saves anteriores y definir qué ocurre ante datos incompletos o inválidos. No cambiar la clave ni el número de versión como detalle incidental.

## Sistema visual y UX

### Tokens y principios actuales

- Fondo general azul noche (`#111726`), superficies azul pizarra, texto crema (`#f6efdb`), dorado para acciones y foco (`#ffe096`), verdes grisáceos para bordes y acentos.
- La fuente pixel se reserva principalmente para encabezados; el texto de lectura usa una sans serif del sistema.
- Paneles de borde firme, contraste alto, esquinas poco redondeadas, botones claros y sombras duras. Los títulos pueden llevar espaciado de letras.
- La escena usa pixel art; configurar `image-rendering: pixelated` y evitar filtros que suavicen sprites. Mantener proporciones al escalar fondos y personajes.
- Mantener juntas la información y la acción correspondiente. Priorizar textos cortos, jerarquía visible, estados seleccionados y bloqueos con causa y orientación.
- Respetar `:focus-visible`, teclado, lectura por tecnologías de asistencia y controles táctiles. No depender solo del color para comunicar riesgo o estado.
- Los atajos globales del juego no deben cancelar Enter/Espacio cuando un botón, enlace o campo tiene foco; esos controles deben conservar su activación nativa. Al cerrar una ventana, devolver el foco a quien la abrió.
- Al volver a dibujar una pantalla o ventana después de una acción, conservar el foco en el control equivalente si sigue disponible; si se deshabilita o desaparece, moverlo a la siguiente acción principal habilitada. Cuando dos botones hacen lo mismo, devolver el foco al botón concreto que abrió la ventana.
- Las ventanas deben anunciar su encabezado como nombre accesible; controles repetidos deben identificar su equipo, ruta u opción en el nombre accesible sin cambiar el texto visual.

### Catálogo de recursos

La carpeta `dist/assets/` contiene arte de distintas etapas. Los fondos bajo `backgrounds/`, los sprites en `sprites/`, los recursos de GameMaker en `gamemaker-v11/` y los archivos anteriores como `hero.png`/`bees-v6.png` no son intercambiables automáticamente. Antes de añadir o reemplazar arte:

1. Localizar el recurso y sus metadatos/frame en el manifiesto o carpeta de origen.
2. Confirmar dónde se usa en `app.js` y qué dimensiones/relación de aspecto espera el layout.
3. Reutilizar el arte aprobado y preservar estilo, escala y transparencia; no crear una imagen de reemplazo sin una solicitud explícita.
4. Verificar recorte, nitidez, legibilidad de superposiciones y vista estrecha después del cambio.

La captura del laboratorio muestra HUD superior, fondo pixel art, panel de objetivo flotante, monitor de abejas lateral y controles de estación inferiores. Sirve para preservar la composición e identificar mejoras: el panel de objetivo tapa parte del arte y el monitor puede cubrir el área de juego. Cualquier propuesta para reducir esos solapamientos debe conservar la información y el acceso.

### Recetas de ampliación

- **Equipo:** añadir el registro y sus valores en `data.js`; mostrar el arte correcto; comprobar coste, masa, consumo/generación, rol, restricciones, mensajes, revisión, consejos, informe, catálogo JSON y fuentes si aplica. Añadir cobertura de cálculo en pruebas cuando cambie una regla.
- **Incidente:** definir disparador determinista, fecha/etapa, condiciones automáticas, opciones, coste/efecto, registro de decisión, fin de misión si aplica, narrativa de informe y consecuencia de rediseño. Mantener decisiones resolubles a bordo cuando sea parte del diseño.
- **Ruta:** definir fechas, días, delta-v, inyección y postinyección, fuente/procedencia y compatibilidad. Actualizar selección, comparaciones, mensajes, HUD, paper e informe; marcar si los valores son del equipo o verificados.
- **Pantalla o fase:** definir estado y transiciones en el motor; después presentar ese estado en la UI con navegación, cierre/retorno, teclado/táctil, foco y manejo de carga/error. Revisar guardado y rediseño.
- **Componente UI:** reutilizar las reglas de botones, tarjetas, etiquetas, métricas y modales existentes. Incluir estados base, hover, foco visible, seleccionado, deshabilitado, error y espera cuando correspondan.

## NASA y límites científicos

El juego es un modelo educativo simplificado. La agencia Aurelia es ficticia, el equipo define costes y parámetros de nave, los hitos CML son inspirados y ficticios, la salida solar al llegar usa 0.85 (no el ~0.43 de Marte citado en la ficha), y el riesgo es un índice de juego, nunca probabilidad de supervivencia. El invernadero es una extensión hipotética; no simula liberación de organismos ni prueba supervivencia interplanetaria. No insinuar afiliación oficial con NASA.

Para nuevas afirmaciones, mantener una tabla editorial con: afirmación exacta, URL y organización/autores, fecha de consulta, dato/unidad, uso dentro del juego, etiqueta (`VERIFIED`, `ADAPTED`, `SINGLE STUDY`, `CONTEXT`, `TEAM`, `OPEN`) y límites relevantes. Separar el origen científico del supuesto de gameplay. Verificar fuentes primarias/oficiales cuando la afirmación sea de NASA o de una institución; no tratar texto de ideas del equipo como evidencia científica.

### Evidencia y límites de las rutas

La consulta guardada en `dist/data.js` y `dist/sources.json` corresponde al NASA Ames Trajectory Browser; las tres filas coinciden con las rutas del juego. La [evidencia de consulta y resultados](hackathon/evidencia-rutas-nasa.md) registra parámetros, fechas, tiempos de vuelo y delta-v revisados el 15 nov 2026. Mantener el límite: NASA aporta los valores de trayectoria consultados; la nave, penalización por masa, reglas de potencia y costos son un modelo simplificado definido por el equipo. El factor `0.85` es una regla de llegada del juego y no el nivel real de luz solar marciana (~0.43 terrestre). Si cambian los registros, volver a consultar y actualizar a la vez el motor de datos y sus copias/documentación.

No presentar recomendaciones, índices o salidas del modelo como asesoramiento de misión real. Conservar unidades y mostrar redondeo sin alterar los cálculos.

## Backlog priorizado de UX/UI

Son oportunidades observadas, todavía no implementadas como parte de esta guía:

1. **Reducir obstrucción en el laboratorio:** evaluar colapso/ubicación del panel de objetivo y monitor de abejas para dejar visible la escena; conservar sus textos, controles y acceso por teclado/táctil.
2. **Explicar métricas y bloqueos:** dar definiciones breves a DV, potencia y energía, y señalar qué requisito falla y qué acción permite resolverlo.
3. **Unificar lenguaje e instrucciones:** la interfaz y los controles actuales están en inglés; al cambiar las rutas, mantener coherentes el texto, el número de opciones visibles y el mínimo de dos rutas que pide la revisión para obtener la subvención.
4. **Mejorar adaptación y accesibilidad:** probar foco, contraste, controles táctiles, movimiento reducido, ventanas extensas y lectura en pantallas estrechas.

Prioridad 1 es mejora visual/legibilidad sin cambiar mecánicas; prioridades 2–4 requieren revisión de copy e interacción. Antes de implementar cualquier punto, definir captura/escenario de referencia y criterios de aceptación para ese cambio.

## Validación y criterios de aceptación

- Cambio de motor/datos/guardado: `npm test`, revisar `git diff --check` y comprobar estados válidos e inválidos afectados.
- Cambio visual: recorrer la pantalla en navegador, revisar consola y probar 1440×900, 1024×768 y 390×844; confirmar que no haya texto cortado, elementos inaccesibles, distorsión ni controles tapados.
- Recorrido de humo: portada, carta, instalar equipo, revisar rutas, bloqueos de lanzamiento, vuelo e incidente, informe/paper, rediseño y extensión si aplica.
- No declarar una verificación científica o visual que no se haya realizado. Documentar cualquier limitación del chequeo.
- Aceptar una ampliación cuando respete el alcance autorizado, la identidad visual, la accesibilidad y los límites científicos; mantenga coherentes código y copias documentales; y pase las validaciones aplicables.

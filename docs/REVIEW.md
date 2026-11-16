# BeeYond Mars v12 — revisión de migración, jugabilidad y concurso

Fecha: 15 de noviembre de 2026. Base técnica: `BeeYondMarsGM_v11.zip`. Documentos: «Banco de ideas y plan — Space Mission Design Game» y guía de evaluación aportada. Esta es una auditoría de implementación y una valoración orientativa; no certifica elegibilidad ni garantiza la puntuación del jurado.

## Resultado y alcance

Se reconstruyó el juego en HTML, CSS y JavaScript con reglas separadas de la presentación. Conserva los ocho componentes, las tres rutas, revisiones, incidentes, informe y extensión de invernadero de v11. Añade historia, encuentros, recuerdos, lanzadores diferenciados, controles accesibles, temporizador, guardado y audio. Se reutilizaron las imágenes de v11 y la música procedural de la versión web, sin copiar personajes ni melodías de los juegos de referencia.

La revisión estática cubrió los 506 archivos del ZIP: 6 GML, 44 YY, 435 PNG, 14 WAV, 2 Markdown, 1 YYP, 2 ICO y 2 BMP. Se leyeron completos los seis GML y los documentos; se validaron los JSON YY, las imágenes y los metadatos WAV y se generaron hashes. No se encontraron errores de lectura o archivos de imagen corruptos. El inventario está en `gamemaker-inventory.json`. Esto no equivale a compilar ni ejecutar GameMaker, que no estaba disponible. Las imágenes se inspeccionaron mediante una hoja de contacto de los sprites, no revisando artísticamente cada fotograma individual.

## Hallazgos prioritarios y correcciones

| Hallazgo en v11 o la versión web anterior | Consecuencia | Tratamiento v12 |
|---|---|---|
| Web antigua: cámara de 800 W, masas y nombres incompatibles con v11 | Decisiones diferentes a las de la nueva fuente | V11 es canónico: Economy 135 kg/200 W; Vanguard 90 kg/500 W |
| V11: presupuesto de 900, no 2.000 | Muy poco margen para explorar y experimentar | 2.000 iniciales, más 150 y 200 por revisiones; carta explícita |
| V11: lanzador fijo 250 kg/7 km/s/600 W | No hay tres perfiles realmente distintos | Scout, Aurelia y Atlaswing difieren en masa, generación, consumo, delta-v y precio |
| Venus exige 6,82 km/s; penalización 0,008/kg sobre 7 | Máximo 22,5 kg, menor que cualquier cámara | Atlaswing dispone de 9,2 km/s y admite diseños viables para Venus |
| Factor solar ficticio 0,85 presentado junto al dato real ~0,43 | El dato NASA podía resultar decorativo | Factor 0,431 verificado alimenta consumo, batería y bloqueo de lanzamiento; buses reajustados |
| Se podía despegar sin comunicaciones | Fracaso inevitable que no se entendía al diseñar | Se exige al menos una vía de comunicación antes de lanzar |
| Respaldo descontaba datos ya recibidos en Tierra | Se violaba la interpretación de los datos | Solo puede perderse memoria aún a bordo; conservación generados=recibidos+guardados+perdidos |
| Fallo mecánico descontaba daño por cada llamada de avance | Incidentes cercanos podían castigar más que el tiempo transcurrido | Daño proporcional a días/30 |
| Algunas respuestas gastaban batería sin registrar energía | Informe energético incompleto | Pulsos de 500/600 Wh también entran al consumo acumulado |
| Abrir una estación cambiaba el rol automáticamente | Cooperación sin traspaso explícito | Confirmación local de turno; permisos en motor y explicación en interfaz |
| Fuente bitmap ASCII aplicada a textos largos | Lectura incómoda y problemas de glifos | Títulos retro y cuerpo legible; párrafos y diálogos ajustables |
| Abejas pequeñas o ausentes en pantallas clave | Poco vínculo con la carga | Retratos grandes en laboratorio, tránsito, resultados y hábitat |
| Referencia «Alford 1969» enlazaba a un estudio de 2017 | Cita incorrecta | Sustituida por Bogo et al. (2017), con alcance terrestre explícito |

## Balance implementado

El presupuesto y los lanzadores son decisiones de diseño, no cifras aeroespaciales reales.

| Paquete | Precio | Carga máx. | Generación a 1 UA | Consumo del bus | Delta-v base |
|---|---:|---:|---:|---:|---:|
| Scout | 0 | 190 kg | 700 W | 20 W | 7,0 km/s |
| Aurelia | 200 | 250 kg | 1.000 W | 35 W | 7,4 km/s |
| Atlaswing | 600 | 400 kg | 1.600 W | 80 W | 9,2 km/s |

La masa de los instrumentos reduce delta-v mediante la regla simplificada heredada de v11: base − 0,008 × kg. El paquete incluye lanzador y bus de crucero; el modelo no sostiene que el cohete siga unido y generando electricidad todo el viaje. Se exige potencia suficiente al llegar, no solo al despegar. Sensores activados en vuelo pueden añadir consumo: esta consecuencia está explicada antes de comprarlos.

La compra se puede deshacer sin penalización. No hay préstamo ni saldo negativo. Cambiar de cámara devuelve el costo anterior. Los fondos por revisión no se pueden reclamar repetidamente. El perfil inicial Scout cuesta cero para que los créditos visibles al comenzar coincidan con los 2.000 de la carta.

El motor enumera combinaciones para comprobar que cada lanzador tenga al menos una misión que llegue y que cada ruta sea alcanzable. Venus queda reservada a Atlaswing; esa restricción es un compromiso visible, no una ruta bloqueada para todos.

## Jugabilidad, emoción y ritmo

El recorrido combina una introducción breve con decisiones que cambian el resultado:

1. Lum piensa guardar una investigación inconclusa. La carta de Aurelia financia una pregunta, no una promesa de éxito.
2. Se encuentran Pip, Nim y Eko en el entorno exploratorio. Cada encuentro aporta un objeto simbólico y una idea científica.
3. Se diseña con el equipo. Las restricciones cambian inmediatamente y explican qué corregir.
4. Una cinemática lleva al viaje. Los incidentes detienen el avance por etapas y piden respuestas con costos visibles.
5. El informe diferencia fracaso, llegada parcial y diseño equilibrado. Rediseñar conserva equipos, fondos y semilla.
6. Una extensión ficticia permite cuidar el invernadero. El cierre depende de sus decisiones; el final favorable imagina estudios posteriores y un Nobel muchos años después.

El cuaderno tiene doce recuerdos asociados a acciones, no a pulsar repetidamente una recompensa. El último cierre recupera la carta y los objetos de los amigos. La intención es que completar el cuaderno evoque pertenencia y trabajo compartido. No se ha validado todavía esa respuesta emocional con jugadores externos.

Referencias de diseño: la restauración colectiva de Stardew Valley inspira el cuaderno; Pokémon inspira un registro progresivo; Undertale y OMORI, conversaciones breves y consecuencias; Celeste, reintento sin humillación; Mad Father y Pom Gets Wi-Fi, escala pequeña y escenas narrativas. No se usan sus marcas como parte del mundo, ni sus personajes, mapas, interfaces exactas o música.

Los cuatro personajes comparten una silueta neutra. Pip lleva gafas turquesa; Nim, un brote verde; Eko, auriculares violetas; Lum, una bufanda dorada. No se asignan géneros ni capacidades por apariencia.

Controles: flechas/WASD y E en la exploración, botones equivalentes para ratón/táctil, foco visible, diálogos HTML, pantalla completa opcional. El diseño ocupa la ventana por defecto. El navegador requiere una interacción para iniciar sonido. Música y efectos tienen volúmenes independientes y pausa al ocultar la pestaña. La reducción de movimiento respeta la preferencia del sistema.

El temporizador ofrece 60, 120 segundos o modo sin límite. Pausar, consultar fuentes o cambiar de pestaña detiene la cuenta. Al agotarse, se ejecuta una respuesta autónoma documentada: reparación disponible, batería o daño; en comunicaciones, telemetría esencial. No transforma una dificultad de lectura en una derrota instantánea. El ajuste puede cambiarse sin penalización.

## Auditoría científica

Dato NASA integrado y comprobado: [Mars Fact Sheet](https://nssdc.gsfc.nasa.gov/planetary/factsheet/marsfact.html), irradiancia solar 586,2 frente a 1.361 W/m², razón 0,431. Se usa directamente en la potencia disponible a la llegada y en la evolución del viaje. La interpolación lineal entre salida y llegada es una simplificación: no modela efemérides, actitud, degradación, eclipses ni un sobrevuelo detallado de Venus.

Las rutas de 272/288/352 días y 4,84/4,79/6,82 km/s están atribuidas al [NASA Ames Trajectory Browser](https://trajbrowser.arc.nasa.gov/) por la fuente v11. El ZIP no incluye la consulta/exportación original. Se conservan como escenarios transcritos del equipo, sin afirmar verificación independiente. Se debe adjuntar esa evidencia antes de defenderlas como trayectorias validadas.

[ESA](https://blogs.esa.int/mex/2012/08/05/time-delay-between-mars-and-earth/) explica la demora de señal aproximada de 4–24 minutos por sentido. La interpolación del juego es ilustrativa. Las decisiones representan autonomía a bordo; una antena más potente no modifica la velocidad de la luz.

[Bogo et al. (2017)](https://cris.unibo.it/handle/11585/613718) estudia reinas de Bombus terrestris en condiciones terrestres. La relación entre estado de apareamiento, peso y resultados no establece supervivencia espacial. Los objetivos de 2,5 °C y 70% HR quedan identificados como parámetros heredados cuya referencia original requiere revisión; no como protocolo certificado. Se evita afirmar que diapause equivalga simplemente a dormir o que una cámara garantice 100% de supervivencia.

El [módulo de abejas STS-41-C](https://airandspace.si.edu/collection-objects/bee-enclosure-module-sts-41-c/nasm_A19880031000) del Smithsonian aporta contexto histórico sobre abejas melíferas en órbita, no evidencia sobre abejorros en Marte. El dosímetro mide; no protege ni justifica automáticamente una maniobra de comunicaciones.

El índice de riesgo es pedagógico. No hay simulación de mortalidad individual, metabolismo, radiación acumulada, biocontención real o fertilidad. El invernadero, el viaje humano y el Nobel son ficción señalada dentro del juego. Un Nobel exige trabajo científico real y una decisión institucional que el juego no puede predecir; el epílogo no debe venderse como resultado del modelo.

## Evaluación orientativa como jurado

Los cinco criterios tienen el mismo peso según la guía aportada. Esta valoración no es una nota oficial y no se usa para prometer 25/25.

| Criterio | Evidencia construida | Riesgo que todavía limita la máxima nota |
|---|---|---|
| Impact | Actividad educativa accesible sin instalación; términos explicados; informe y reintento | Falta medir aprendizaje y accesibilidad con estudiantes/docentes externos |
| Creativity | Investigación, personajes, objetos y colección unidos a la ingeniería | La respuesta emocional aún no está validada; exploración breve |
| Validity | Motor probado, magnitudes consistentes, datos NASA integrados y límites científicos explícitos | Faltan consulta exacta de rutas, validación biológica y pruebas en varios dispositivos |
| Relevance | Diseño, presupuesto, instrumentos, masa, potencia, trayectoria, incidentes y evaluación | Mostrar claramente el ciclo completo en la demo y justificar simplificaciones |
| Presentation | Carta, abejas visibles, texto legible, cinemáticas, música y final | Falta presentar la demo final al jurado con un enlace público comprobado |

Recomendación: no añadir más sistemas antes de la entrega. Priorizar acceso público, demo de duración reglamentaria y una prueba breve con una persona que no conozca el juego. Preguntar qué cambiaría del diseño y por qué; registrar si puede explicar W frente a Wh y medición frente a protección.

## Comprobaciones del concurso

Según el documento aportado: formulario y materiales vinculados en inglés; máximo seis integrantes del mismo evento; al menos un recurso NASA real integrado; referencias y declaración de IA; enlaces públicos sin acceso restringido; demo de hasta siete diapositivas o hasta treinta segundos. Fecha y hora finales dependen del evento local y deben comprobarse en la plataforma oficial. Las páginas concretas de las guías oficiales devolvieron errores durante la revisión, por lo que aquí se cita la guía suministrada y no se simula una certificación independiente.

Implementado: interfaz y borrador de entrega en inglés; dato NASA central; fuentes dentro del juego; etiquetas de arte asistido por IA; ausencia de logos oficiales añadidos; límites científicos; documentación y pruebas. Preparado: borrador de descripción, guion de treinta segundos y flujo de GitHub Pages que prueba antes de publicar.

Pendiente externo: cuenta/repositorio GitHub operativo; publicación pública y prueba anónima; demo grabada o diapositivas finales; integrantes y registros; revisión de derechos del material aportado; aceptación personal de los acuerdos del concurso y envío del formulario. Ninguna de esas acciones se declara completada solo porque esté descrita aquí.

## Evidencia de pruebas

Pruebas automatizadas: presupuesto, cámara 500 W, tres perfiles, factor NASA, éxito/fracaso, reproducibilidad, revisiones no repetibles, sustitución de cámara, permisos, bloqueos, pausa/timeout, modo relajado, conservación de datos, energía de emergencia, invernadero, reintento, validación de guardado y enumeración de diseños/rutas.

Prueba visual de escritorio: se recorrió la carta, los tres encuentros, diseño con Vanguard/antena/toolkit/dosímetro y Atlaswing, dos revisiones, ruta rápida, lanzamiento, realineación, reparación, llegada y cuatro decisiones del invernadero. Resultado observado: 284 días, 302,9 MB recibidos, 0 MB perdidos, riesgo 1/100, cuaderno 12/12 y epílogo. Se observó que la pausa conserva la cuenta del incidente. El guardado permite continuar después de recargar.

Límites de QA: no se ejecutó GameMaker nativo, no hay certificación de equivalencia binaria con el motor GML y no se realizaron pruebas con lectores de pantalla reales, Safari/iOS o una cohorte de usuarios. La maquetación responsive requiere validación adicional en teléfonos reales. El audio tiene controles y generación comprobables; su apreciación musical necesita escucha humana.

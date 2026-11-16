# BeeYond Mars v13 — implementación del GDD 3.1 y del enfoque RPG

Documento rector: `Texto pegado(2).txt`, aportado por la autora durante el rediseño. Este informe reemplaza las decisiones de diseño de v12 cuando difieren; la auditoría `REVIEW.md` corresponde a v12 y se conserva como antecedente, no como especificación vigente.

## Lo que cambió en la experiencia

La aventura sucede ahora en un mundo continuo de ocho espacios: habitación, pueblo, taller, jardín, estación, laboratorio, nave e invernadero. Movimiento con colisiones, sprites animados, cámara y navegación por clic o botones accesibles. Hablar requiere acercarse: los accesos calculan un recorrido, no teletransportan al personaje.

El prólogo se cuenta mediante objetos: sacar el cuaderno de la caja, colocarlo sobre el escritorio, regar una planta y recoger la carta. La financiación de Aurelia menciona el riesgo de perder el laboratorio. Los 2.000 créditos y las revisiones de 150/200 se conservan como decisión de equilibrio previamente solicitada; el GDD no especifica otra cantidad.

Las amistades tienen acciones compartidas. Pip necesita apagar, reparar y volver a encender una radio. Nim comparte la observación del abejorro y el riego del semillero. Con Eko se decide si enviar una pregunta honesta o prometer una garantía sin evidencia; la conversación a bordo recuerda la elección y permite corregirla. No se muestra una barra numérica de afecto ni se obliga a repetir tareas para ganar cariño.

El taller utiliza catálogo, esquema de nave que cambia con los componentes y monitor de recursos. Se accede desde los objetos del laboratorio. El mapa permite comparar las dos rutas del GDD y elegir entre tres paquetes de lanzamiento, conservando la petición anterior de diferenciarlos. El cohete mediano vuelve a 250 kg, 600 W y 7 km/s.

El tránsito mantiene el motor determinista: revisiones, eventos, pérdidas, temperatura, humedad, energía y resultados. Se camina entre el mando, la cámara, el panel de sistemas y las amistades. Hay un modo tranquilo sin límite de respuesta y opciones de 60/120 segundos. La pausa y las consultas interrumpen el contador. El tiempo elegido se muestra durante el incidente y su respuesta automática está explicada.

La puntuación se desglosa en configuración (40), decisiones (40) y reservas (20). Un fallo vital limita el resultado a 49; una llegada comprometida lo limita a 79. Los resultados producen Nobel ficticio, prórroga o embargo. El escenario de casa y la música responden al desenlace; se puede revisar la bitácora y rediseñar conservando configuración y fondos.

La extensión del invernadero se conserva por petición anterior, separada como futuro hipotético. La llamada de Estocolmo se sitúa años después de investigaciones adicionales, no como consecuencia científica real de una sola simulación.

## Arte y sonido

Resolución del mundo 480×270, escalado nearest-neighbor. Mapas dibujados por código con paleta controlada; personajes de la fuente v11 y atlas de abejorros de v6, con expresiones según el contexto. Personajes neutros: gafas, brote, auriculares y bufanda. Texto narrativo legible, cabeceras bitmap y telemetría monoespaciada. Interfaz en español con cambio a inglés en pausa; las citas y entradas técnicas heredadas de la bitácora permanecen en inglés.

La música procedural original cambia entre prólogo, taller, exterior, tránsito, emergencia y los tres finales. Los diálogos tienen aparición progresiva y sonidos breves con tonos por personaje. Hay volúmenes independientes. La secuencia de lanzamiento incorpora cuenta regresiva, humo, desplazamiento del cohete y opción de omitir.

## Correcciones al GDD

- Dosímetro: 0,3 × 0,008 = **0,0024 km/s**, no 0,04. El sensor de igual masa tiene la misma penalización.
- La resta lineal por masa es un modelo lúdico. No se presenta como una derivación de la ecuación del cohete.
- La cámara Vanguard de 500 W no obliga por sí sola a superar 600 W. Son el equipo adicional y el margen de llegada los que pueden exigir paneles; la interfaz calcula el caso real.
- Para conservar la base de 600 W y el equilibrio heredado, el factor de generación de llegada vuelve a 0,85, **rotulado como simplificación**. El dato de irradiancia NASA 0,431 sigue en fuentes como contexto, no se afirma que sea el factor del motor v13.
- Las rutas exactas de 272/288 días y 4,84/4,79 km/s siguen siendo transcripciones del equipo; falta la exportación de la consulta original. No se certifican por repetir su atribución.
- Los objetivos térmicos heredados no se elevan a protocolo espacial validado. Diapausa terrestre y abejas melíferas en órbita no demuestran transporte de reinas de abejorro a Marte.
- “Viabilidad” se comunica como índice simulado, no como probabilidad empírica.
- No se modela vida humana, aterrizaje real, metabolismo, radiación dosis-respuesta ni viabilidad agrícola marciana.

## Verificación y límites

Las pruebas automatizadas cubren motor, equilibrio, recursos, roles, temporizadores, recorridos y puntos de entrada, colisiones, guardado y clasificación de finales. La comprobación en navegador recorre el prólogo, la reparación con Pip y el cuidado del semillero con Nim mediante navegación real por objetos, además de revisar los recuerdos guardados. El recorrido completo de la interfaz v13 y las pruebas móviles siguen pendientes. La experiencia emocional sigue pendiente de evaluación con personas ajenas al desarrollo; no se promete que provoque la misma reacción que los juegos citados.

Esta versión implementa un alcance jugable del GDD, no una reproducción literal de todos sus efectos cinematográficos. No incluye doblaje, acceso a archivos del sistema, monitor CRT configurable, animación manual de agentes judiciales cuadro por cuadro, simulación física orbital ni multijugador en línea. Debe seguir probándose en teléfonos y con tecnologías de asistencia.

La publicación permanece privada. El acceso GitHub disponible solo incluía `kiarastem/Pong-camara`, por lo que no se alteró ese proyecto. Un repositorio de BeeYond Mars accesible sigue siendo necesario para completar el envío a GitHub.

# BeeYond Mars · Mission Aurelia – GameMaker (v11)

Juego para NASA Space Apps 2026, reto *Space Mission Design Game*. Esta versión usa el «Listado de decisiones» actualizado del equipo y los assets de la v6.

## Cómo abrirlo
1. Abrir GameMaker (2024 o más nuevo).
2. **File > Open** y elegir `BeeYondMarsGM.yyp`.
3. **Run** (F5).

> **Ojo:** el proyecto se armó fuera del IDE y todavía no se ha abierto en GameMaker. La lógica y las pantallas se probaron con un simulador que traduce el GML a JavaScript, juega partidas completas y saca capturas. Si GameMaker muestra un error, copien el mensaje exacto.
>
> **Si la música no suena** (el formato de los sonidos `.yy` no se pudo probar en el IDE): borren los sonidos del proyecto, importen de nuevo los WAV de la carpeta `audio/` con los mismos nombres (`snd_music`, `snd_voyage`, `snd_click`, `snd_coin`, `snd_alert`, `snd_success`, `snd_launch`) y vuelvan a correr.

## Cambios de la v11 (revisión de juego)
- **Ventana:** el juego está diseñado a 1600×900. En pantallas más chicas ahora la ventana se achica y se centra sola. F11 o F4 (o MENU) lo pone en pantalla completa.
- **Regla de energía del equipo:** el despegue se bloquea si la potencia × 0,85 (multiplicador de órbita) no cubre el consumo. Antes se podía despegar y la misión fallaba a los 60 días.
- **Vanguardia:** con esa regla, sola usa 500 de 510 W. Para llevar antena necesita los paneles extra, como dice la tabla.
- **Semilla:** cada vez que se abre el juego la misión usa una semilla distinta (antes era siempre la misma).
- **Avisos:** los mensajes cortos aparecen arriba y ya no tapan el texto.
- **Informe:** los días muestran el total con retrasos (antes decía 284/272).
- `SUBMISSION.md` trae un borrador en inglés para el formulario: resumen, datos NASA, referencias y uso de IA.

## Link público
Hay que exportarlo a web: GX.games (da un link directo) o HTML5 (se sube a Vercel, Netlify o GitHub Pages). Prueben el link en una ventana privada.

## Flujo del juego
1. **Título:** botón MUSIC ON/OFF. El volumen general se ajusta en MENU (parte en 50 %).
2. **Carta de Aurelia, la agencia espacial (ficticia):** se escribe sola y avisa que la propuesta fue FINANCIADA, con 900 créditos y sello FUNDED. Aquí se elige cuántas personas juegan (1 a 4).
3. **Laboratorio:** se camina con WASD o flechas y se interactúa con E o Enter. El recuadro «Your next step» muestra una pista (TIP) que cambia según el diseño. Estaciones:
   - Taller (Ingeniería): paneles extra, sensor térmico redundante, kit de reparación.
   - Biología: Cámara A Económica o Cámara B Vanguardia.
   - Enlace (Comunicaciones): antena de alta ganancia, comunicaciones de respaldo, dosímetro.
   - Dirección: revisiones CML 2 y 3 (+150 y +200 créditos), las 3 rutas del Trajectory Browser, pista y controles de lanzamiento.
4. **Despegue:** cuenta regresiva, motor y humo.
5. **Viaje:** etapas de 30 días con una frase «Did you know?» con datos de la NASA. Hay tres tipos de eventos.
6. **Informe y paper:** la historia es un equipo que quiere publicar el primer estudio sobre llevar reinas en diapausa a Marte. La bitácora tiene formato de paper y 5 páginas:
   - Página 1: título, autores, Abstract y 1. Introduction.
   - Página 2: 2. Methods (nave, fórmula del Δv y ruta NASA) y 3. Results (tabla por etapa).
   - Página 3: 3.1 Events, 4. Discussion y References.
   - Página 4: **5. Conclusions**, escritas según lo que hizo el equipo (estado de las reinas, margen de Δv en la ruta NASA, energía, datos y comunicaciones).
   - Página 5: **Peer review**, la retroalimentación al equipo: «What worked» y «What to improve», con un sello ACCEPTED, MAJOR REVISIONS o REJECTED del *Journal of Pollinator Spaceflight* (ficticio).
   - Al terminar la misión, el paper se abre solo en las conclusiones. La bitácora se puede abrir en cualquier momento con LOGBOOK.
7. **Siguiente fase: invernadero en Marte (extensión hipotética).** Se abre desde el informe con NEXT PHASE: GREENHOUSE si la nave llegó y la carga no quedó comprometida.
   - El índice de colonia parte en 100 menos el riesgo del viaje.
   - El equipo tiene de 2 a 4 celdas de energía: 2 de base, +1 si la batería terminó con 800 Wh o más, +1 si la nave conservó 80 % de integridad.
   - Hay 4 decisiones, una por rol. La opción cuidadosa gasta una celda; la otra es gratis.
     - Biología: despertar a las reinas lento (+15) o rápido (−15).
     - Ingeniería: clima estable (+15) o dejar que varíe de noche (−20).
     - Dirección: luces de cultivo para las flores de tomate (+10 y prueba de polinización) o solo luz natural (−10).
     - Comunicaciones: enviar todos los datos (+50 de ciencia) o un resumen (+10).
   - Resultado: colonia fundada (60 o más), reinas despiertas sin colonia (35 a 59) o no se recuperan. Hay polinización si la colonia se funda y se encendieron las luces.
   - El resultado se suma a las conclusiones y a la revisión del paper.
   - El invernadero es cerrado: no se libera nada en Marte. Todo está marcado como hipotético y los valores son reglas del juego.
8. **Rediseñar:** vuelve al laboratorio con las piezas y los fondos ganados.

## Valores (tabla actualizada del equipo)
Costos: Bajo 50 · Medio 150 · Alto 300 · Muy alto 400. Δv = 7,0 − 0,008 × kg (90 kg = −0,72 km/s, como en la tabla).

| Pieza | Rol | Costo | Peso | Energía |
|---|---|---|---|---|
| Cámara A – Económica | Biología | 150 | 135 kg | −200 W |
| Cámara B – Vanguardia | Biología | 300 | 90 kg | −500 W |
| Paneles solares extra | Ingeniería | 400 | 70 kg | +400 W |
| Sensor térmico redundante | Ingeniería | 150 | 0,3 kg | −20 W |
| Kit de reparación | Ingeniería | 150 | 20 kg | −5 W |
| Antena de alta ganancia | Comunicaciones | 300 | 60 kg | −80 W |
| Comunicaciones de respaldo | Comunicaciones | 150 | 25 kg | −40 W |
| Dosímetro | Comunicaciones | 50 | 0,3 kg | −10 W |

**Cohete:** 250 kg, 7,0 km/s y 600 W. Rutas del NASA Ames Trajectory Browser:
- Ruta 1: 4,79 km/s, 288 días.
- Ruta 2: 4,84 km/s, 272 días.
- Ruta 3 (Venus): 6,82 km/s, 352 días.

## Eventos (como los describió el equipo)
- **Alerta de estrés térmico:**
  - Cámara Económica: 2 alarmas (al 35 % y al 70 % del viaje).
  - Con el sensor térmico, se autorregula (+10 W).
  - Sin el sensor, el jugador elige entre reparar con el kit, enfriamiento de emergencia con batería o aguantar (+35 de riesgo).
  - Con la Vanguardia, se corrige sola en minutos.
- **Pérdida de señal con la Deep Space Network:** ocurre entre el 45 % y el 65 % del viaje.
  - Con respaldo de comunicaciones, el enlace secundario toma el control y se pierde un 10 % de los datos.
  - Solo con antena: se elige entre esperar que la antena se realinee (+12 días; +6 con el dosímetro) o enviar solo lo esencial.
  - Sin antena ni respaldo, se pierde el contacto y la misión falla.
- **Falla mecánica («¡Impacto menor detectado!»):** ocurre en un día al azar con semilla (la semilla queda en el paper).
  - Con el kit: una acción de reparación.
  - Sin el kit: desviar energía (−20 % de integridad) o seguir, y el daño crece cada etapa.

## Resultados del simulador
| Diseño | Ruta | Resultado |
|---|---|---|
| Económica + antena + kit | Rápida | Éxito, 228 puntos, ACCEPTED |
| Económica + respaldo + kit + sensor + dosímetro | Estándar | Éxito, 256 puntos, ACCEPTED |
| Económica + antena, sin sensor ni kit | Estándar | Falla por clima, REJECTED |
| Vanguardia sola, sin comunicaciones | Estándar | Falla: contacto perdido, REJECTED |
| Vanguardia + paneles + respaldo | Rápida | Éxito, 231 puntos, ACCEPTED |
| Vanguardia + antena sin paneles (595 W) | Estándar | No despega: cerca de Marte solo hay 510 W |
| Cualquier nave | Ruta 3 | No despega (ver abajo) |
| Económica + paneles + antena (265 kg) | Estándar | No despega por peso |

## Para revisar en el equipo
- **Ruta 3:** con 0,008 km/s por kg, la nave tendría que pesar 22 kg o menos para alcanzar 6,82 km/s. Como la cámara más liviana pesa 90 kg, la Ruta 3 nunca se puede tomar. El juego la muestra y lo explica en una pista. Para hacerla posible habría que bajar la penalización o subir el Δv del cohete.
- **Cámaras:** el documento trae tres versiones. Vanguardia: 70, 90 o 95 kg. Económica: 130 o 135 kg. Se usó la tabla actualizada del inventario (90 y 135 kg, 500 y 200 W).
- **«Supervivencia 100 % garantizada»:** el juego no lo afirma. La Vanguardia no tiene problemas térmicos, pero el resultado sigue siendo un índice del modelo.
- **Dosímetro:** la tabla dice 0,3 kg y −0,04 km/s, pero 0,3 kg × 0,008 da −0,002 km/s. Se usó la fórmula.
- **Puntos:** la tabla no definía la «Asignación de puntos». Se usa: llegar +100, (100 − riesgo), datos recibidos ÷ 4, menos datos perdidos ÷ 4, y dosímetro +50 (+100 en la Ruta 3).

## Créditos
- Idea, historia, mecánicas y valores: equipo BeeYond Mars.
- Arte de la v6 (abejas, fondos, personajes, íconos): asistido por IA, con la marca «AI» visible. El cohete del despegue se recortó del fondo `launch`.
- Música y efectos: chiptune original generado por código para este proyecto (`audio/`, sin música de terceros).
- Código desarrollado con ayuda de IA (OpenAI Codex, Claude) y revisado por el equipo.
- Sin logos de la NASA; la agencia espacial Aurelia y el Dr. Pollen son ficticios. La misión es hipotética.
- El juego está solo en inglés: la fuente pixel no tiene tildes ni ñ, y las bases piden inglés.

# Evidencia de las rutas del NASA Ames Trajectory Browser

**Consulta revisada:** 15 nov 2026.
**Fuente primaria:** [NASA Ames Trajectory Browser](https://trajbrowser.arc.nasa.gov/traj_browser.php?DTunit=yrs&LD1=2029&LD2=2040&chk_target_list=on&maxDT=1.5&maxDV=7.0&maxMag=25&maxOCC=4&min=DT&mission_class=oneway&mission_type=rendezvous&submit=Search&target_list=Mars&wdw_width=-1).

La consulta pide trayectorias de tipo **one-way rendezvous** con Marte y muestra las filas elegidas para el juego. Las cifras coinciden con `ROUTES` en `dist/data.js`:

| Ruta representada | Salida | Llegada | Duración | Inyección | Postinyección | Total usado en juego |
|---|---|---|---:|---:|---:|---:|
| Estándar Tierra–Marte | 21 dic 2030 | 5 oct 2031 | 288 días | 3.68 km/s | 1.11 km/s | 4.79 km/s |
| Rápida Tierra–Marte | 21 dic 2030 | 19 sep 2031 | 272 días | 3.71 km/s | 1.13 km/s | 4.84 km/s |
| Asistencia gravitatoria Venus | 20 feb 2030 | 7 feb 2031 | 352 días | 4.81 km/s | 2.01 km/s | 6.82 km/s |

En el juego, el `delta-v` consultado se usa como umbral de ruta. El modelo de lanzador (`7.0 km/s` menos penalización por masa) y las demás reglas de masa, potencia y fondos son supuestos educativos del equipo. El `delta-v` del navegador parte de órbita baja terrestre de 200 km; no se debe presentar como validación del vehículo ficticio ni como análisis de misión real.

## Reproducción

Abrir el enlace oficial de la fuente y conservar sus parámetros. El URL contiene el rango de años, duración máxima, presupuesto de `delta-v`, clase de misión, tipo rendezvous y objetivo Marte. En la tabla del navegador, comparar fechas, tiempo de vuelo, inyección y postinyección con las filas anteriores. La app guarda esas seis columnas de ruta en `dist/data.js`; `dist/sources.json` conserva el enlace y el límite de interpretación.

La consulta depende de la interfaz/servicio del navegador y puede cambiar si sus datos o filtros cambian. Si deja de mostrar las filas, no sobrescribir los valores en silencio: guardar una captura/descarga de la nueva respuesta, registrar la fecha y actualizar este documento, `data.js`, `sources.json` y la explicación del submission en un mismo cambio.

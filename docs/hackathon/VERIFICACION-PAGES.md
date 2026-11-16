# Verificación de recursos y misión en Pages

15 noviembre 2026. URL: https://xaxavierjs.github.io/BeeYond-Mars/ . Corrección del juego: commit 9389a7e.

## Corrección

Se recuperó `dist/assets/bees-v6.png` de `assets/bees-v6.png` y `dist/assets/aurelia-pixel.ttf` del commit de la entrega `fbbde3d`. No se generó arte, no se sustituyeron sprites ni se modificaron CSS, proporciones o reglas de misión.

## Evidencia obtenida

- Navegador Chromium/Brave aislado contra la URL pública, sin sesión GitHub.
- 120 recursos revisados: atlas, tipografía y archivos de `assets/gm/`, todos con respuesta correcta. Referencias estáticas encontradas en JS/CSS/HTML resolvieron localmente.
- Inicio de partida y menú: sin excepciones de JavaScript ni respuestas HTTP de error observadas.
- Vistas 1280×720 y 390×844: se conservaron proporciones y no hubo desbordamiento horizontal en móvil. No equivale a interacción táctil en teléfono real.
- Con checkpoint de laboratorio y diseño preparado (Atlaswing/heavy, Vanguard, antena, kit y dosímetro), la UI permitió lanzar, saltar cinemática, avanzar, resolver comunicaciones con realineación y daño mecánico con reparación, llegar al informe a los 300 días, abrir invernadero, elegir cuatro cuidados, alcanzar el final y rediseñar al laboratorio. Se usaron puntos de guardado preparados para colocar al personaje junto a objetos entre etapas; no se validó caminando cada trayecto ni la introducción completa desde cero.
- Motor descargado desde Pages: llegada exitosa, cuatro cuidados, epilogue válido y redesign→lab.
- `npm run test:story`: cuatro pruebas pasan. La suite antigua de motor sigue fuera del alcance de esta reparación de recursos.

Capturas: [inicio escritorio](evidencia/inicio-escritorio.png), [inicio móvil](evidencia/inicio-movil.png), [informe](evidencia/informe-pages.png), [final](evidencia/final-pages.png).

## Límites pendientes

Introducción y encuentros completos sin checkpoints, todas las variantes de fracaso, todos los ajustes de accesibilidad, audio escuchado por una persona, controles táctiles físicos y otros navegadores. Esta verificación demuestra el flujo de misión descrito; no certifica todos los estados posibles del juego.

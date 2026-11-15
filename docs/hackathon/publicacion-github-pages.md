# Publicación web en GitHub Pages

El repositorio público del juego es <https://github.com/XaxavierJS/BeeYond-Mars>. La web todavía no se considera publicada: Pages no estaba habilitado en GitHub durante la auditoría.

## Preparación incluida

El workflow [deploy-pages.yml](../../.github/workflows/deploy-pages.yml) carga el contenido estático de `dist/` y lo publica con GitHub Pages. No se ejecuta con commits ni pull requests normales: se puede lanzar desde Actions o con la etiqueta de publicación `spaceapps-web-2026`. Las rutas de la aplicación son relativas, por lo que funcionan bajo la ruta del proyecto en Pages.

## Activación por una persona con permisos del repositorio

1. En GitHub, abrir **Settings → Pages** y elegir **GitHub Actions** como fuente de publicación.
2. Confirmar que los cambios aprobados ya están en la rama `main`.
3. Abrir **Actions → Deploy web game to GitHub Pages → Run workflow**, elegir `main` y ejecutar; o crear y subir la etiqueta `spaceapps-web-2026` sobre el commit aprobado para iniciar la ejecución manualmente desde Git.
4. Esperar que ambos trabajos terminen correctamente y abrir la URL que muestra GitHub, en una ventana privada.
5. Probar portada, una estación, diseño, selección de ruta, vuelo, informe, audio y controles táctiles/teclado. Guardar captura y registrar fecha/build.
6. Solo después de esa revisión, copiar la URL efectiva a `BeeYondMarsGM/SUBMISSION.md` y al formulario de Space Apps.

La URL esperada para este repositorio es <https://xaxavierjs.github.io/BeeYond-Mars/>, pero no debe compartirse como URL operativa hasta que Pages esté habilitado y el primer despliegue se verifique desde fuera de GitHub.

## Actualizaciones

Cada publicación posterior requiere iniciar el workflow manualmente o volver a crear explícitamente la etiqueta `spaceapps-web-2026`. El flujo no impone una aprobación de varias personas en GitHub; coordinar la revisión del equipo antes de ejecutarlo. Antes de publicar, revisar el cambio en el juego, actualizar el `CHANGELOG` o documentación pertinente y correr `npm test`. Si la build se publica desde otra rama o cambia de ubicación, actualizar `path` y esta guía juntos.

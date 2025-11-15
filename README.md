# ArgoCD con KSOPS y Age

Imagen Docker personalizada de ArgoCD que incluye soporte para KSOPS (Kustomize SOPS) y Age, permitiendo la gestión segura de secretos encriptados en repositorios GitOps.

## Descripción

Este proyecto proporciona una imagen Docker basada en ArgoCD v2.11.3 con las siguientes herramientas adicionales:

- **KSOPS v4.3.3**: Plugin de Kustomize para manejar archivos encriptados con SOPS
- **Age v1.2.1**: Herramienta de encriptación moderna y simple
- **Plugin personalizado**: ConfigManagementPlugin configurado para ArgoCD

## Características

- ✅ ArgoCD v2.11.3
- ✅ KSOPS v4.3.3 integrado
- ✅ Age v1.2.1 para encriptación/desencriptación
- ✅ Plugin de gestión de configuración preconfigurado
- ✅ Listo para usar en entornos GitOps

## Requisitos

- Docker
- Acceso a repositorios Git con secretos encriptados con SOPS/Age

## Uso

### Construcción de la imagen

```bash
docker build -t argocd-ksops:latest .
```

### Ejecución

```bash
docker run -d \
  --name argocd \
  -p 8080:8080 \
  -p 8083:8083 \
  argocd-ksops:latest
```

### Configuración en ArgoCD

El plugin KSOPS ya está configurado y disponible en la ruta `/home/argocd/cmp-plugins/ksops/plugin.yaml`.

Para usar el plugin en tus aplicaciones de ArgoCD, agrega la siguiente anotación a tu Application:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: mi-aplicacion
  annotations:
    argocd.argoproj.io/config-management-plugin: ksops
spec:
  # ... configuración de tu aplicación
```

## Estructura del Proyecto

```
argocd-ksops/
├── Dockerfile              # Imagen Docker personalizada
├── ksops-plugin.yaml       # Configuración del plugin para ArgoCD
├── LICENSE                 # Licencia MIT
└── README.md              # Este archivo
```

## Versiones Incluidas

- **ArgoCD**: v2.11.3
- **KSOPS**: v4.3.3
- **Age**: v1.2.1

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.

## Autor

**Migbertweb**

## Repositorio

https://github.com/migbertweb/argocd-ksops

## Notas

- Este proyecto usa Licencia MIT. Se recomienda (no obliga) mantener derivados como código libre, especialmente para fines educativos.
- Asegúrate de tener las claves Age necesarias configuradas en tu entorno para desencriptar los secretos.

## Contribuciones

Las contribuciones son bienvenidas. Por favor, abre un issue o pull request en el repositorio.

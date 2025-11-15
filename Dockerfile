# Archivo: Dockerfile
# Descripción: Dockerfile personalizado para crear una imagen de ArgoCD con soporte para KSOPS y Age.
#              Extiende la imagen oficial de ArgoCD v2.11.3 e instala las herramientas necesarias
#              para manejar secretos encriptados con SOPS/Age en repositorios GitOps.
# Autor: migbertweb
# Fecha: 2024
# Repositorio: https://github.com/migbertweb/argocd-ksops
# Licencia: MIT License
#
# Uso: Construye una imagen Docker personalizada de ArgoCD que incluye KSOPS v4.3.3 y Age v1.2.1,
#      permitiendo la gestión segura de secretos encriptados en aplicaciones GitOps.
#
# Nota: Este proyecto usa Licencia MIT. Se recomienda (no obliga) mantener 
#       derivados como código libre, especialmente para fines educativos.

FROM quay.io/argoproj/argocd:v2.11.3

USER root

# Instalar herramientas básicas
RUN apt-get update && \
    apt-get install -y curl tar bash && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar age y age-keygen (v1.2.1)
RUN curl -sSL https://github.com/FiloSottile/age/releases/download/v1.2.1/age-v1.2.1-linux-amd64.tar.gz \
    | tar -xz -C /tmp && \
    mv /tmp/age/age /usr/local/bin/ && \
    mv /tmp/age/age-keygen /usr/local/bin/ && \
    chmod +x /usr/local/bin/age /usr/local/bin/age-keygen

# Instalar ksops (v4.3.3)
RUN curl -sSL https://github.com/viaduct-ai/kustomize-sops/releases/download/v4.3.3/ksops_latest_Linux_x86_64.tar.gz \
    | tar -xz -C /usr/local/bin ksops && \
    chmod +x /usr/local/bin/ksops

# Crear carpeta para el plugin personalizado de ksops
RUN mkdir -p /home/argocd/cmp-plugins/ksops
COPY ksops-plugin.yaml /home/argocd/cmp-plugins/ksops/plugin.yaml

# Establecer permisos correctos
RUN chown -R argocd:argocd /home/argocd/cmp-plugins

USER argocd

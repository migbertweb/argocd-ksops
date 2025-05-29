FROM quay.io/argoproj/argocd:v3.0.4

USER root

# Instalar age y age-keygen
RUN curl -sSL https://github.com/FiloSottile/age/releases/download/v1.2.1/age-v1.2.1-linux-amd64.tar.gz \
    | tar -xz -C /usr/local/bin --strip-components=1 age/age age/age-keygen

# Instalar ksops
RUN curl -sSL https://github.com/viaduct-ai/kustomize-sops/releases/latest/download/ksops-linux-amd64 \
    -o /usr/local/bin/ksops && chmod +x /usr/local/bin/ksops

# Crear carpeta para el plugin
RUN mkdir -p /home/argocd/cmp-plugins/ksops

# Copiar el plugin
COPY ksops-plugin.yaml /home/argocd/cmp-plugins/ksops/plugin.yaml

# Permisos correctos
RUN chown -R argocd:argocd /home/argocd/cmp-plugins

USER argocd

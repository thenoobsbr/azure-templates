FROM mcr.microsoft.com/dotnet/runtime:#{IMAGE_VERSION}#
WORKDIR /app
EXPOSE 80

# Instala dependências
RUN apk add --no-cache \
    ca-certificates \
    curl \
    icu-libs \
    krb5-libs \
    libgcc \
    libicu \
    libintl \
    libssl3 \
    libstdc++ \
    postgresql-libs \
    procps \
    zlib

# Copia o executável efbundle
COPY efbundle /app/efbundle

# Cria entrypoint script dinâmico
RUN printf '#!/bin/sh\n/app/efbundle --connection "$CONNECTION_STRING" --verbose\n' > /app/entrypoint.sh && \
    chmod +x /app/entrypoint.sh && \
    chmod +x /app/efbundle

ENTRYPOINT ["/app/entrypoint.sh"]
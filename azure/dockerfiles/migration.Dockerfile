FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
EXPOSE 80

# Instala dependências
# RUN apk add --no-cache icu-libs krb5-libs libc6-compat libintl libssl3

# Copia o executável efbundle
COPY efbundle /app/efbundle

# Cria entrypoint script dinâmico
RUN printf '#!/bin/sh\n/app/efbundle --connection "$CONNECTION_STRING" --verbose\n' > /app/entrypoint.sh && \
    chmod +x /app/entrypoint.sh && \
    chmod +x /app/efbundle

ENTRYPOINT ["/app/entrypoint.sh"]
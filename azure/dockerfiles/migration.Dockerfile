FROM mcr.microsoft.com/dotnet/aspnet:${IMAGE_VERSION}
WORKDIR /app
EXPOSE 80

# Copia o executável efbundle
COPY efbundle /app/efbundle

# Cria entrypoint script dinâmico
RUN printf '#!/bin/sh\n/app/efbundle --apply --connection "$CONNECTION_STRING"\n' > /app/entrypoint.sh && \
    chmod +x /app/entrypoint.sh && \
    chmod +x /app/efbundle

ENTRYPOINT ["/app/entrypoint.sh"]
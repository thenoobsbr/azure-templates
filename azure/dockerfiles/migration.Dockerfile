FROM mcr.microsoft.com/dotnet/aspnet:#{IMAGE_VERSION}#
WORKDIR /app
EXPOSE 80

COPY efbundle /app/efbundle

RUN echo "#!/bin/bash\n\
  /app/efbundle\
  --apply\
  --connection ${CONNECTION_STRING}" > /app/entrypoint.sh &&\
  chmod +x /app/entrypoint &&\
  chmod +x /app/efbundle

ENTRYPOINT ["/app/entrypoint"]
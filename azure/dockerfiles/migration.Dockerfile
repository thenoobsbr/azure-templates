FROM mcr.microsoft.com/dotnet/aspnet:#{IMAGE_VERSION}#
WORKDIR /app
EXPOSE 80

COPY efbundle /app/efbundle

RUN chmod +x /app/efbundle 

ENTRYPOINT ["/app/efbundle", "--apply", "--connection", "#{CONNECTION_STRING}#"]
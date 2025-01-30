ARG IMAGE_VERSION

FROM mcr.microsoft.com/dotnet/aspnet:${IMAGE_VERSION}
WORKDIR /app
EXPOSE 80

COPY . .
COPY entrypoint.sh ./entrypoint.sh

ENV ASPNETCORE_HTTP_PORTS=80
ENV ASPNETCORE_ENVIRONMENT=Production

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
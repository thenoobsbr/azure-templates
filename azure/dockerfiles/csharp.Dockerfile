ARG IMAGE_VERSION

FROM mcr.microsoft.com/dotnet/aspnet:${IMAGE_VERSION}
WORKDIR /app
EXPOSE 80

RUN apk update && apk add --no-cache bash

COPY . .

ENV ASPNETCORE_HTTP_PORTS=80
ENV ASPNETCORE_ENVIRONMENT=Production

RUN chmod +x entrypoint.sh

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
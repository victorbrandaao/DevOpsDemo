# Etapa 1: Build
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# copia o csproj (estando no mesmo diretório do Dockerfile)
COPY *.csproj ./
RUN dotnet restore

# copia todo o restante do projeto
COPY . ./
RUN dotnet publish -c Release -o out

# Etapa 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
ENV ASPNETCORE_URLS="http://+:80"
EXPOSE 80
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "DevOpsDemo.dll"]

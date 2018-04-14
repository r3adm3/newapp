FROM techfrontier.azurecr.io/microsoft/aspnetcore-build AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM techfrontier.azurecr.io/microsoft/aspnetcore
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "newapp.dll"]

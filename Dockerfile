# # this is docker multi-stage 1 , is build env
# # images source => mcr.microsoft.com/dotnet/core/sdk:2.2 微軟提供
# FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
# MAINTAINER maxhuang@pershing.com.tw
# WORKDIR /app

# # copy csproj and restore as distinct layers
# COPY *.sln .
# COPY NetCoreWebApplication/*.csproj ./NetCoreWebApplication/
# RUN dotnet restore

# # copy everything else and build app
# COPY NetCoreWebApplication/. ./NetCoreWebApplication/
# WORKDIR /app/NetCoreWebApplication
# RUN dotnet publish -c Release -o out

#=====================================================================

# this is docker multi-stage 2 (--from=build) 
# images source => mcr.microsoft.com/dotnet/core/aspnet:2.2 微軟提供
# 複製在 build裡面/app/NetCoreWebApplication/out 資料 到這裡的./根目錄
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS runtime
WORKDIR /app
#COPY --from=build /app/NetCoreWebApplication/out ./ #is (--from=build) 
COPY NetCoreWebApplication/out ./
ENTRYPOINT ["dotnet", "NetCoreWebApplication.dll"]
EXPOSE 80

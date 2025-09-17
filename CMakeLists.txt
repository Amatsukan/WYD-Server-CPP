
# Versão mínima do CMake e nome do projeto
cmake_minimum_required(VERSION 3.10)
project(WYD-Server)

# Define o padrão C++ para C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Adiciona o diretório 'Code' para que includes como "Basedef.h" sejam encontrados
include_directories(Code)

# Cria uma biblioteca estática chamada 'Common' com os arquivos compartilhados
add_library(Common STATIC
    Code/Basedef.cpp
    Code/CPSock.cpp
)

# A biblioteca 'Common' precisa da biblioteca de sockets do Windows (ws2_32)
target_link_libraries(Common
    ws2_32
)

# Adiciona os subdiretórios que contêm os servidores
add_subdirectory(Code/DBSrv)
add_subdirectory(Code/TMSrv)

# Define a versão mínima do CMake e o nome do projeto.
cmake_minimum_required(VERSION 3.10)
project(DBSrv CXX)

# Adiciona o executável, marcando-o como um aplicativo WIN32 (para usar WinMain)
# O nome do alvo não deve incluir .exe; o CMake adiciona isso automaticamente.
add_executable(DBSrv WIN32
    # Fontes do DBSrv
    CFileDB.cpp
    CRanking.cpp
    CReadFiles.cpp
    CUser.cpp
    Server.cpp
    DBSrv.rc

    # Fontes da "Common"
    common.lib/Basedef.cpp
    common.lib/CPSock.cpp
)

# Adiciona os diretórios que contêm arquivos de cabeçalho (.h).
target_include_directories(DBSrv PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/common.lib
)

# Linka as bibliotecas necessárias do Windows
target_link_libraries(DBSrv PRIVATE
    ws2_32      # Para funções de rede (Winsock)
    winmm       # Para timeGetTime
)

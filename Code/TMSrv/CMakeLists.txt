
# Encontra todos os arquivos .cpp e .h no diretório atual
file(GLOB_RECURSE SOURCES "*.cpp" "*.h")

# Adiciona o executável para o TMSrv
add_executable(TMSrv.exe ${SOURCES})

# Linka a biblioteca 'Common' ao TMSrv.
target_link_libraries(TMSrv.exe Common)

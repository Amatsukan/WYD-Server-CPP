
# Encontra todos os arquivos .cpp e .h no diretório atual
file(GLOB_RECURSE SOURCES "*.cpp" "*.h")

# Adiciona o executável para o DBSrv
add_executable(DBSrv.exe ${SOURCES})

# Linka a biblioteca 'Common' ao DBSrv. 
# O CMake garante que o DBSrv terá acesso ao código e às dependências do Common (como ws2_32)
target_link_libraries(DBSrv.exe Common)

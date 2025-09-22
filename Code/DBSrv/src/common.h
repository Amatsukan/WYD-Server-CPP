#pragma once

// Includes Padrão do C++
#include <iostream>
#include <string>
#include <vector>
#include <memory>
#include <thread>
#include <mutex>
#include <chrono>
#include <functional>
#include <atomic>
#include <fstream>
#include <sstream>
#include <iomanip>

// Includes do Windows e Sockets
#ifdef _WIN32
#include <winsock2.h>
#include <ws2tcpip.h>
#pragma comment(lib, "ws2_32.lib")
#endif

// Includes do Projeto Antigo (adapte os paths conforme necessário)
// Assumindo que a pasta 'src' está no mesmo nível que a pasta com 'Basedef.h'
#include "../../Basedef.h"
#include "../../CPSock.h"
#include "../../ItemEffect.h"
#include "CUser.h" // Ainda usado para a estrutura, pode ser refatorado depois
#include "CFileDB.h" // Mantido por enquanto

// Constantes
constexpr int SERVER_TICK_RATE_MS = 1000;

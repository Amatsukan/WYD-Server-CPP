#pragma once
#include "../common.h"

class SessionManager; // Forward declaration

class MessageHandler {
public:
    // O ideal seria passar uma referência para o Server ou SessionManager
    // para que esta classe possa interagir com o resto do sistema.
    void processClientMessage(int sessionId, char* msg);
    void processAdminMessage(int sessionId, char* msg);

private:
    // Instância de CFileDB, como no código original.
    // Esta classe provavelmente precisará de uma refatoração futura.
    CFileDB cFileDB;
};

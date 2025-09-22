#pragma once
#include "common.h"
#include "config/ConfigManager.h"
#include "log/Logger.h"
#include "network/NetworkManager.h"
#include "session/SessionManager.h"
#include "message/MessageHandler.h"
#include "task/TaskManager.h"

class Server {
public:
    Server();
    ~Server();

    bool init();
    void run();
    void shutdown();

    // Chamado pelo TaskManager
    void processTick();

private:
    // Callbacks para o NetworkManager
    void onClientConnect(int sessionId);
    void onClientDisconnect(int sessionId);
    void onClientData(int sessionId);

    void onAdminConnect(int sessionId);
    void onAdminDisconnect(int sessionId);
    void onAdminData(int sessionId);

    void handleConsoleInput();

    std::atomic<bool> m_isRunning{false};
    
    ConfigManager m_config;
    SessionManager m_userSessions;
    SessionManager m_adminSessions;
    NetworkManager m_network;
    MessageHandler m_messageHandler;
    TaskManager m_taskManager;
    
    std::thread m_consoleThread;
};

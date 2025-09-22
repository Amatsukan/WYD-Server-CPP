#include "Server.h"
#include "../../Basedef.h" // Ajuste de path para o legacy
#include "CReadFiles.h" // Para as tarefas periódicas

Server::Server()
    : m_userSessions(MAX_SERVER),
      m_adminSessions(MAX_ADMIN),
      m_network(m_userSessions, m_adminSessions),
      m_taskManager(*this) {}

Server::~Server() {
    shutdown();
}

bool Server::init() {
    Logger::Init("DBServidor.log");
    Logger::Log("Iniciando servidor...", "Server");

    if (!m_config.load("Config.txt")) {
        return false;
    }

    // Carregar dados do jogo (antigo código de WinMain)
    // TODO: Mover isso para uma classe GameDataManager
    BASE_InitModuleDir();
    BASE_InitializeBaseDef();

    // Configura os callbacks que o NetworkManager usará
    m_network.setCallbacks(
        [this](int id) { this->onClientConnect(id); },
        [this](int id) { this->onClientDisconnect(id); },
        [this](int id) { this->onClientData(id); }
        // TODO: Callbacks separados para Admins
    );

    if (!m_network.start(DB_PORT, ADMIN_PORT)) {
        return false;
    }

    m_taskManager.start();

    return true;
}

void Server::run() {
    m_isRunning = true;
    Logger::Log("Servidor em execucao. Digite 'exit' para desligar.", "Server");

    // Thread para ouvir comandos do console
    m_consoleThread = std::thread(&Server::handleConsoleInput, this);

    // Mantém a thread principal viva
    if (m_consoleThread.joinable()) {
        m_consoleThread.join();
    }
}

void Server::shutdown() {
    if (!m_isRunning.exchange(false)) {
        return; // Já está desligando
    }
    
    Logger::Log("Iniciando desligamento...", "Server");
    
    m_taskManager.stop();
    m_network.stop();
    m_config.save("Config.txt");
    Logger::Shutdown();
}

void Server::handleConsoleInput() {
    std::string line;
    while (m_isRunning) {
        std::getline(std::cin, line);
        if (line == "exit") {
            shutdown();
        } else if (line == "status") {
            m_userSessions.printStatus();
            m_adminSessions.printStatus();
        }
    }
}


void Server::processTick() {
    // Esta função é chamada a cada segundo pelo TaskManager
    // TODO: Mover a lógica de CReadFiles para cá
    // CReadFiles::ImportUser();
    // CReadFiles::UpdateUser();
    
    // Imprimir status a cada 30 segundos
    static int secCounter = 0;
    secCounter++;
    if (secCounter % 30 == 0) {
        // m_userSessions.printStatus();
    }
}

void Server::onClientConnect(int sessionId) {
    Logger::Log("Cliente conectado no slot " + std::to_string(sessionId), "Server");
    // Lógica adicional, como enviar pacotes de boas-vindas
}

void Server::onClientDisconnect(int sessionId) {
    Logger::Log("Cliente desconectado do slot " + std::to_string(sessionId), "Server");
}

void Server::onClientData(int sessionId) {
    auto session = m_userSessions.getSession(sessionId);
    if (!session) return;
    
    int error = 0, errorCode = 0;
    char* msg = nullptr;
    
    // Processa todas as mensagens completas no buffer
    while ((msg = session->sockHelper.ReadMessage(&error, &errorCode)) != nullptr) {
        m_messageHandler.processClientMessage(sessionId, msg);
    }

    if (error) {
        Logger::Log("Erro de mensagem, desconectando slot " + std::to_string(sessionId), "Server");
        onClientDisconnect(sessionId);
        m_userSessions.removeSession(sessionId);
    }
}

// ... Implementar onAdminConnect, onAdminDisconnect, onAdminData ...
void Server::onAdminConnect(int sessionId) {}
void Server::onAdminDisconnect(int sessionId) {}
void Server::onAdminData(int sessionId) {}

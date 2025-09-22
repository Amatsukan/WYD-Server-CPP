#include "MessageHandler.h"
#include "../log/Logger.h"
#include "../session/SessionManager.h"

// Esta é a implementação da sua lógica de jogo.
// O código original foi movido para cá.
void MessageHandler::processClientMessage(int sessionId, char *msg) {
	MSG_STANDARD *header = (MSG_STANDARD *)msg;

	if (!(header->Type & FLAG_GAME2DB) || (header->ID < 0) || (header->ID > MAX_USER)) 
	{	
		char temp[256];
		sprintf(temp, "err,packet Type:%d ID:%d Size:%d KeyWord:%d", header->Type, header->ID, header->Size, header->KeyWord);
		Logger::Log(temp, "MessageHandler");
		return;
	}

	cFileDB.ProcessMessage(msg, sessionId);
}

void MessageHandler::processAdminMessage(int sessionId, char *msg) {
    // TODO: Mover a lógica de `ProcessAdminMessage` do Server.cpp original para cá.
    // Exemplo:
    MSG_STANDARD *header = (MSG_STANDARD *)msg;
    Logger::Log("Mensagem de Admin recebida do slot " + std::to_string(sessionId) + " Tipo: " + std::to_string(header->Type), "MessageHandler");
    // ... resto da lógica do switch/case ...
}


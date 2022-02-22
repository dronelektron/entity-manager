#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

#include "em/entity-list"
#include "em/entity"
#include "em/message"
#include "em/storage"
#include "em/use-case"

#include "modules/console-command.sp"
#include "modules/console-variable.sp"
#include "modules/entity-list.sp"
#include "modules/entity.sp"
#include "modules/message.sp"
#include "modules/storage.sp"
#include "modules/use-case.sp"

public Plugin myinfo = {
    name = "Entity manager",
    author = "Dron-elektron",
    description = "Allows you to perform various actions with objects at the beginning of the round",
    version = "0.1.2",
    url = ""
};

public void OnPluginStart() {
    Storage_BuildConfigPath();
    EntityList_Create();
    Command_Create();
    Variable_Create();
    HookEvent("dod_round_start", Event_RoundStart);
    LoadTranslations("entity-manager.phrases");
    AutoExecConfig(true, "entity-manager");
}

public void OnPluginEnd() {
    EntityList_Destroy();
}

public void OnMapStart() {
    UseCase_LoadEntities();
}

public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    UseCase_ApplyActionToEntities();
}

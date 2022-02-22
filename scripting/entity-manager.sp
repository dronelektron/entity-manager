#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

#include "em/entity-list"
#include "em/entity"
#include "em/message"
#include "em/storage"

#include "modules/console-command.sp"
#include "modules/console-variable.sp"
#include "modules/entity-list.sp"
#include "modules/entity.sp"
#include "modules/message.sp"
#include "modules/storage.sp"

public Plugin myinfo = {
    name = "Entity manager",
    author = "Dron-elektron",
    description = "Allows you to perform various actions with objects at the beginning of the round",
    version = "0.1.0",
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
    LoadEntities();
}

public Action Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    Entity_ApplyActions();

    return Plugin_Continue;
}

void LoadEntities() {
    Storage_SaveCurrentMapName();
    Storage_Apply(Storage_LoadEntities);

    int entitiesAmount = EntityList_Size();

    if (entitiesAmount == 0) {
        Message_LogNoEntities();
    } else {
        Message_LogEntitiesLoaded(entitiesAmount);
    }
}

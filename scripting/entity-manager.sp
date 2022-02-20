#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

#include "em/entity-list"
#include "em/entity"
#include "em/message"
#include "em/storage"

#include "modules/console-command.sp"
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

    RegAdminCmd("sm_entitymanager_freeze", Command_Freeze, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_unfreeze", Command_Unfreeze, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_save", Command_Save, ADMFLAG_GENERIC);
    HookEvent("dod_round_start", Event_RoundStart);
    LoadTranslations("entity-manager.phrases");
}

public void OnPluginEnd() {
    EntityList_Destroy();
}

public void OnMapStart() {
    Storage_SaveCurrentMapName();
    Storage_Apply(Storage_LoadEntities);
}

public Action Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    Entity_FreezeAll();

    return Plugin_Continue;
}

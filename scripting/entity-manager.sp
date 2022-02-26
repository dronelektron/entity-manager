#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

#include "em/entity-list"
#include "em/entity"
#include "em/math"
#include "em/menu"
#include "em/message"
#include "em/storage"
#include "em/visualizer"

#include "modules/console-command.sp"
#include "modules/console-variable.sp"
#include "modules/entity-list.sp"
#include "modules/entity.sp"
#include "modules/math.sp"
#include "modules/menu.sp"
#include "modules/message.sp"
#include "modules/storage.sp"
#include "modules/use-case.sp"
#include "modules/visualizer.sp"

public Plugin myinfo = {
    name = "Entity manager",
    author = "Dron-elektron",
    description = "Allows you to perform various actions with objects at the beginning of the round",
    version = "1.0.2",
    url = "https://github.com/dronelektron/entity-manager"
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
    Visualizer_PrecacheTempEntityModels();
    Storage_SaveCurrentMapName();
    UseCase_LoadEntities(CONSOLE);
}

public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    UseCase_ApplyActionToEntities();
}

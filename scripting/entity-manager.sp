#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#undef REQUIRE_PLUGIN
#include <adminmenu>

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
#include "modules/event.sp"
#include "modules/math.sp"
#include "modules/menu.sp"
#include "modules/message.sp"
#include "modules/storage.sp"
#include "modules/use-case.sp"
#include "modules/visualizer.sp"

#define AUTO_CREATE_YES true

public Plugin myinfo = {
    name = "Entity manager",
    author = "Dron-elektron",
    description = "Allows you to perform various actions with objects at the beginning of the round",
    version = "2.0.1",
    url = "https://github.com/dronelektron/entity-manager"
};

public void OnPluginStart() {
    EntityList_Create();
    Command_Create();
    Variable_Create();
    AdminMenu_Create();
    Event_Create();
    LoadTranslations("entity-manager.phrases");
    AutoExecConfig(AUTO_CREATE_YES, "entity-manager");
}

public void OnMapStart() {
    Visualizer_PrecacheTempEntityModels();
    Storage_BuildConfigPath();
    EntityList_Clear();
    UseCase_UpdateEntitiesFromMap(PROP_PHYSICS);
    UseCase_UpdateEntitiesFromMap(PROP_PHYSICS_MULTIPLAYER);
    UseCase_LoadEntities(CONSOLE);
    UseCase_ApplyActionToEntities();
}

public void OnAdminMenuReady(Handle topMenu) {
    AdminMenu_OnReady(topMenu);
}

public void OnLibraryRemoved(const char[] name) {
    if (strcmp(name, ADMIN_MENU) == 0) {
        AdminMenu_Destroy();
    }
}

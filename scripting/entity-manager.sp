#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#undef REQUIRE_PLUGIN
#include <adminmenu>

#include "entity-manager/entity-filter"
#include "entity-manager/entity-list"
#include "entity-manager/entity"
#include "entity-manager/math"
#include "entity-manager/menu-admin"
#include "entity-manager/menu"
#include "entity-manager/message"
#include "entity-manager/storage"
#include "entity-manager/use-case"
#include "entity-manager/visualizer"

#include "modules/console-command.sp"
#include "modules/entity-filter.sp"
#include "modules/entity-list.sp"
#include "modules/entity.sp"
#include "modules/event.sp"
#include "modules/math.sp"
#include "modules/menu-admin.sp"
#include "modules/menu.sp"
#include "modules/message.sp"
#include "modules/sdk-hook.sp"
#include "modules/storage.sp"
#include "modules/use-case.sp"
#include "modules/visualizer.sp"

public Plugin myinfo = {
    name = "Entity manager",
    author = "Dron-elektron",
    description = "Allows you to perform various actions with entities",
    version = "2.0.1",
    url = "https://github.com/dronelektron/entity-manager"
};

public void OnPluginStart() {
    Command_Create();
    EntityFilter_Create();
    EntityList_Create();
    Event_Create();
    LoadTranslations("entity-manager.phrases");
}

public void OnMapStart() {
    EntityList_Clear();
    Visualizer_Precache();
    Storage_BuildConfigPath();
    UseCase_LoadEntities(CONSOLE);
    AdminMenu_Create();
}

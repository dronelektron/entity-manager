static TopMenu g_adminMenu;
static TopMenuObject g_category;
static TopMenuObject g_freezeEntity;
static TopMenuObject g_unfreezeEntity;
static TopMenuObject g_deleteEntity;
static TopMenuObject g_restoreEntity;
static TopMenuObject g_showPath;
static TopMenuObject g_saveEntities;
static TopMenuObject g_loadEntities;

public void OnAdminMenuReady(Handle topMenuHandle) {
    TopMenu topMenu = TopMenu.FromHandle(topMenuHandle);

    if (topMenu != g_adminMenu) {
        g_adminMenu = topMenu;

        FillAdminMenu();
    }
}

public void OnLibraryRemoved(const char[] name) {
    if (StrEqual(name, ADMIN_MENU)) {
        g_adminMenu = null;
    }
}

void AdminMenu_Create() {
    if (LibraryExists(ADMIN_MENU)) {
        TopMenu topMenu = GetAdminTopMenu();

        OnAdminMenuReady(topMenu);
    }
}

bool AdminMenu_Exists() {
    return g_adminMenu != null;
}

void AdminMenu_Show(int client) {
    g_adminMenu.DisplayCategory(g_category, client);
}

static void FillAdminMenu() {
    g_category = g_adminMenu.AddCategory(ENTITY_MANAGER, EntityManager);

    if (g_category != INVALID_TOPMENUOBJECT) {
        g_freezeEntity = AddTopMenuItem(ITEM_ENTITY_FREEZE);
        g_unfreezeEntity = AddTopMenuItem(ITEM_ENTITY_UNFREEZE);
        g_deleteEntity = AddTopMenuItem(ITEM_ENTITY_DELETE);
        g_restoreEntity = AddTopMenuItem(ITEM_ENTITY_RESTORE);
        g_showPath = AddTopMenuItem(ITEM_ENTITY_SHOW_PATH);
        g_saveEntities = AddTopMenuItem(ITEM_ENTITIES_SAVE);
        g_loadEntities = AddTopMenuItem(ITEM_ENTITIES_LOAD);
    }
}

static TopMenuObject AddTopMenuItem(const char[] name) {
    return g_adminMenu.AddItem(name, EntityManager, g_category);
}

static void EntityManager(TopMenu topMenu, TopMenuAction action, TopMenuObject topMenuObject, int param, char[] buffer, int maxLength) {
    if (action == TopMenuAction_DisplayTitle) {
        if (topMenuObject == g_category) {
            FormatEx(buffer, maxLength, "%T", ENTITY_MANAGER, param);
        }
    } else if (action == TopMenuAction_DisplayOption) {
        if (topMenuObject == g_category) {
            FormatEx(buffer, maxLength, "%T", ENTITY_MANAGER, param);
        } else if (topMenuObject == g_freezeEntity) {
            FormatEx(buffer, maxLength, "%T", ITEM_ENTITY_FREEZE, param);
        } else if (topMenuObject == g_unfreezeEntity) {
            FormatEx(buffer, maxLength, "%T", ITEM_ENTITY_UNFREEZE, param);
        } else if (topMenuObject == g_deleteEntity) {
            FormatEx(buffer, maxLength, "%T", ITEM_ENTITY_DELETE, param);
        } else if (topMenuObject == g_restoreEntity) {
            FormatEx(buffer, maxLength, "%T", ITEM_ENTITY_RESTORE, param);
        } else if (topMenuObject == g_showPath) {
            FormatEx(buffer, maxLength, "%T", ITEM_ENTITY_SHOW_PATH, param);
        } else if (topMenuObject == g_saveEntities) {
            FormatEx(buffer, maxLength, "%T", ITEM_ENTITIES_SAVE, param);
        } else if (topMenuObject == g_loadEntities) {
            FormatEx(buffer, maxLength, "%T", ITEM_ENTITIES_LOAD, param);
        }
    } else if (action == TopMenuAction_SelectOption) {
        bool showMenuAgain = true;

        if (topMenuObject == g_freezeEntity) {
            UseCase_FreezeEntity(param);
        } else if (topMenuObject == g_unfreezeEntity) {
            UseCase_UnfreezeEntity(param);
        } else if (topMenuObject == g_deleteEntity) {
            UseCase_DeleteEntity(param);
        } else if (topMenuObject == g_restoreEntity) {
            UseCase_RestoreEntity(param);
        } else if (topMenuObject == g_showPath) {
            if (EntityList_Size() == 0) {
                Message_EntityListEmpty(param);
            } else {
                Menu_ShowPath(param);

                showMenuAgain = false;
            }
        } else if (topMenuObject == g_saveEntities) {
            UseCase_SaveEntities(param);
        } else if (topMenuObject == g_loadEntities) {
            UseCase_LoadEntities(param);
        }

        if (showMenuAgain) {
            AdminMenu_Show(param);
        }
    }
}

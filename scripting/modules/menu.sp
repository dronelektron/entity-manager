static TopMenu g_adminMenu = null;

static TopMenuObject g_entityManagerCategory = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemFreezeEntity = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemUnfreezeEntity = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemDeleteEntity = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemRestoreEntity = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemShowPath = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemSave = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemLoad = INVALID_TOPMENUOBJECT;

void AdminMenu_Create() {
    TopMenu topMenu = GetAdminTopMenu();

    if (LibraryExists(ADMIN_MENU) && topMenu != null) {
        OnAdminMenuReady(topMenu);
    }
}

void AdminMenu_Destroy() {
    g_adminMenu = null;
}

public void AdminMenu_OnReady(Handle topMenuHandle) {
    TopMenu topMenu = TopMenu.FromHandle(topMenuHandle);

    if (topMenu == g_adminMenu) {
        return;
    }

    g_adminMenu = topMenu;

    AdminMenu_Fill();
}

void AdminMenu_Fill() {
    g_entityManagerCategory = g_adminMenu.AddCategory(ENTITY_MANAGER, AdminMenuHandler_EntityManager);

    if (g_entityManagerCategory != INVALID_TOPMENUOBJECT) {
        g_menuItemFreezeEntity = AdminMenu_AddItem(ITEM_ENTITY_FREEZE);
        g_menuItemUnfreezeEntity = AdminMenu_AddItem(ITEM_ENTITY_UNFREEZE);
        g_menuItemDeleteEntity = AdminMenu_AddItem(ITEM_ENTITY_DELETE);
        g_menuItemRestoreEntity = AdminMenu_AddItem(ITEM_ENTITY_RESTORE);
        g_menuItemShowPath = AdminMenu_AddItem(ITEM_ENTITIES_SHOW_PATH);
        g_menuItemSave = AdminMenu_AddItem(ITEM_ENTITIES_SAVE);
        g_menuItemLoad = AdminMenu_AddItem(ITEM_ENTITIES_LOAD);
    }
}

TopMenuObject AdminMenu_AddItem(const char[] name) {
    return g_adminMenu.AddItem(name, AdminMenuHandler_EntityManager, g_entityManagerCategory);
}

public void AdminMenuHandler_EntityManager(TopMenu topMenu, TopMenuAction action, TopMenuObject topMenuObject, int param, char[] buffer, int maxLength) {
    if (action == TopMenuAction_DisplayTitle) {
        if (topMenuObject == g_entityManagerCategory) {
            Format(buffer, maxLength, "%T", ENTITY_MANAGER, param);
        }
    } else if (action == TopMenuAction_DisplayOption) {
        if (topMenuObject == g_entityManagerCategory) {
            Format(buffer, maxLength, "%T", ENTITY_MANAGER, param);
        } else if (topMenuObject == g_menuItemFreezeEntity) {
            Format(buffer, maxLength, "%T", ITEM_ENTITY_FREEZE, param);
        } else if (topMenuObject == g_menuItemUnfreezeEntity) {
            Format(buffer, maxLength, "%T", ITEM_ENTITY_UNFREEZE, param);
        } else if (topMenuObject == g_menuItemDeleteEntity) {
            Format(buffer, maxLength, "%T", ITEM_ENTITY_DELETE, param);
        } else if (topMenuObject == g_menuItemRestoreEntity) {
            Format(buffer, maxLength, "%T", ITEM_ENTITY_RESTORE, param);
        } else if (topMenuObject == g_menuItemShowPath) {
            Format(buffer, maxLength, "%T", ITEM_ENTITIES_SHOW_PATH, param);
        } else if (topMenuObject == g_menuItemSave) {
            Format(buffer, maxLength, "%T", ITEM_ENTITIES_SAVE, param);
        } else if (topMenuObject == g_menuItemLoad) {
            Format(buffer, maxLength, "%T", ITEM_ENTITIES_LOAD, param);
        }
    } else if (action == TopMenuAction_SelectOption) {
        if (topMenuObject == g_menuItemFreezeEntity) {
            UseCase_FreezeEntity(param);
        } else if (topMenuObject == g_menuItemUnfreezeEntity) {
            UseCase_UnfreezeEntity(param);
        } else if (topMenuObject == g_menuItemDeleteEntity) {
            UseCase_DeleteEntity(param);
        } else if (topMenuObject == g_menuItemRestoreEntity) {
            UseCase_RestoreEntity(param);
        } else if (topMenuObject == g_menuItemShowPath) {
            UseCase_ShowPathToEntities(param);
        } else if (topMenuObject == g_menuItemSave) {
            UseCase_SaveEntities(param);
        } else if (topMenuObject == g_menuItemLoad) {
            UseCase_LoadEntities(param);
        }

        topMenu.DisplayCategory(g_entityManagerCategory, param);
    }
}

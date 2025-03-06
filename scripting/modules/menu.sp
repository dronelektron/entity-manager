void Menu_EntityManager(int client) {
    Menu menu = new Menu(EntityManager);

    menu.SetTitle("%T", ENTITY_MANAGER, client);

    AddLocalizedItem(menu, ITEM_ENTITY_FREEZE, client);
    AddLocalizedItem(menu, ITEM_ENTITY_UNFREEZE, client);
    AddLocalizedItem(menu, ITEM_ENTITY_DELETE, client);
    AddLocalizedItem(menu, ITEM_ENTITY_RESTORE, client);
    AddLocalizedItem(menu, ITEM_ENTITY_SHOW_PATH, client);
    AddLocalizedItem(menu, ITEM_ENTITIES_SAVE, client);
    AddLocalizedItem(menu, ITEM_ENTITIES_LOAD, client);

    menu.Display(client, MENU_TIME_FOREVER);
}

static int EntityManager(Menu menu, MenuAction action, int param1, int param2) {
    bool showMenuAgain = true;

    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        if (StrEqual(info, ITEM_ENTITY_FREEZE)) {
            UseCase_FreezeEntity(param1);
        } else if (StrEqual(info, ITEM_ENTITY_UNFREEZE)) {
            UseCase_UnfreezeEntity(param1);
        } else if (StrEqual(info, ITEM_ENTITY_DELETE)) {
            UseCase_DeleteEntity(param1);
        } else if (StrEqual(info, ITEM_ENTITY_RESTORE)) {
            UseCase_RestoreEntity(param1);
        } else if (StrEqual(info, ITEM_ENTITY_SHOW_PATH)) {
            if (EntityList_Size() == 0) {
                Message_EntityListEmpty(param1);
            } else {
                Menu_ShowPath(param1);

                showMenuAgain = false;
            }
        } else if (StrEqual(info, ITEM_ENTITIES_SAVE)) {
            UseCase_SaveEntities(param1);
        } else if (StrEqual(info, ITEM_ENTITIES_LOAD)) {
            UseCase_LoadEntities(param1);
        }

        if (showMenuAgain) {
            Menu_EntityManager(param1);
        }
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_ShowPath(int client) {
    Menu menu = new Menu(ShowPath);

    menu.SetTitle("%T", ITEM_ENTITY_SHOW_PATH, client);

    AddEntityItems(menu, client);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

static int ShowPath(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        int hammerId = StringToInt(info);

        UseCase_ShowPathToEntity(param1, hammerId);
        Menu_ShowPath(param1);
    } else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack) {
        if (AdminMenu_Exists()) {
            AdminMenu_Show(param1);
        } else {
            Menu_EntityManager(param1);
        }
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

static void AddEntityItems(Menu menu, int client) {
    char info[INFO_SIZE];
    char item[ITEM_SIZE];

    for (int i = 0; i < EntityList_Size(); i++) {
        int hammerId = EntityList_GetHammerId(i);

        IntToString(hammerId, info, sizeof(info));
        FormatEx(item, sizeof(item), "%T", "Object", client, hammerId);

        menu.AddItem(info, item);
    }
}

static void AddLocalizedItem(Menu menu, const char[] phrase, int client) {
    char item[ITEM_SIZE];

    FormatEx(item, sizeof(item), "%T", phrase, client);

    menu.AddItem(phrase, item);
}

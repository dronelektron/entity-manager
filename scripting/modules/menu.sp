void Menu_EntityManager(int client) {
    Menu menu = new Menu(MenuHandler_EntityManager);

    menu.SetTitle("%T", ENTITY_MANAGEMENT, client);

    Menu_AddItem(menu, ACTION_ENTITY_FREEZE, ACTION_ENTITY_FREEZE, client);
    Menu_AddItem(menu, ACTION_ENTITY_UNFREEZE, ACTION_ENTITY_UNFREEZE, client);
    Menu_AddItem(menu, ACTION_ENTITY_DELETE, ACTION_ENTITY_DELETE, client);
    Menu_AddItem(menu, ACTION_ENTITY_RESTORE, ACTION_ENTITY_RESTORE, client);
    Menu_AddItem(menu, ACTION_ENTITIES_SAVE, ACTION_ENTITIES_SAVE, client);
    Menu_AddItem(menu, ACTION_ENTITIES_LOAD, ACTION_ENTITIES_LOAD, client);

    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_EntityManager(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[MENU_TEXT_MAX_SIZE];
        int entity;

        menu.GetItem(param2, info, sizeof(info));

        if (strcmp(info, ACTION_ENTITY_FREEZE) == 0) {
            UseCase_FreezeEntity(param1, entity);
        } else if (strcmp(info, ACTION_ENTITY_UNFREEZE) == 0) {
            UseCase_UnfreezeEntity(param1, entity);
        } else if (strcmp(info, ACTION_ENTITY_DELETE) == 0) {
            UseCase_DeleteEntity(param1, entity);
        } else if (strcmp(info, ACTION_ENTITY_RESTORE) == 0) {
            UseCase_RestoreEntity(param1, entity);
        } else if (strcmp(info, ACTION_ENTITIES_SAVE) == 0) {
            UseCase_SaveEntities(param1);
        } else if (strcmp(info, ACTION_ENTITIES_LOAD) == 0) {
            UseCase_LoadEntities(param1);
        }

        Menu_EntityManager(param1);
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_AddItem(Menu menu, char[] info, char[] phrase, int client) {
    char item[MENU_TEXT_MAX_SIZE];

    Format(item, sizeof(item), "%T", phrase, client);

    menu.AddItem(info, item);
}

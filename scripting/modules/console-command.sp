void Command_Create() {
    RegAdminCmd("sm_entitymanager", Command_Menu, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_freeze", Command_Freeze, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_unfreeze", Command_Unfreeze, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_delete", Command_Delete, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_restore", Command_Restore, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_show_path", Command_ShowPath, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_save", Command_Save, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_load", Command_Load, ADMFLAG_GENERIC);
}

public Action Command_Menu(int client, int args) {
    Menu_EntityManager(client);

    return Plugin_Handled;
}

public Action Command_Freeze(int client, int args) {
    UseCase_FreezeEntity(client);

    return Plugin_Handled;
}

public Action Command_Unfreeze(int client, int args) {
    UseCase_UnfreezeEntity(client);

    return Plugin_Handled;
}

public Action Command_Delete(int client, int args) {
    UseCase_DeleteEntity(client);

    return Plugin_Handled;
}

public Action Command_Restore(int client, int args) {
    UseCase_RestoreEntity(client);

    return Plugin_Handled;
}

public Action Command_ShowPath(int client, int args) {
    UseCase_ShowPathToEntities(client);

    return Plugin_Handled;
}

public Action Command_Save(int client, int args) {
    UseCase_SaveEntities(client);

    return Plugin_Handled;
}

public Action Command_Load(int client, int args) {
    UseCase_LoadEntities(client);

    return Plugin_Handled;
}

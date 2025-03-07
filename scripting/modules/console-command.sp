void Command_Create() {
    RegAdminCmd("sm_entitymanager", OnEntityManager, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_freeze", OnFreezeEntity, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_unfreeze", OnUnfreezeEntity, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_delete", OnDeleteEntity, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_restore", OnRestoreEntity, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_show_path", OnShowPath, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_save", OnSaveEntities, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_load", OnLoadEntities, ADMFLAG_GENERIC);
}

static Action OnEntityManager(int client, int args) {
    Menu_EntityManager(client);

    return Plugin_Handled;
}

static Action OnFreezeEntity(int client, int args) {
    UseCase_FreezeEntity(client);

    return Plugin_Handled;
}

static Action OnUnfreezeEntity(int client, int args) {
    UseCase_UnfreezeEntity(client);

    return Plugin_Handled;
}

static Action OnDeleteEntity(int client, int args) {
    UseCase_DeleteEntity(client);

    return Plugin_Handled;
}

static Action OnRestoreEntity(int client, int args) {
    UseCase_RestoreEntity(client);

    return Plugin_Handled;
}

static Action OnShowPath(int client, int args) {
    if (args < 1) {
        Message_ShowPathUsage(client);

        return Plugin_Handled;
    }

    int hammerId = GetCmdArgInt(1);

    UseCase_ShowPathToEntity(client, hammerId);

    return Plugin_Handled;
}

static Action OnSaveEntities(int client, int args) {
    UseCase_SaveEntities(client);

    return Plugin_Handled;
}

static Action OnLoadEntities(int client, int args) {
    UseCase_LoadEntities(client);

    return Plugin_Handled;
}

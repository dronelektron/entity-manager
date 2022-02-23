void Command_Create() {
    RegAdminCmd("sm_entitymanager", Command_Menu, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_freeze", Command_Freeze, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_unfreeze", Command_Unfreeze, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_delete", Command_Delete, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_restore", Command_Restore, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_save", Command_Save, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_load", Command_Load, ADMFLAG_GENERIC);
}

public Action Command_Menu(int client, int args) {
    Menu_EntityManager(client);

    return Plugin_Handled;
}

public Action Command_Freeze(int client, int args) {
    int entity;
    UseCaseResult result = UseCase_FreezeEntity(client, entity);

    if (result == UseCaseResult_Success) {
        Message_EntityFrozen(client, entity);
    } else if (result == UseCaseResult_EntityNotFound) {
        Message_EntityNotFound(client);
    } else if (result == UseCaseResult_AlreadyHasAction) {
        Message_EntityAlreadyHasAction(client, entity);
    }

    return Plugin_Handled;
}

public Action Command_Unfreeze(int client, int args) {
    int entity;
    UseCaseResult result = UseCase_UnfreezeEntity(client, entity);

    if (result == UseCaseResult_Success) {
        Message_EntityUnfrozen(client, entity);
    } else if (result == UseCaseResult_EntityNotFound) {
        Message_EntityNotFound(client);
    } else if (result == UseCaseResult_NotFrozen) {
        Message_EntityNotFrozen(client, entity);
    }

    return Plugin_Handled;
}

public Action Command_Delete(int client, int args) {
    int entity;
    UseCaseResult result = UseCase_DeleteEntity(client, entity);

    if (result == UseCaseResult_Success) {
        Message_EntityDeleted(client, entity);
    } else if (result == UseCaseResult_EntityNotFound) {
        Message_EntityNotFound(client);
    } else if (result == UseCaseResult_AlreadyHasAction) {
        Message_EntityAlreadyHasAction(client, entity);
    }

    return Plugin_Handled;
}

public Action Command_Restore(int client, int args) {
    int entity;
    UseCaseResult result = UseCase_RestoreEntity(client, entity);

    if (result == UseCaseResult_Success) {
        Message_EntityRestored(client, entity);
    } else if (result == UseCaseResult_EntityNotFound) {
        Message_EntityNotFound(client);
    } else if (result == UseCaseResult_NotDeleted) {
        Message_EntityNotDeleted(client, entity);
    }

    return Plugin_Handled;
}

public Action Command_Save(int client, int args) {
    UseCase_SaveEntities(client);

    int entitiesAmount = EntityList_Size();

    if (entitiesAmount == 0) {
        Message_ListOfEntitiesCleared(client);
    } else {
        Message_EntitiesSaved(client, entitiesAmount);
    }

    return Plugin_Handled;
}

public Action Command_Load(int client, int args) {
    UseCase_LoadEntities(client);

    int entitiesAmount = EntityList_Size();

    if (entitiesAmount == 0) {
        Message_NoEntitiesForLoading(client);
    } else {
        Message_EntitiesLoaded(client, entitiesAmount);
    }

    return Plugin_Handled;
}

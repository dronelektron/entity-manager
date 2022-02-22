void Command_Create() {
    RegAdminCmd("sm_entitymanager_freeze", Command_Freeze, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_unfreeze", Command_Unfreeze, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_delete", Command_Delete, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_restore", Command_Restore, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_save", Command_Save, ADMFLAG_GENERIC);
}

public Action Command_Freeze(int client, int args) {
    int entity;
    UseCaseResult result = UseCase_FreezeEntity(client, entity);

    if (result == UseCaseResult_Success) {
        Message_ReplyEntityFrozen(client, entity);
    } else {
        DefaultMessageHandler(result, client, entity);
    }

    return Plugin_Handled;
}

public Action Command_Unfreeze(int client, int args) {
    int entity;
    UseCaseResult result = UseCase_UnfreezeEntity(client, entity);

    if (result == UseCaseResult_Success) {
        Message_ReplyEntityUnfrozen(client, entity);
    } else {
        DefaultMessageHandler(result, client, entity);
    }

    return Plugin_Handled;
}

public Action Command_Delete(int client, int args) {
    int entity;
    UseCaseResult result = UseCase_DeleteEntity(client, entity);

    if (result == UseCaseResult_Success) {
        Message_ReplyEntityDeleted(client, entity);
    } else {
        DefaultMessageHandler(result, client, entity);
    }

    return Plugin_Handled;
}

public Action Command_Restore(int client, int args) {
    int entity;
    UseCaseResult result = UseCase_RestoreEntity(client, entity);

    if (result == UseCaseResult_Success) {
        Message_ReplyEntityRestored(client, entity);
    } else {
        DefaultMessageHandler(result, client, entity);
    }

    return Plugin_Handled;
}

public Action Command_Save(int client, int args) {
    int entitiesAmount;

    UseCase_SaveEntities(client, entitiesAmount);
    Message_ReplyEntitiesSaved(client, entitiesAmount);

    return Plugin_Handled;
}

void DefaultMessageHandler(UseCaseResult result, int client, int entity) {
    switch (result) {
        case UseCaseResult_EntityNotFound: {
            Message_ReplyEntityNotFound(client);
        }

        case UseCaseResult_AlreadyHasAction: {
            Message_ReplyEntityAlreadyHasAction(client, entity);
        }

        case UseCaseResult_HasNoActions: {
            Message_ReplyEntityHasNoActions(client, entity);
        }
    }
}

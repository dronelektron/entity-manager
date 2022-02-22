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

    switch (result) {
        case UseCaseResult_Success: {
            Message_ReplyEntityFrozen(client, entity);
        }

        case UseCaseResult_EntityNotFound: {
            Message_ReplyEntityNotFound(client);
        }

        case UseCaseResult_AlreadyHasAction: {
            Message_ReplyEntityAlreadyHasAction(client, entity);
        }
    }

    return Plugin_Handled;
}

public Action Command_Unfreeze(int client, int args) {
    int entity;
    UseCaseResult result = UseCase_UnfreezeEntity(client, entity);

    switch (result) {
        case UseCaseResult_Success: {
            Message_ReplyEntityUnfrozen(client, entity);
        }

        case UseCaseResult_EntityNotFound: {
            Message_ReplyEntityNotFound(client);
        }

        case UseCaseResult_NotFrozen: {
            Message_ReplyEntityNotFrozen(client, entity);
        }
    }

    return Plugin_Handled;
}

public Action Command_Delete(int client, int args) {
    int entity;
    UseCaseResult result = UseCase_DeleteEntity(client, entity);

    switch (result) {
        case UseCaseResult_Success: {
            Message_ReplyEntityDeleted(client, entity);
        }

        case UseCaseResult_EntityNotFound: {
            Message_ReplyEntityNotFound(client);
        }

        case UseCaseResult_AlreadyHasAction: {
            Message_ReplyEntityAlreadyHasAction(client, entity);
        }
    }

    return Plugin_Handled;
}

public Action Command_Restore(int client, int args) {
    int entity;
    UseCaseResult result = UseCase_RestoreEntity(client, entity);

    switch (result) {
        case UseCaseResult_Success: {
            Message_ReplyEntityRestored(client, entity);
        }

        case UseCaseResult_EntityNotFound: {
            Message_ReplyEntityNotFound(client);
        }

        case UseCaseResult_NotDeleted: {
            Message_ReplyEntityNotDeleted(client, entity);
        }
    }

    return Plugin_Handled;
}

public Action Command_Save(int client, int args) {
    int entitiesAmount;

    UseCase_SaveEntities(client, entitiesAmount);

    if (entitiesAmount == 0) {
        Message_ReplyListOfEntitiesCleared(client);
    } else {
        Message_ReplyEntitiesSaved(client, entitiesAmount);
    }

    return Plugin_Handled;
}

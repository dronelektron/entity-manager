UseCaseResult UseCase_FreezeEntity(int client, int& entity) {
    entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        return UseCaseResult_EntityNotFound;
    }

    if (EntityList_Contains(entity)) {
        return UseCaseResult_AlreadyHasAction;
    }

    Entity_Freeze(entity);
    EntityList_Add(entity, ENTITY_ACTION_FREEZE);
    Message_EntityFrozen(client, entity, MessageType_Log);

    return UseCaseResult_Success;
}

UseCaseResult UseCase_UnfreezeEntity(int client, int& entity) {
    entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        return UseCaseResult_EntityNotFound;
    }

    if (!EntityList_IsFrozen(entity)) {
        return UseCaseResult_NotFrozen;
    }

    Entity_Unfreeze(entity);
    EntityList_Remove(entity);
    Message_EntityUnfrozen(client, entity, MessageType_Log);

    return UseCaseResult_Success;
}

UseCaseResult UseCase_DeleteEntity(int client, int& entity) {
    entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        return UseCaseResult_EntityNotFound;
    }

    if (EntityList_Contains(entity)) {
        return UseCaseResult_AlreadyHasAction;
    }

    Entity_Delete(entity);
    EntityList_Add(entity, ENTITY_ACTION_DELETE);
    Message_EntityDeleted(client, entity, MessageType_Log);

    return UseCaseResult_Success;
}

UseCaseResult UseCase_RestoreEntity(int client, int& entity) {
    entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        return UseCaseResult_EntityNotFound;
    }

    if (!EntityList_IsDeleted(entity)) {
        return UseCaseResult_NotDeleted;
    }

    Entity_Restore(entity);
    EntityList_Remove(entity);
    Message_EntityRestored(client, entity, MessageType_Log);

    return UseCaseResult_Success;
}

void UseCase_SaveEntities(int client) {
    Storage_Apply(Storage_SaveEntities);

    int entitiesAmount = EntityList_Size();

    if (entitiesAmount == 0) {
        Message_ListOfEntitiesCleared(client, MessageType_Log);
    } else {
        Message_EntitiesSaved(client, entitiesAmount, MessageType_Log);
    }
}

void UseCase_LoadEntities(int client) {
    Storage_SaveCurrentMapName();
    Storage_Apply(Storage_LoadEntities);

    int entitiesAmount = EntityList_Size();

    if (entitiesAmount == 0) {
        Message_NoEntitiesForLoading(client, MessageType_Log);
    } else {
        Message_EntitiesLoaded(client, entitiesAmount, MessageType_Log);
    }
}

void UseCase_ApplyActionToEntities() {
    for (int entityIndex = 0; entityIndex < EntityList_Size(); entityIndex++) {
        int entity = EntityList_GetId(entityIndex);
        int action = EntityList_GetAction(entityIndex);

        if (action == ENTITY_ACTION_FREEZE && Variable_IsFreezeAllowed()) {
            Entity_Freeze(entity);
        } else if (action == ENTITY_ACTION_DELETE && Variable_IsDeletionAllowed()) {
            Entity_Delete(entity);
        }
    }
}

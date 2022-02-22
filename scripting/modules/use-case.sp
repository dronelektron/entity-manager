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
    Message_LogFrozeEntity(client, entity);

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
    Message_LogUnfrozeEntity(client, entity);

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

    Entity_Hide(entity);
    EntityList_Add(entity, ENTITY_ACTION_DELETE);
    Message_LogEntityDeleted(client, entity);

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

    EntityList_Remove(entity);
    Message_LogEntityRestored(client, entity);

    return UseCaseResult_Success;
}

void UseCase_SaveEntities(int client, int& entitiesAmount) {
    Storage_Apply(Storage_SaveEntities);

    entitiesAmount = EntityList_Size();

    if (entitiesAmount == 0) {
        Message_LogListOfEntitiesCleared(client);
    } else {
        Message_LogEntitiesSaved(client, entitiesAmount);
    }
}

void UseCase_LoadEntities() {
    Storage_SaveCurrentMapName();
    Storage_Apply(Storage_LoadEntities);

    int entitiesAmount = EntityList_Size();

    if (entitiesAmount == 0) {
        Message_LogNoEntities();
    } else {
        Message_LogEntitiesLoaded(entitiesAmount);
    }
}

void UseCase_ApplyActionToEntities() {
    for (int entityIndex = 0; entityIndex < EntityList_Size(); entityIndex++) {
        int entity = EntityList_GetId(entityIndex);
        int action = EntityList_GetAction(entityIndex);

        switch (action) {
            case ENTITY_ACTION_FREEZE: {
                if (Variable_IsFreezeAllowed()) {
                    Entity_Freeze(entity);
                }
            }

            case ENTITY_ACTION_DELETE: {
                if (Variable_IsDeletionAllowed()) {
                    Entity_Hide(entity);
                }
            }
        }
    }
}

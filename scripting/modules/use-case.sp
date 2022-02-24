void UseCase_FreezeEntity(int client) {
    int entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        Message_ReplyEntityNotFound(client);

        return;
    }

    if (EntityList_Contains(entity)) {
        Message_ReplyEntityAlreadyHasAction(client, entity);

        return;
    }

    Entity_Freeze(entity);
    EntityList_Add(entity, ENTITY_ACTION_FREEZE);
    Message_ActivityEntityFrozen(client, entity);
    Message_LogEntityFrozen(client, entity);
}

void UseCase_UnfreezeEntity(int client) {
    int entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        Message_ReplyEntityNotFound(client);

        return;
    }

    if (!EntityList_IsFrozen(entity)) {
        Message_ReplyEntityNotFrozen(client, entity);

        return;
    }

    Entity_Unfreeze(entity);
    EntityList_Remove(entity);
    Message_ActivityEntityUnfrozen(client, entity);
    Message_LogEntityUnfrozen(client, entity);
}

void UseCase_DeleteEntity(int client) {
    int entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        Message_ReplyEntityNotFound(client);

        return;
    }

    if (EntityList_Contains(entity)) {
        Message_ReplyEntityAlreadyHasAction(client, entity);

        return;
    }

    Entity_Delete(entity);
    EntityList_Add(entity, ENTITY_ACTION_DELETE);
    Message_ActivityEntityDeleted(client, entity);
    Message_LogEntityDeleted(client, entity);
}

void UseCase_RestoreEntity(int client) {
    int entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        Message_ReplyEntityNotFound(client);

        return;
    }

    if (!EntityList_IsDeleted(entity)) {
        Message_ReplyEntityNotDeleted(client, entity);

        return;
    }

    Entity_Restore(entity);
    EntityList_Remove(entity);
    Message_ActivityEntityRestored(client, entity);
    Message_LogEntityRestored(client, entity);
}

void UseCase_SaveEntities(int client) {
    Storage_Apply(Storage_SaveEntities);

    int entitiesAmount = EntityList_Size();

    if (entitiesAmount == 0) {
        Message_ActivityListOfEntitiesCleared(client);
        Message_LogListOfEntitiesCleared(client);
    } else {
        Message_ActivityEntitiesSaved(client, entitiesAmount);
        Message_LogEntitiesSaved(client, entitiesAmount);
    }
}

void UseCase_LoadEntities(int client) {
    Storage_SaveCurrentMapName();
    Storage_Apply(Storage_LoadEntities);

    int entitiesAmount = EntityList_Size();

    if (entitiesAmount == 0) {
        Message_ReplyNoEntitiesForLoading(client);
        Message_LogNoEntitiesForLoading(client);
    } else {
        Message_ActivityEntitiesLoaded(client, entitiesAmount);
        Message_LogEntitiesLoaded(client, entitiesAmount);
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

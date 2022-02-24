void UseCase_FreezeEntity(int client) {
    int entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        MessageReply_EntityNotFound(client);

        return;
    }

    if (EntityList_Contains(entity)) {
        MessageReply_EntityAlreadyHasAction(client, entity);

        return;
    }

    Entity_Freeze(entity);
    EntityList_Add(entity, ENTITY_ACTION_FREEZE);
    MessageActivity_EntityFrozen(client, entity);
    MessageLog_EntityFrozen(client, entity);
}

void UseCase_UnfreezeEntity(int client) {
    int entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        MessageReply_EntityNotFound(client);

        return;
    }

    if (!EntityList_IsFrozen(entity)) {
        MessageReply_EntityNotFrozen(client, entity);

        return;
    }

    Entity_Unfreeze(entity);
    EntityList_Remove(entity);
    MessageActivity_EntityUnfrozen(client, entity);
    MessageLog_EntityUnfrozen(client, entity);
}

void UseCase_DeleteEntity(int client) {
    int entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        MessageReply_EntityNotFound(client);

        return;
    }

    if (EntityList_Contains(entity)) {
        MessageReply_EntityAlreadyHasAction(client, entity);

        return;
    }

    Entity_Delete(entity);
    EntityList_Add(entity, ENTITY_ACTION_DELETE);
    MessageActivity_EntityDeleted(client, entity);
    MessageLog_EntityDeleted(client, entity);
}

void UseCase_RestoreEntity(int client) {
    int entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        MessageReply_EntityNotFound(client);

        return;
    }

    if (!EntityList_IsDeleted(entity)) {
        MessageReply_EntityNotDeleted(client, entity);

        return;
    }

    Entity_Restore(entity);
    EntityList_Remove(entity);
    MessageActivity_EntityRestored(client, entity);
    MessageLog_EntityRestored(client, entity);
}

void UseCase_SaveEntities(int client) {
    Storage_Apply(Storage_SaveEntities);

    int entitiesAmount = EntityList_Size();

    if (entitiesAmount == 0) {
        MessageActivity_ListOfEntitiesCleared(client);
        MessageLog_ListOfEntitiesCleared(client);
    } else {
        MessageActivity_EntitiesSaved(client, entitiesAmount);
        MessageLog_EntitiesSaved(client, entitiesAmount);
    }
}

void UseCase_LoadEntities(int client) {
    Storage_SaveCurrentMapName();
    Storage_Apply(Storage_LoadEntities);

    int entitiesAmount = EntityList_Size();

    if (entitiesAmount == 0) {
        MessageReply_NoEntitiesForLoading(client);
        MessageLog_NoEntitiesForLoading(client);
    } else {
        MessageActivity_EntitiesLoaded(client, entitiesAmount);
        MessageLog_EntitiesLoaded(client, entitiesAmount);
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

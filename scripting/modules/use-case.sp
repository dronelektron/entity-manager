void UseCase_FreezeEntity(int client) {
    int entity = Entity_Trace(client);

    if (UseCase_IsBadEntity(entity)) {
        MessageReply_EntityNotFound(client);

        return;
    }

    if (EntityList_HasAction(entity)) {
        MessageReply_EntityAlreadyHasAction(client, entity);

        return;
    }

    Entity_Freeze(entity);
    EntityList_SetActionByEntity(entity, ENTITY_ACTION_FREEZE);
    UseCase_DisableEntityDamage(entity);
    Message_EntityFrozen(client, entity);
}

void UseCase_UnfreezeEntity(int client) {
    int entity = Entity_Trace(client);

    if (UseCase_IsBadEntity(entity)) {
        MessageReply_EntityNotFound(client);

        return;
    }

    if (!EntityList_IsFrozen(entity)) {
        MessageReply_EntityNotFrozen(client, entity);

        return;
    }

    Entity_Unfreeze(entity);
    EntityList_SetActionByEntity(entity, ENTITY_ACTION_NONE);
    UseCase_EnableEntityDamage(entity);
    Message_EntityUnfrozen(client, entity);
}

void UseCase_DeleteEntity(int client) {
    int entity = Entity_Trace(client);

    if (UseCase_IsBadEntity(entity)) {
        MessageReply_EntityNotFound(client);

        return;
    }

    if (EntityList_HasAction(entity)) {
        MessageReply_EntityAlreadyHasAction(client, entity);

        return;
    }

    Entity_Delete(entity);
    EntityList_SetActionByEntity(entity, ENTITY_ACTION_DELETE);
    UseCase_DisableEntityDamage(entity);
    Message_EntityDeleted(client, entity);
}

void UseCase_RestoreEntity(int client) {
    int entity = Entity_Trace(client);

    if (UseCase_IsBadEntity(entity)) {
        MessageReply_EntityNotFound(client);

        return;
    }

    if (!EntityList_IsDeleted(entity)) {
        MessageReply_EntityNotDeleted(client, entity);

        return;
    }

    Entity_Restore(entity);
    EntityList_SetActionByEntity(entity, ENTITY_ACTION_NONE);
    UseCase_EnableEntityDamage(entity);
    Message_EntityRestored(client, entity);
}

void UseCase_ShowPathToEntity(int client, int entity) {
    if (EntityList_FindByEntity(entity) == ENTITY_NOT_FOUND || !EntityList_HasAction(entity)) {
        MessageReply_EntityNotFound(client);

        return;
    }

    UseCase_DrawBeam(client, entity);
    UseCase_DrawBounds(client, entity);
}

void UseCase_DrawBeam(int client, int entity) {
    float clientMiddle[3];
    float entityMiddle[3];

    Math_GetMiddle(client, clientMiddle, BOUNDS_ROTATE_NO);
    Math_GetMiddle(entity, entityMiddle, BOUNDS_ROTATE_YES);
    Visualizer_DrawBeam(client, clientMiddle, entityMiddle);
}

void UseCase_DrawBounds(int client, int entity) {
    float entityOrigin[3];
    float minBounds[3];
    float maxBounds[3];
    float degAngles[3];
    float radAngles[3];
    float vertices[8][3];
    float rotationMatrix[3][3];

    Entity_GetPosition(entity, entityOrigin);
    Entity_GetMinBounds(entity, minBounds);
    Entity_GetMaxBounds(entity, maxBounds);
    Entity_GetAngles(entity, degAngles);
    Math_DegreesToRadiansVector(degAngles, radAngles);
    Math_GetRotationMatrix(radAngles, rotationMatrix);
    Math_GetVertices(minBounds, maxBounds, vertices);

    for (int i = 0; i < sizeof(vertices); i++) {
        Math_MultiplyMatrixByVector(rotationMatrix, vertices[i], vertices[i]);
        AddVectors(vertices[i], entityOrigin, vertices[i]);
    }

    Visualizer_DrawBounds(client, vertices);
}

void UseCase_SaveEntities(int client) {
    Storage_Apply(Storage_SaveEntities);

    int entitiesAmount = EntityList_EntitiesAmountWithAction();

    if (entitiesAmount == 0) {
        Message_ListOfEntitiesCleared(client);
    } else {
        Message_EntitiesSaved(client, entitiesAmount);
    }
}

void UseCase_LoadEntities(int client) {
    UseCase_ClearEntitiesAction();
    Storage_Apply(Storage_LoadEntities);

    int entitiesAmount = EntityList_EntitiesAmountWithAction();

    if (entitiesAmount == 0) {
        Message_NoEntitiesForLoading(client);
    } else {
        Message_EntitiesLoaded(client, entitiesAmount);
    }
}

void UseCase_ClearEntitiesAction() {
    for (int entityIndex = 0; entityIndex < EntityList_Size(); entityIndex++) {
        EntityList_SetAction(entityIndex, ENTITY_ACTION_NONE);
    }
}

void UseCase_UpdateEntitiesFromMap(const char[] className) {
    int entity = ENTITY_NOT_FOUND;
    float position[3];

    while ((entity = FindEntityByClassname(entity, className)) != ENTITY_NOT_FOUND) {
        if (Entity_IsPropPhysics(entity)) {
            Entity_GetPosition(entity, position);
            UseCase_UpdateEntityFromMap(entity, position);
        }
    }
}

static void UseCase_UpdateEntityFromMap(int entity, const float position[3]) {
    int entityIndex = EntityList_FindByPosition(position);

    if (entityIndex == ENTITY_NOT_FOUND) {
        EntityList_Add(entity, ENTITY_ACTION_NONE, position);
    } else {
        EntityList_SetEntity(entityIndex, entity);
    }
}

void UseCase_UpdateEntityFromFile(int action, const float position[3]) {
    int entityIndex = EntityList_FindByPosition(position);

    if (entityIndex == ENTITY_NOT_FOUND) {
        EntityList_Add(ENTITY_NOT_FOUND, action, position);
    } else {
        EntityList_SetAction(entityIndex, action);
    }
}

void UseCase_ApplyActionToEntities() {
    for (int entityIndex = 0; entityIndex < EntityList_Size(); entityIndex++) {
        int entity = EntityList_GetEntity(entityIndex);
        int action = EntityList_GetAction(entityIndex);

        if (action == ENTITY_ACTION_FREEZE && Variable_IsFreezeAllowed()) {
            Entity_Freeze(entity);
            UseCase_DisableEntityDamage(entity);
        } else if (action == ENTITY_ACTION_DELETE && Variable_IsDeletionAllowed()) {
            Entity_Delete(entity);
            UseCase_DisableEntityDamage(entity);
        }
    }
}

void UseCase_EnableEntityDamage(int entity) {
    SDKUnhook(entity, SDKHook_OnTakeDamage, UseCaseHook_OnTakeDamage);
}

void UseCase_DisableEntityDamage(int entity) {
    SDKHook(entity, SDKHook_OnTakeDamage, UseCaseHook_OnTakeDamage);
}

public Action UseCaseHook_OnTakeDamage(int victim, int& attacker, int& inflictor, float& damage, int& damageType) {
    return Plugin_Handled;
}

bool UseCase_IsBadEntity(int entity) {
    return entity <= ENTITY_WORLD || !Entity_IsPropPhysics(entity);
}

void UseCase_FreezeEntity(int client) {
    int entity, hammerId;

    if (TraceEntityWithoutAction(client, entity, hammerId)) {
        HighlightEntity(client, entity);
        Entity_Freeze_Toggle(entity, ENABLED_YES);
        EntityList_Add(entity, hammerId, ENTITY_ACTION_FREEZE);
        Message_EntityFrozen(client, hammerId);
    }
}

void UseCase_UnfreezeEntity(int client) {
    int entity, hammerId;

    if (TraceEntityWithAction(client, ENTITY_ACTION_FREEZE, entity, hammerId)) {
        HighlightEntity(client, entity);
        Entity_Freeze_Toggle(entity, ENABLED_NO);
        EntityList_RemoveByHammerId(hammerId);
        Message_EntityUnfrozen(client, hammerId);
    }
}

void UseCase_DeleteEntity(int client) {
    int entity, hammerId;

    if (TraceEntityWithoutAction(client, entity, hammerId)) {
        HighlightEntity(client, entity);
        Entity_Delete_Toggle(entity, ENABLED_YES);
        EntityList_Add(entity, hammerId, ENTITY_ACTION_DELETE);
        Message_EntityDeleted(client, hammerId);
    }
}

void UseCase_RestoreEntity(int client) {
    int entity, hammerId;

    if (TraceEntityWithAction(client, ENTITY_ACTION_DELETE, entity, hammerId)) {
        HighlightEntity(client, entity);
        Entity_Delete_Toggle(entity, ENABLED_NO);
        EntityList_RemoveByHammerId(hammerId);
        Message_EntityRestored(client, hammerId);
    }
}

static bool TraceEntityWithoutAction(int client, int& entity, int& hammerId) {
    if (!TraceEntity(client, entity, hammerId)) {
        return false;
    }

    if (EntityList_GetActionByHammerId(hammerId) != INVALID_INDEX) {
        Message_EntityWithAction(client);

        return false;
    }

    return true;
}

static bool TraceEntityWithAction(int client, int action, int& entity, int& hammerId) {
    if (!TraceEntity(client, entity, hammerId)) {
        return false;
    }

    if (EntityList_GetActionByHammerId(hammerId) != action) {
        Message_EntityWithoutAction(client);

        return false;
    }

    return true;
}

static bool TraceEntity(int client, int& entity, int& hammerId) {
    entity = Entity_Trace(client);

    if (entity <= WORLD) {
        Message_EntityNotFound(client);

        return false;
    }

    if (EntityFilter_IsNotPhysical(entity)) {
        Message_EntityNotPhysical(client);

        return false;
    }

    hammerId = Entity_GetHammerId(entity);

    if (hammerId == INVALID_HAMMER_ID) {
        Message_EntityWithoutHammerId(client);

        return false;
    }

    return true;
}

void UseCase_ShowPathToEntity(int client, int hammerId) {
    int entity = EntityList_GetEntityByHammerId(hammerId);

    if (entity == INVALID_INDEX) {
        Message_EntityNotFound(client);

        return;
    }

    HighlightPath(client, entity);
    HighlightEntity(client, entity);
}

static void HighlightPath(int client, int entity) {
    float clientMiddle[3];
    float entityMiddle[3];

    Math_GetMiddle(client, clientMiddle, ROTATE_NO);
    Math_GetMiddle(entity, entityMiddle, ROTATE_YES);
    Visualizer_DrawBeam(client, clientMiddle, entityMiddle);
}

static void HighlightEntity(int client, int entity) {
    float vertices[8][3];

    Math_GetRotatedVertices(entity, vertices);
    Visualizer_DrawBox(client, vertices);
}

void UseCase_SaveEntities(int client) {
    Storage_Apply(Storage_SaveEntities);
    Message_EntitiesSaved(client);
}

void UseCase_LoadEntities(int client) {
    UseCase_EntitiesAction_Toggle(ENABLED_NO);
    Storage_Apply(Storage_LoadEntities);
    UseCase_EntitiesAction_Toggle(ENABLED_YES);

    if (EntityList_Size() > 0) {
        Message_EntitiesLoaded(client);
    }
}

void UseCase_EntitiesAction_Toggle(bool enabled) {
    EntitiesAction_Toggle(PROP_PHYSICS, enabled);
    EntitiesAction_Toggle(PROP_PHYSICS_OVERRIDE, enabled);
    EntitiesAction_Toggle(PROP_PHYSICS_MULTIPLAYER, enabled);
}

static void EntitiesAction_Toggle(const char[] className, bool enabled) {
    int entity = INVALID_INDEX;

    while (FindEntity(entity, className)) {
        int hammerId = Entity_GetHammerId(entity);

        EntityAction_Toggle(entity, hammerId, enabled);
    }
}

static bool FindEntity(int& entity, const char[] className) {
    entity = FindEntityByClassname(entity, className);

    return entity > INVALID_INDEX;
}

static void EntityAction_Toggle(int entity, int hammerId, bool enabled) {
    int action = EntityList_GetActionByHammerId(hammerId);

    switch (action) {
        case ENTITY_ACTION_FREEZE: {
            Entity_Freeze_Toggle(entity, enabled);
        }

        case ENTITY_ACTION_DELETE: {
            Entity_Delete_Toggle(entity, enabled);
        }
    }

    EntityList_SetEntityByHammerId(hammerId, entity);
}

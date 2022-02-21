void Command_Create() {
    RegAdminCmd("sm_entitymanager_freeze", Command_Freeze, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_unfreeze", Command_Unfreeze, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_delete", Command_Delete, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_restore", Command_Restore, ADMFLAG_GENERIC);
    RegAdminCmd("sm_entitymanager_save", Command_Save, ADMFLAG_GENERIC);
}

public Action Command_Freeze(int client, int args) {
    int entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        Message_ReplyEntityNotFound(client);

        return Plugin_Handled;
    }

    if (EntityList_Contains(entity)) {
        Message_ReplyEntityAlreadyHasAction(client, entity);

        return Plugin_Handled;
    }

    Entity_Freeze(entity);
    EntityList_Add(entity, ENTITY_ACTION_FREEZE);
    Message_ReplyEntityFrozen(client, entity);
    Message_LogFrozeEntity(client, entity);

    return Plugin_Handled;
}

public Action Command_Unfreeze(int client, int args) {
    int entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        Message_ReplyEntityNotFound(client);

        return Plugin_Handled;
    }

    if (!EntityList_Contains(entity)) {
        Message_ReplyEntityHasNoActions(client, entity);

        return Plugin_Handled;
    }

    Entity_Unfreeze(entity);
    EntityList_Remove(entity);
    Message_ReplyEntityUnfrozen(client, entity);
    Message_LogUnfrozeEntity(client, entity);

    return Plugin_Handled;
}

public Action Command_Delete(int client, int args) {
    int entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        Message_ReplyEntityNotFound(client);

        return Plugin_Handled;
    }

    if (EntityList_Contains(entity)) {
        Message_ReplyEntityAlreadyHasAction(client, entity);

        return Plugin_Handled;
    }

    RemoveEntity(entity);
    EntityList_Add(entity, ENTITY_ACTION_DELETE);
    Message_ReplyEntityDeleted(client, entity);
    Message_LogEntityDeleted(client, entity);

    return Plugin_Handled;
}

public Action Command_Restore(int client, int args) {
    int entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        Message_ReplyEntityNotFound(client);

        return Plugin_Handled;
    }

    if (!EntityList_Contains(entity)) {
        Message_ReplyEntityHasNoActions(client, entity);

        return Plugin_Handled;
    }

    EntityList_Remove(entity);
    Message_ReplyEntityRestored(client, entity);
    Message_LogEntityRestored(client, entity);

    return Plugin_Handled;
}

public Action Command_Save(int client, int args) {
    int entitiesAmount = EntityList_Size();

    Storage_Apply(Storage_SaveEntities);
    Message_ReplyEntitiesSaved(client, entitiesAmount);
    Message_LogEntitiesSaved(client, entitiesAmount);

    return Plugin_Handled;
}

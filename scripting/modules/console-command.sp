public Action Command_Freeze(int client, int args) {
    int entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        Message_ReplyEntityNotFound(client);

        return Plugin_Handled;
    }

    if (EntityList_Contains(entity)) {
        Message_ReplyEntityAlreadyFrozen(client, entity);

        return Plugin_Handled;
    }

    Entity_Freeze(entity);
    EntityList_Add(entity, ENTITY_ACTION_FREEZE);
    Message_ReplyEntityFrozen(client, entity);
    LogMessage("\"%L\" froze entity %d", client, entity);

    return Plugin_Handled;
}

public Action Command_Unfreeze(int client, int args) {
    int entity = Entity_Trace(client);

    if (entity <= ENTITY_WORLD) {
        Message_ReplyEntityNotFound(client);

        return Plugin_Handled;
    }

    if (!EntityList_Contains(entity)) {
        Message_ReplyEntityAlreadyUnfrozen(client, entity);

        return Plugin_Handled;
    }

    Entity_Unfreeze(entity);
    EntityList_Remove(entity);
    Message_ReplyEntityUnfrozen(client, entity);
    LogMessage("\"%L\" unfroze entity %d", client, entity);

    return Plugin_Handled;
}

public Action Command_Save(int client, int args) {
    int entitiesAmount = EntityList_Size();

    Storage_Apply(Storage_SaveEntities);
    Message_ReplyEntitiesSaved(client, entitiesAmount);
    LogMessage("\"%L\" saved %d entities", client, entitiesAmount);

    return Plugin_Handled;
}

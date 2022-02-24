void MessageReply_EntityNotFound(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity not found");
}

void MessageReply_EntityAlreadyHasAction(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity already has an action", entity);
}

void MessageReply_EntityNotFrozen(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity not frozen", entity);
}

void MessageReply_EntityNotDeleted(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity not deleted", entity);
}

void MessageActivity_EntityFrozen(int client, int entity) {
    ShowActivity2(client, PREFIX, "%t", "Entity has been frozen", entity);
}

void MessageLog_EntityFrozen(int client, int entity) {
    LogMessage("\"%L\" froze entity %d", client, entity);
}

void MessageActivity_EntityUnfrozen(int client, int entity) {
    ShowActivity2(client, PREFIX, "%t", "Entity has been unfrozen", entity);
}

void MessageLog_EntityUnfrozen(int client, int entity) {
    LogMessage("\"%L\" unfroze entity %d", client, entity);
}

void MessageActivity_EntityDeleted(int client, int entity) {
    ShowActivity2(client, PREFIX, "%t", "Entity has been deleted", entity);
}

void MessageLog_EntityDeleted(int client, int entity) {
    LogMessage("\"%L\" deleted entity %d", client, entity);
}

void MessageActivity_EntityRestored(int client, int entity) {
    ShowActivity2(client, PREFIX, "%t", "Entity has been restored", entity);
}

void MessageLog_EntityRestored(int client, int entity) {
    LogMessage("\"%L\" restored entity %d", client, entity);
}

void MessageActivity_ListOfEntitiesCleared(int client) {
    ShowActivity2(client, PREFIX, "%t", "List of entities cleared");
}

void MessageLog_ListOfEntitiesCleared(int client) {
    LogMessage("\"%L\" cleared the list of entities", client);
}

void MessageActivity_EntitiesSaved(int client, int entitiesAmount) {
    ShowActivity2(client, PREFIX, "%t", "Entities saved", entitiesAmount);
}

void MessageLog_EntitiesSaved(int client, int entitiesAmount) {
    LogMessage("\"%L\" saved %d entities", client, entitiesAmount);
}

void MessageReply_NoEntitiesForLoading(int client) {
    if (client != CONSOLE) {
        ReplyToCommand(client, "%s%t", PREFIX, "No entities for loading");
    }
}

void MessageLog_NoEntitiesForLoading(int client) {
    if (client == CONSOLE) {
        LogMessage("No entities for this map");
    }
}

void MessageActivity_EntitiesLoaded(int client, int entitiesAmount) {
    if (client != CONSOLE) {
        ShowActivity2(client, PREFIX, "%t", "Entities loaded", entitiesAmount);
    }
}

void MessageLog_EntitiesLoaded(int client, int entitiesAmount) {
    if (client == CONSOLE) {
        LogMessage("Loaded %d entities", entitiesAmount);
    } else {
        LogMessage("\"%L\" loaded %d entities", client, entitiesAmount);
    }
}

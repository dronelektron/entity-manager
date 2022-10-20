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

void Message_EntityFrozen(int client, int entity) {
    ShowActivity2(client, PREFIX, "%t", "Entity has been frozen", entity);
    LogMessage("\"%L\" froze entity %d", client, entity);
}

void Message_EntityUnfrozen(int client, int entity) {
    ShowActivity2(client, PREFIX, "%t", "Entity has been unfrozen", entity);
    LogMessage("\"%L\" unfroze entity %d", client, entity);
}

void Message_EntityDeleted(int client, int entity) {
    ShowActivity2(client, PREFIX, "%t", "Entity has been deleted", entity);
    LogMessage("\"%L\" deleted entity %d", client, entity);
}

void Message_EntityRestored(int client, int entity) {
    ShowActivity2(client, PREFIX, "%t", "Entity has been restored", entity);
    LogMessage("\"%L\" restored entity %d", client, entity);
}

void Message_ListOfEntitiesCleared(int client) {
    ShowActivity2(client, PREFIX, "%t", "List of entities cleared");
    LogMessage("\"%L\" cleared the list of entities", client);
}

void Message_EntitiesSaved(int client, int entitiesAmount) {
    ShowActivity2(client, PREFIX, "%t", "Entities saved", entitiesAmount);
    LogMessage("\"%L\" saved %d entities", client, entitiesAmount);
}

void Message_NoEntitiesForLoading(int client) {
    if (client != CONSOLE) {
        ReplyToCommand(client, "%s%t", PREFIX, "No entities for loading");
    }

    if (client == CONSOLE) {
        LogMessage("No entities for this map");
    }
}

void Message_EntitiesLoaded(int client, int entitiesAmount) {
    if (client == CONSOLE) {
        LogMessage("Loaded %d entities", entitiesAmount);
    } else {
        ShowActivity2(client, PREFIX, "%t", "Entities loaded", entitiesAmount);
        LogMessage("\"%L\" loaded %d entities", client, entitiesAmount);
    }
}

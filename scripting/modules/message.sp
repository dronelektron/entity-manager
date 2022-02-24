void Message_ReplyEntityNotFound(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity not found");
}

void Message_ReplyEntityAlreadyHasAction(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity already has an action", entity);
}

void Message_ReplyEntityNotFrozen(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity not frozen", entity);
}

void Message_ReplyEntityNotDeleted(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity not deleted", entity);
}

void Message_ActivityEntityFrozen(int client, int entity) {
    ShowActivity2(client, PREFIX, "%t", "Entity has been frozen", entity);
}

void Message_LogEntityFrozen(int client, int entity) {
    LogMessage("\"%L\" froze entity %d", client, entity);
}

void Message_ActivityEntityUnfrozen(int client, int entity) {
    ShowActivity2(client, PREFIX, "%t", "Entity has been unfrozen", entity);
}

void Message_LogEntityUnfrozen(int client, int entity) {
    LogMessage("\"%L\" unfroze entity %d", client, entity);
}

void Message_ActivityEntityDeleted(int client, int entity) {
    ShowActivity2(client, PREFIX, "%t", "Entity deleted", entity);
}

void Message_LogEntityDeleted(int client, int entity) {
    LogMessage("\"%L\" deleted entity %d", client, entity);
}

void Message_ActivityEntityRestored(int client, int entity) {
    ShowActivity2(client, PREFIX, "%t", "Entity restored", entity);
}

void Message_LogEntityRestored(int client, int entity) {
    LogMessage("\"%L\" restored entity %d", client, entity);
}

void Message_ActivityListOfEntitiesCleared(int client) {
    ShowActivity2(client, PREFIX, "%t", "List of entities cleared");
}

void Message_LogListOfEntitiesCleared(int client) {
    LogMessage("\"%L\" cleared the list of entities", client);
}

void Message_ActivityEntitiesSaved(int client, int entitiesAmount) {
    ShowActivity2(client, PREFIX, "%t", "Entities saved", entitiesAmount);
}

void Message_LogEntitiesSaved(int client, int entitiesAmount) {
    LogMessage("\"%L\" saved %d entities", client, entitiesAmount);
}

void Message_ReplyNoEntitiesForLoading(int client) {
    if (client != CONSOLE) {
        ReplyToCommand(client, "%s%t", PREFIX, "No entities for loading");
    }
}

void Message_LogNoEntitiesForLoading(int client) {
    if (client == CONSOLE) {
        LogMessage("No entities for this map");
    }
}

void Message_ActivityEntitiesLoaded(int client, int entitiesAmount) {
    if (client != CONSOLE) {
        ShowActivity2(client, PREFIX, "%t", "Entities loaded", entitiesAmount);
    }
}

void Message_LogEntitiesLoaded(int client, int entitiesAmount) {
    if (client == CONSOLE) {
        LogMessage("Loaded %d entities", entitiesAmount);
    } else {
        LogMessage("\"%L\" loaded %d entities", client, entitiesAmount);
    }
}

void Message_EntityNotFound(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity not found");
}

void Message_EntityAlreadyHasAction(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity already has an action", entity);
}

void Message_EntityNotFrozen(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity not frozen", entity);
}

void Message_EntityNotDeleted(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity not deleted", entity);
}

void Message_EntityFrozen(int client, int entity, MessageType type = MessageType_Reply) {
    if (type == MessageType_Reply) {
        ReplyToCommand(client, "%s%t", PREFIX, "Entity has been frozen", entity);
    } else if (type == MessageType_Log) {
        LogMessage("\"%L\" froze entity %d", client, entity);
    }
}

void Message_EntityUnfrozen(int client, int entity, MessageType type = MessageType_Reply) {
    if (type == MessageType_Reply) {
        ReplyToCommand(client, "%s%t", PREFIX, "Entity has been unfrozen", entity);
    } else if (type == MessageType_Log) {
        LogMessage("\"%L\" unfroze entity %d", client, entity);
    }
}

void Message_EntityDeleted(int client, int entity, MessageType type = MessageType_Reply) {
    if (type == MessageType_Reply) {
        ReplyToCommand(client, "%s%t", PREFIX, "Entity deleted", entity);
    } else if (type == MessageType_Log) {
        LogMessage("\"%L\" deleted entity %d", client, entity);
    }
}

void Message_EntityRestored(int client, int entity, MessageType type = MessageType_Reply) {
    if (type == MessageType_Reply) {
        ReplyToCommand(client, "%s%t", PREFIX, "Entity restored", entity);
    } else if (type == MessageType_Log) {
        LogMessage("\"%L\" restored entity %d", client, entity);
    }
}

void Message_ListOfEntitiesCleared(int client, MessageType type = MessageType_Reply) {
    if (type == MessageType_Reply) {
        ReplyToCommand(client, "%s%t", PREFIX, "List of entities cleared");
    } else if (type == MessageType_Log) {
        LogMessage("\"%L\" cleared the list of entities", client);
    }
}

void Message_EntitiesSaved(int client, int entitiesAmount, MessageType type = MessageType_Reply) {
    if (type == MessageType_Reply) {
        ReplyToCommand(client, "%s%t", PREFIX, "Entities saved", entitiesAmount);
    } else if (type == MessageType_Log) {
        LogMessage("\"%L\" saved %d entities", client, entitiesAmount);
    }
}

void Message_NoEntitiesForLoading(int client, MessageType type = MessageType_Reply) {
    if (type == MessageType_Reply) {
        ReplyToCommand(client, "%s%t", PREFIX, "No entities for loading");
    } else if (type == MessageType_Log && client == CONSOLE) {
        LogMessage("No entities for this map");
    }
}

void Message_EntitiesLoaded(int client, int entitiesAmount, MessageType type = MessageType_Reply) {
    if (type == MessageType_Reply) {
        ReplyToCommand(client, "%s%t", PREFIX, "Entities loaded", entitiesAmount);
    } else if (type == MessageType_Log) {
        if (client == CONSOLE) {
            LogMessage("Loaded %d entities", entitiesAmount);
        } else {
            LogMessage("\"%L\" loaded %d entities", client, entitiesAmount);
        }
    }
}

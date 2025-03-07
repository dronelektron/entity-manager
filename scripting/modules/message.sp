void Message_EntityNotFound(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity not found");
}

void Message_EntityNotPhysical(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity not physical");
}

void Message_EntityWithoutHammerId(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity without HammerID");
}

void Message_EntityWithAction(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity with action");
}

void Message_EntityWithoutAction(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity without action");
}

void Message_EntityListEmpty(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity list empty");
}

void Message_EntityFrozen(int client, int hammerId) {
    ShowActivity2(client, PREFIX, "%t", "Entity frozen", hammerId);
    LogMessage("\"%L\" froze the entity %d", client, hammerId);
}

void Message_EntityUnfrozen(int client, int hammerId) {
    ShowActivity2(client, PREFIX, "%t", "Entity unfrozen", hammerId);
    LogMessage("\"%L\" unfroze the entity %d", client, hammerId);
}

void Message_EntityDeleted(int client, int hammerId) {
    ShowActivity2(client, PREFIX, "%t", "Entity deleted", hammerId);
    LogMessage("\"%L\" deleted the entity %d", client, hammerId);
}

void Message_EntityRestored(int client, int hammerId) {
    ShowActivity2(client, PREFIX, "%t", "Entity restored", hammerId);
    LogMessage("\"%L\" restored the entity %d", client, hammerId);
}

void Message_ShowPathUsage(int client) {
    ReplyToCommand(client, "%s%s", PREFIX, "Usage: sm_entitymanager_show_path <hammerid>");
}

void Message_EntitiesSaved(int client) {
    if (client == CONSOLE) {
        LogMessage("Entities are saved");
    } else {
        ShowActivity2(client, PREFIX, "%t", "Entities saved");
        LogMessage("\"%L\" saved the entities", client);
    }
}

void Message_EntitiesLoaded(int client) {
    if (client == CONSOLE) {
        LogMessage("Entities are loaded");
    } else {
        ShowActivity2(client, PREFIX, "%t", "Entities loaded");
        LogMessage("\"%L\" loaded the entities", client);
    }
}

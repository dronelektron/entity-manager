void Message_ReplyEntityNotFound(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity not found");
}

void Message_ReplyEntityAlreadyHasAction(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity already has an action", entity);
}

void Message_ReplyEntityHasNoActions(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity has no actions", entity);
}

void Message_ReplyEntityFrozen(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity has been frozen", entity);
}

void Message_ReplyEntityUnfrozen(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity has been unfrozen", entity);
}

void Message_ReplyEntityDeleted(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity deleted", entity);
}

void Message_ReplyEntityRestored(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity restored", entity);
}

void Message_ReplyEntitiesSaved(int client, int entitiesCount) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entities saved", entitiesCount);
}

void Message_LogFrozeEntity(int client, int entity) {
    LogMessage("\"%L\" froze entity %d", client, entity);
}

void Message_LogUnfrozeEntity(int client, int entity) {
    LogMessage("\"%L\" unfroze entity %d", client, entity);
}

void Message_LogEntityDeleted(int client, int entity) {
    LogMessage("\"%L\" deleted entity %d", client, entity);
}

void Message_LogEntityRestored(int client, int entity) {
    LogMessage("\"%L\" restored entity %d", client, entity);
}

void Message_LogEntitiesSaved(int client, int entitiesAmount) {
    LogMessage("\"%L\" saved %d entities", client, entitiesAmount);
}

void Message_ReplyEntityNotFound(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity not found");
}

void Message_ReplyEntityFrozen(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity has been frozen", entity);
}

void Message_ReplyEntityAlreadyFrozen(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity is already frozen", entity);
}

void Message_ReplyEntityUnfrozen(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity has been unfrozen", entity);
}

void Message_ReplyEntityAlreadyUnfrozen(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entity is already unfrozen", entity);
}

void Message_ReplyEntitiesSaved(int client, int entitiesCount) {
    ReplyToCommand(client, "%s%t", PREFIX, "Entities saved", entitiesCount);
}

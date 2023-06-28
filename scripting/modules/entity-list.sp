static ArrayList g_entities = null;

void EntityList_Create() {
    g_entities = new ArrayList();
}

void EntityList_Clear() {
    g_entities.Clear();
}

int EntityList_Size() {
    return g_entities.Length / ENTITY_FIELDS_AMOUNT;
}

int EntityList_GetId(int index) {
    int offset = EntityList_GetOffset(index);

    return g_entities.Get(offset + ENTITY_FIELD_ID);
}

int EntityList_GetAction(int index) {
    int offset = EntityList_GetOffset(index);

    return g_entities.Get(offset + ENTITY_FIELD_ACTION);
}

bool EntityList_Contains(int entity) {
    return EntityList_Find(entity) != ENTITY_NOT_FOUND;
}

bool EntityList_IsFrozen(int entity) {
    return EntityList_CheckAction(entity, ENTITY_ACTION_FREEZE);
}

bool EntityList_IsDeleted(int entity) {
    return EntityList_CheckAction(entity, ENTITY_ACTION_DELETE);
}

void EntityList_Add(int entity, int action) {
    g_entities.Push(entity);
    g_entities.Push(action);
}

void EntityList_Remove(int entity) {
    int index = EntityList_Find(entity);

    if (index != ENTITY_NOT_FOUND) {
        int offset = EntityList_GetOffset(index);

        g_entities.Erase(offset + ENTITY_FIELD_ACTION);
        g_entities.Erase(offset + ENTITY_FIELD_ID);
    }
}

int EntityList_Find(int entity) {
    for (int entityIndex = 0; entityIndex < EntityList_Size(); entityIndex++) {
        int tempEntity = EntityList_GetId(entityIndex);

        if (entity == tempEntity) {
            return entityIndex;
        }
    }

    return ENTITY_NOT_FOUND;
}

int EntityList_GetOffset(int index) {
    return index * ENTITY_FIELDS_AMOUNT;
}

bool EntityList_CheckAction(int entity, int action) {
    int index = EntityList_Find(entity);

    if (index == ENTITY_NOT_FOUND) {
        return false;
    }

    return EntityList_GetAction(index) == action;
}

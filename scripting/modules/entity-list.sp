static ArrayList g_entities = null;

void EntityList_Create() {
    g_entities = new ArrayList();
}

void EntityList_Clear() {
    for (int entityIndex = 0; entityIndex < EntityList_Size(); entityIndex++) {
        StringMap data = g_entities.Get(entityIndex);

        CloseHandle(data);
    }

    g_entities.Clear();
}

int EntityList_Size() {
    return g_entities.Length;
}

void EntityList_Add(int entity, int action) {
    StringMap data = new StringMap();

    data.SetValue(KEY_ENTITY, entity);
    data.SetValue(KEY_ACTION, action);
    g_entities.Push(data);
}

void EntityList_Remove(int entity) {
    int index = EntityList_Find(entity);

    if (index != ENTITY_NOT_FOUND) {
        StringMap data = g_entities.Get(index);

        CloseHandle(data);
    }

    g_entities.Erase(index);
}

int EntityList_Find(int entity) {
    for (int entityIndex = 0; entityIndex < EntityList_Size(); entityIndex++) {
        StringMap data = g_entities.Get(entityIndex);
        int tempEntity = ENTITY_NOT_FOUND;

        data.GetValue(KEY_ENTITY, tempEntity);

        if (entity == tempEntity) {
            return entityIndex;
        }
    }

    return ENTITY_NOT_FOUND;
}

int EntityList_GetEntity(int index) {
    return EntityList_GetField(index, KEY_ENTITY);
}

int EntityList_GetAction(int index) {
    return EntityList_GetField(index, KEY_ACTION);
}

static int EntityList_GetField(int index, const char[] key) {
    StringMap data = g_entities.Get(index);
    int field;

    data.GetValue(key, field);

    return field;
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

static bool EntityList_CheckAction(int entity, int action) {
    int index = EntityList_Find(entity);

    if (index == ENTITY_NOT_FOUND) {
        return false;
    }

    return EntityList_GetAction(index) == action;
}

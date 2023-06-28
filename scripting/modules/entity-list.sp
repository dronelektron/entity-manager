static ArrayList g_entities = null;

void EntityList_Create() {
    g_entities = new ArrayList();
}

void EntityList_Clear() {
    for (int entityIndex = 0; entityIndex < EntityList_Size(); entityIndex++) {
        EntityList_RemoveItem(entityIndex);
    }

    g_entities.Clear();
}

int EntityList_EntitiesAmountWithAction() {
    int amount = 0;

    for (int entityIndex = 0; entityIndex < EntityList_Size(); entityIndex++) {
        int action = EntityList_GetAction(entityIndex);

        if (action != ENTITY_ACTION_NONE) {
            amount++;
        }
    }

    return amount;
}

int EntityList_Size() {
    return g_entities.Length;
}

void EntityList_Add(int entity, int action, const float position[3]) {
    StringMap item = EntityList_CreateItem(entity, action, position);

    g_entities.Push(item);
}

int EntityList_FindByEntity(int entity) {
    for (int entityIndex = 0; entityIndex < EntityList_Size(); entityIndex++) {
        StringMap item = g_entities.Get(entityIndex);
        int tempEntity = ENTITY_NOT_FOUND;

        item.GetValue(KEY_ENTITY, tempEntity);

        if (entity == tempEntity) {
            return entityIndex;
        }
    }

    return ENTITY_NOT_FOUND;
}

int EntityList_FindByPosition(const float position[3]) {
    float tempPosition[3];

    for (int entityIndex = 0; entityIndex < EntityList_Size(); entityIndex++) {
        StringMap item = g_entities.Get(entityIndex);

        item.GetArray(KEY_POSITION, tempPosition, sizeof(tempPosition));

        if (GetVectorDistance(position, tempPosition, SQUARED_YES) <= ENTITY_POSITION_THRESHOLD) {
            return entityIndex;
        }
    }

    return ENTITY_NOT_FOUND;
}

int EntityList_GetEntity(int index) {
    return EntityList_GetField(index, KEY_ENTITY);
}

void EntityList_SetEntity(int index, int entity) {
    EntityList_SetField(index, KEY_ENTITY, entity);
}

int EntityList_GetAction(int index) {
    return EntityList_GetField(index, KEY_ACTION);
}

void EntityList_SetAction(int index, int action) {
    EntityList_SetField(index, KEY_ACTION, action);
}

void EntityList_GetPosition(int index, float position[3]) {
    StringMap item = g_entities.Get(index);

    item.GetArray(KEY_POSITION, position, sizeof(position));
}

void EntityList_SetActionByEntity(int entity, int action) {
    int entityIndex = EntityList_FindByEntity(entity);

    EntityList_SetAction(entityIndex, action);
}

bool EntityList_HasAction(int entity) {
    return !EntityList_CheckAction(entity, ENTITY_ACTION_NONE);
}

bool EntityList_IsFrozen(int entity) {
    return EntityList_CheckAction(entity, ENTITY_ACTION_FREEZE);
}

bool EntityList_IsDeleted(int entity) {
    return EntityList_CheckAction(entity, ENTITY_ACTION_DELETE);
}

static StringMap EntityList_CreateItem(int entity, int action, const float position[3]) {
    StringMap item = new StringMap();

    item.SetValue(KEY_ENTITY, entity);
    item.SetValue(KEY_ACTION, action);
    item.SetArray(KEY_POSITION, position, sizeof(position));

    return item;
}

static void EntityList_RemoveItem(int index) {
    StringMap item = g_entities.Get(index);

    CloseHandle(item);
}

static bool EntityList_CheckAction(int entity, int action) {
    int entityIndex = EntityList_FindByEntity(entity);

    return EntityList_GetAction(entityIndex) == action;
}

static int EntityList_GetField(int index, const char[] key) {
    StringMap item = g_entities.Get(index);
    int value;

    item.GetValue(key, value);

    return value;
}

static void EntityList_SetField(int index, const char[] key, int value) {
    StringMap item = g_entities.Get(index);

    item.SetValue(key, value);
}

static ArrayList g_items;

void EntityList_Create() {
    g_items = new ArrayList();
}

void EntityList_Clear() {
    for (int i = 0; i < g_items.Length; i++) {
        ClearItem(i);
    }

    g_items.Clear();
}

int EntityList_Size() {
    return g_items.Length;
}

void EntityList_Add(int entity, int hammerId, int action) {
    StringMap item = CreateItem(entity, hammerId, action);

    g_items.Push(item);
}

int EntityList_GetHammerId(int index) {
    StringMap item = g_items.Get(index);

    return GetValue(item, KEY_HAMMER_ID, INVALID_HAMMER_ID);
}

int EntityList_GetAction(int index) {
    StringMap item = g_items.Get(index);

    return GetValue(item, KEY_ACTION, INVALID_INDEX);
}

void EntityList_RemoveByHammerId(int hammerId) {
    int index = FindByHammerId(hammerId);

    if (index > INVALID_INDEX) {
        ClearItem(index);

        g_items.Erase(index);
    }
}

int EntityList_GetEntityByHammerId(int hammerId) {
    int index = FindByHammerId(hammerId);

    if (index == INVALID_INDEX) {
        return INVALID_INDEX;
    }

    return GetEntity(index);
}

void EntityList_SetEntityByHammerId(int hammerId, int entity) {
    int index = FindByHammerId(hammerId);

    if (index > INVALID_INDEX) {
        SetEntity(index, entity);
    }
}

int EntityList_GetActionByHammerId(int hammerId) {
    int index = FindByHammerId(hammerId);

    if (index == INVALID_INDEX) {
        return INVALID_INDEX;
    }

    return EntityList_GetAction(index);
}

static StringMap CreateItem(int entity, int hammerId, int action) {
    StringMap item = new StringMap();

    item.SetValue(KEY_ENTITY, entity);
    item.SetValue(KEY_HAMMER_ID, hammerId);
    item.SetValue(KEY_ACTION, action);

    return item;
}

static void ClearItem(int index) {
    StringMap item = g_items.Get(index);

    delete item;
}

static int FindByHammerId(int hammerId) {
    for (int i = 0; i < g_items.Length; i++) {
        if (EntityList_GetHammerId(i) == hammerId) {
            return i;
        }
    }

    return INVALID_INDEX;
}

static int GetEntity(int index) {
    StringMap item = g_items.Get(index);

    return GetValue(item, KEY_ENTITY, INVALID_INDEX);
}

static void SetEntity(int index, int entity) {
    StringMap item = g_items.Get(index);

    item.SetValue(KEY_ENTITY, entity);
}

static any GetValue(StringMap item, const char[] key, any defaultValue) {
    any value = defaultValue;

    item.GetValue(key, value);

    return value;
}

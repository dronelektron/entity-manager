static ArrayList g_entities = null;

void EntityList_Create() {
    g_entities = new ArrayList();
}

void EntityList_Destroy() {
    delete g_entities;
}

void EntityList_Clear() {
    g_entities.Clear();
}

int EntityList_Size() {
    return g_entities.Length;
}

int EntityList_Get(int index) {
    return g_entities.Get(index);
}

bool EntityList_Contains(int entity) {
    return g_entities.FindValue(entity) != ENTITY_NOT_FOUND;
}

void EntityList_Add(int entity) {
    g_entities.Push(entity);
}

void EntityList_Remove(int entity) {
    int index = g_entities.FindValue(entity);

    if (index != ENTITY_NOT_FOUND) {
        g_entities.Erase(index);
    }
}

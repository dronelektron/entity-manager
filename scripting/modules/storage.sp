static char g_mapName[MAP_NAME_MAX_LENGTH];
static char g_configPath[PLATFORM_MAX_PATH];

void Storage_SaveCurrentMapName() {
    GetCurrentMap(g_mapName, sizeof(g_mapName));
}

void Storage_BuildConfigPath() {
    BuildPath(Path_SM, g_configPath, sizeof(g_configPath), "configs/entity-manager.txt");
}

void Storage_SaveEntities(KeyValues kv) {
    int entitiesAmount = EntityList_Size();

    if (kv.JumpToKey(g_mapName)) {
        kv.DeleteThis();
        kv.Rewind();
    }

    if (entitiesAmount > 0) {
        kv.JumpToKey(g_mapName, true);
    }

    char entityNumber[STORAGE_ENTITY_ID_MAX_LENGTH];

    for (int i = 0; i < entitiesAmount; i++) {
        IntToString(i + 1, entityNumber, sizeof(entityNumber));

        kv.JumpToKey(entityNumber, true);

        int entity = EntityList_Get(i);

        kv.SetNum(STORAGE_KEY_ENTITY, entity);
        kv.GoBack();
    }

    kv.Rewind();
    kv.ExportToFile(g_configPath);
}

void Storage_LoadEntities(KeyValues kv) {
    EntityList_Clear();

    if (!kv.JumpToKey(g_mapName) || !kv.GotoFirstSubKey()) {
        return;
    }

    do {
        int entity = kv.GetNum(STORAGE_KEY_ENTITY);

        EntityList_Add(entity);
    } while (kv.GotoNextKey());
}

void Storage_Apply(StorageOperation operation) {
    KeyValues kv = new KeyValues("Entities");

    if (FileExists(g_configPath)) {
        kv.ImportFromFile(g_configPath);
        kv.Rewind();
    }

    Call_StartFunction(INVALID_HANDLE, operation);
    Call_PushCell(kv);
    Call_Finish();

    delete kv;
}

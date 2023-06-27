static char g_configPath[PLATFORM_MAX_PATH];

void Storage_BuildConfigPath() {
    BuildPath(Path_SM, g_configPath, sizeof(g_configPath), "configs/entity-manager");

    if (!DirExists(g_configPath)) {
        CreateDirectory(g_configPath, PERMISSIONS);
    }

    char mapName[PLATFORM_MAX_PATH];

    GetCurrentMap(mapName, sizeof(mapName));
    Format(g_configPath, sizeof(g_configPath), "%s/%s.txt", g_configPath, mapName);
}

void Storage_SaveEntities(KeyValues kv) {
    DeleteFile(g_configPath);

    int entitiesAmount = EntityList_Size();

    if (entitiesAmount == 0) {
        return;
    }

    char entityId[STORAGE_ENTITY_ID_MAX_LENGTH];

    for (int entityIndex = 0; entityIndex < entitiesAmount; entityIndex++) {
        int entity = EntityList_GetId(entityIndex);
        int action = EntityList_GetAction(entityIndex);

        IntToString(entity, entityId, sizeof(entityId));

        kv.JumpToKey(entityId, CREATE_YES);
        kv.SetNum(STORAGE_KEY_ACTION, action);
        kv.GoBack();
    }

    kv.Rewind();
    kv.ExportToFile(g_configPath);
}

void Storage_LoadEntities(KeyValues kv) {
    EntityList_Clear();

    if (FileExists(g_configPath)) {
        kv.ImportFromFile(g_configPath);
    }

    if (!kv.GotoFirstSubKey()) {
        return;
    }

    char entityId[STORAGE_ENTITY_ID_MAX_LENGTH];

    do {
        kv.GetSectionName(entityId, sizeof(entityId));

        int entity = StringToInt(entityId);
        int action = kv.GetNum(STORAGE_KEY_ACTION);

        EntityList_Add(entity, action);
    } while (kv.GotoNextKey());
}

void Storage_Apply(StorageOperation operation) {
    KeyValues kv = new KeyValues("Entities");

    Call_StartFunction(INVALID_HANDLE, operation);
    Call_PushCell(kv);
    Call_Finish();

    delete kv;
}

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
    float position[3];

    for (int entityIndex = 0; entityIndex < entitiesAmount; entityIndex++) {
        int action = EntityList_GetAction(entityIndex);

        if (action == ENTITY_ACTION_NONE) {
            continue;
        }

        IntToString(entityIndex + 1, entityId, sizeof(entityId));
        EntityList_GetPosition(entityIndex, position);

        kv.JumpToKey(entityId, CREATE_YES);
        kv.SetNum(KEY_ACTION, action);
        kv.SetVector(KEY_POSITION, position);
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

    float position[3];

    do {
        int action = kv.GetNum(KEY_ACTION);

        kv.GetVector(KEY_POSITION, position);

        UseCase_UpdateEntityFromFile(action, position);
    } while (kv.GotoNextKey());
}

void Storage_Apply(StorageOperation operation) {
    KeyValues kv = new KeyValues("EntityManager");

    Call_StartFunction(INVALID_HANDLE, operation);
    Call_PushCell(kv);
    Call_Finish();

    delete kv;
}

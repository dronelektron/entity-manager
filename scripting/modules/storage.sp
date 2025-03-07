static char g_configPath[PLATFORM_MAX_PATH];

void Storage_BuildConfigPath() {
    BuildPath(Path_SM, g_configPath, sizeof(g_configPath), "configs/entity-manager");

    if (!DirExists(g_configPath)) {
        CreateDirectory(g_configPath, PERMISSIONS);
    }

    char mapName[PLATFORM_MAX_PATH];

    GetCurrentMap(mapName, sizeof(mapName));
    FormatEx(g_configPath, sizeof(g_configPath), "%s/%s.txt", g_configPath, mapName);
}

void Storage_Apply(StorageOperation operation) {
    KeyValues kv = new KeyValues("EntityManager");

    Call_StartFunction(CURRENT_PLUGIN, operation);
    Call_PushCell(kv);
    Call_Finish();

    delete kv;
}

void Storage_SaveEntities(KeyValues kv) {
    DeleteFile(g_configPath);

    int entitiesAmount = EntityList_Size();

    if (entitiesAmount == 0) {
        return;
    }

    char sectionName[HAMMER_ID_SIZE];

    for (int i = 0; i < entitiesAmount; i++) {
        int hammerId = EntityList_GetHammerId(i);
        int action = EntityList_GetAction(i);

        IntToString(hammerId, sectionName, sizeof(sectionName));

        kv.JumpToKey(sectionName, CREATE_YES);
        kv.SetNum(KEY_ACTION, action);
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

    char sectionName[HAMMER_ID_SIZE];

    do {
        kv.GetSectionName(sectionName, sizeof(sectionName));

        int hammerId = StringToInt(sectionName);
        int action = kv.GetNum(KEY_ACTION);

        EntityList_Add(INVALID_INDEX, hammerId, action);
    } while (kv.GotoNextKey());
}

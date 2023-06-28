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

    char name[ENTITY_NAME_SIZE];
    float position[3];

    for (int entityIndex = 0; entityIndex < entitiesAmount; entityIndex++) {
        int action = EntityList_GetAction(entityIndex);

        if (action == ENTITY_ACTION_NONE) {
            continue;
        }

        Storage_GenerateUniqueName(kv, name);
        EntityList_GetPosition(entityIndex, position);

        kv.JumpToKey(name, CREATE_YES);
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

static void Storage_GenerateUniqueName(KeyValues kv, char[] name) {
    // "while (true)" gives warning 206
    for (;;) {
        Storage_GenerateName(name);

        if (kv.JumpToKey(name)) {
            kv.GoBack();
        } else {
            break;
        }
    }
}

static void Storage_GenerateName(char[] name) {
    int randomInt = GetRandomInt(0, ~(1 << 31));

    Format(name, ENTITY_NAME_SIZE, "%08X", randomInt);
}

static ConVar g_freezeEntities = null;
static ConVar g_deleteEntities = null;

void Variable_Create() {
    g_freezeEntities = CreateConVar("sm_entitymanager_allow_freeze", "1");
    g_deleteEntities = CreateConVar("sm_entitymanager_allow_deletion", "1");
}

bool Variable_IsFreezeAllowed() {
    return g_freezeEntities.IntValue == 1;
}

bool Variable_IsDeletionAllowed() {
    return g_deleteEntities.IntValue == 1;
}

static StringMap g_propPhysics;

void EntityFilter_Create() {
    g_propPhysics = new StringMap();
    g_propPhysics.SetValue(PROP_PHYSICS, NO_VALUE);
    g_propPhysics.SetValue(PROP_PHYSICS_OVERRIDE, NO_VALUE);
    g_propPhysics.SetValue(PROP_PHYSICS_MULTIPLAYER, NO_VALUE);
}

bool EntityFilter_IsNotPhysical(int entity) {
    char className[CLASS_NAME_SIZE];

    GetEntityClassname(entity, className, sizeof(className));

    return !g_propPhysics.ContainsKey(className);
}

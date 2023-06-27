void Entity_Freeze(int entity) {
    AcceptEntityInput(entity, "DisableMotion");
}

void Entity_Unfreeze(int entity) {
    AcceptEntityInput(entity, "EnableMotion");
}

void Entity_Delete(int entity) {
    Entity_Freeze(entity);
    Entity_SetVisibility(entity, ENTITY_VISIBLE_NO);
}

void Entity_Restore(int entity) {
    Entity_SetVisibility(entity, ENTITY_VISIBLE_YES);
    Entity_Unfreeze(entity);
}

void Entity_SetVisibility(int entity, bool isVisible) {
    int effects = Entity_GetEffects(entity);

    if (isVisible) {
        Entity_RemoveEffect(effects, EFFECT_FLAG_NO_DRAW);
        Entity_SetSolidType(entity, SOLID_TYPE_VPHYSICS);
    } else {
        Entity_AddEffect(effects, EFFECT_FLAG_NO_DRAW);
        Entity_SetSolidType(entity, SOLID_TYPE_NONE);
    }

    Entity_SetEffects(entity, effects);
}

int Entity_Trace(int client) {
    float eyesPosition[VECTOR_SIZE];
    float eyesAngles[VECTOR_SIZE];

    GetClientEyePosition(client, eyesPosition);
    GetClientEyeAngles(client, eyesAngles);

    Handle trace = TR_TraceRayFilterEx(eyesPosition, eyesAngles, MASK_SHOT, RayType_Infinite, TraceEntityFilter_Players);
    int entity = TR_GetEntityIndex(trace);

    CloseHandle(trace);

    return entity;
}

bool TraceEntityFilter_Players(int entity, int contentsMask) {
    return entity > MaxClients;
}

void Entity_AddEffect(int& effects, int flag) {
    effects |= flag;
}

void Entity_RemoveEffect(int& effects, int flag) {
    effects &= ~flag;
}

int Entity_GetEffects(int entity) {
    return GetEntProp(entity, Prop_Send, ENT_PROP_EFFECTS);
}

void Entity_SetEffects(int entity, int effects) {
    SetEntProp(entity, Prop_Send, ENT_PROP_EFFECTS, effects);
}

void Entity_SetSolidType(int entity, int solidType) {
    SetEntProp(entity, Prop_Send, ENT_PROP_SOLID_TYPE, solidType);
}

void Entity_GetPosition(int entity, float position[VECTOR_SIZE]) {
    GetEntPropVector(entity, Prop_Send, ENT_PROP_VEC_ORIGIN, position);
}

void Entity_GetMinBounds(int entity, float minBounds[VECTOR_SIZE]) {
    GetEntPropVector(entity, Prop_Send, ENT_PROP_VEC_MINS, minBounds);
}

void Entity_GetMaxBounds(int entity, float maxBounds[VECTOR_SIZE]) {
    GetEntPropVector(entity, Prop_Send, ENT_PROP_VEC_MAXS, maxBounds);
}

void Entity_GetAngles(int entity, float angles[VECTOR_SIZE]) {
    GetEntPropVector(entity, Prop_Send, ENT_PROP_ANG_ROTATION, angles);
}

bool Entity_IsPropPhysics(int entity) {
    char className[ENTITY_CLASS_NAME_SIZE];

    GetEntityClassname(entity, className, sizeof(className));

    bool isPropPhysics = strcmp(className, PROP_PHYSICS) == 0;
    bool isPropPhysicsMultiplayer = strcmp(className, PROP_PHYSICS_MULTIPLAYER) == 0;

    return isPropPhysics || isPropPhysicsMultiplayer;
}

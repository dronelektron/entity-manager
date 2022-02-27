void Entity_Freeze(int entity) {
    AcceptEntityInput(entity, "DisableMotion");
}

void Entity_Unfreeze(int entity) {
    AcceptEntityInput(entity, "EnableMotion");
}

void Entity_Delete(int entity) {
    Entity_Freeze(entity);
    Entity_Hide(entity);
}

void Entity_Restore(int entity) {
    Entity_Show(entity);
    Entity_Unfreeze(entity);
}

void Entity_Hide(int entity) {
    int effects = GetEntProp(entity, Prop_Send, ENT_PROP_EFFECTS);

    effects |= EFFECT_FLAG_NO_DRAW;

    SetEntProp(entity, Prop_Send, ENT_PROP_EFFECTS, effects);
    SetEntProp(entity, Prop_Send, ENT_PROP_SOLID_TYPE, SOLID_TYPE_NONE);
}

void Entity_Show(int entity) {
    int effects = GetEntProp(entity, Prop_Send, ENT_PROP_EFFECTS);

    effects &= ~EFFECT_FLAG_NO_DRAW;

    SetEntProp(entity, Prop_Send, ENT_PROP_EFFECTS, effects);
    SetEntProp(entity, Prop_Send, ENT_PROP_SOLID_TYPE, SOLID_TYPE_VPHYSICS);
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

void Entity_GetPosition(int entity, float position[VECTOR_SIZE]) {
    GetEntPropVector(entity, Prop_Send, "m_vecOrigin", position);
}

void Entity_GetMinBounds(int entity, float minBounds[VECTOR_SIZE]) {
    GetEntPropVector(entity, Prop_Send, "m_vecMins", minBounds);
}

void Entity_GetMaxBounds(int entity, float maxBounds[VECTOR_SIZE]) {
    GetEntPropVector(entity, Prop_Send, "m_vecMaxs", maxBounds);
}

void Entity_GetAngles(int entity, float angles[VECTOR_SIZE]) {
    GetEntPropVector(entity, Prop_Send, "m_angRotation", angles);
}

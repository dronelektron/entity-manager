void Entity_Freeze(int entity) {
    AcceptEntityInput(entity, "DisableMotion");
}

void Entity_Unfreeze(int entity) {
    AcceptEntityInput(entity, "EnableMotion");
}

void Entity_Hide(int entity) {
    int effects = GetEntProp(entity, Prop_Send, ENT_PROP_EFFECTS);

    effects |= EFFECT_FLAG_NO_DRAW;

    SetEntProp(entity, Prop_Send, ENT_PROP_EFFECTS, effects);
    SetEntProp(entity, Prop_Send, ENT_PROP_SOLID_FLAGS, SOLID_FLAG_NO);
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

int Entity_Trace(int client) {
    float origin[3];
    float angles[3];

    GetClientEyePosition(client, origin);
    GetClientEyeAngles(client, angles);
    TR_TraceRayFilter(origin, angles, MASK_SHOT, RayType_Infinite, IgnoreClients);

    return TR_GetEntityIndex();
}

static bool IgnoreClients(int entity, int contentsMask) {
    return entity > MaxClients;
}

void Entity_Freeze_Toggle(int entity, bool enabled) {
    AcceptEntityInput(entity, enabled ? "DisableMotion" : "EnableMotion");
    SdkHook_OnTakeDamage_Toggle(entity, enabled);
}

void Entity_Delete_Toggle(int entity, bool enabled) {
    int effects = GetEffects(entity);

    AddEffect(effects, EFFECT_FLAG_NO_DRAW);

    if (enabled) {
        AddEffect(effects, EFFECT_FLAG_NO_DRAW);
    } else {
        RemoveEffect(effects, EFFECT_FLAG_NO_DRAW);
    }

    SetEffects(entity, effects);
    Entity_Freeze_Toggle(entity, enabled);
    SetSolidType(entity, enabled ? SOLID_TYPE_NONE : SOLID_TYPE_VPHYSICS);
}

static void SetSolidType(int entity, int solidType) {
    SetEntProp(entity, Prop_Send, ENTITY_PROPERTY_SOLID_TYPE, solidType);
}

static int GetEffects(int entity) {
    return GetEntProp(entity, Prop_Send, ENTITY_PROPERTY_EFFECTS);
}

static void SetEffects(int entity, int effects) {
    SetEntProp(entity, Prop_Send, ENTITY_PROPERTY_EFFECTS, effects);
}

static void AddEffect(int& effects, int flag) {
    effects |= flag;
}

static void RemoveEffect(int& effects, int flag) {
    effects &= ~flag;
}

int Entity_GetHammerId(int entity) {
    return GetEntProp(entity, Prop_Data, ENTITY_PROPERTY_HAMMER_ID);
}

void Entity_GetOrigin(int entity, float origin[3]) {
    GetEntPropVector(entity, Prop_Send, ENTITY_PROPERTY_VEC_ORIGIN, origin);
}

void Entity_GetAngles(int entity, float angles[3]) {
    GetEntPropVector(entity, Prop_Send, ENTITY_PROPERTY_ANG_ROTATION, angles);
}

void Entity_GetMins(int entity, float mins[3]) {
    GetEntPropVector(entity, Prop_Send, ENTITY_PROPERTY_VEC_MINS, mins);
}

void Entity_GetMaxs(int entity, float maxs[3]) {
    GetEntPropVector(entity, Prop_Send, ENTITY_PROPERTY_VEC_MAXS, maxs);
}

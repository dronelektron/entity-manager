void SdkHook_OnTakeDamage_Toggle(int entity, bool enabled) {
    if (enabled) {
        SDKHook(entity, SDKHook_OnTakeDamage, OnTakeDamage);
    } else {
        SDKUnhook(entity, SDKHook_OnTakeDamage, OnTakeDamage);
    }
}

static Action OnTakeDamage(int victim, int& attacker, int& inflictor, float& damage, int& damageType) {
    return Plugin_Handled;
}

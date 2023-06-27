void Event_Create() {
    HookEvent("dod_round_start", Event_RoundStart);
}

public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    UseCase_ApplyActionToEntities();
}

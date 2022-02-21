#if defined _em_storage_included
 #endinput
#endif
#define _em_storage_included

#define MAP_NAME_MAX_LENGTH (30 + 1)

#define STORAGE_KEY_ACTION "action"
#define STORAGE_ENTITY_ID_MAX_LENGTH (5 + 1)

typedef StorageOperation = function void (KeyValues kv);

#if defined _entity_manager_storage_included
 #endinput
#endif
#define _entity_manager_storage_included

#define PERMISSIONS_USER (FPERM_U_READ | FPERM_U_WRITE | FPERM_U_EXEC)
#define PERMISSIONS_GROUP (FPERM_G_READ | FPERM_G_EXEC)
#define PERMISSIONS_OTHER (FPERM_O_READ | FPERM_O_EXEC)
#define PERMISSIONS (PERMISSIONS_USER | PERMISSIONS_GROUP | PERMISSIONS_OTHER)

#define HAMMER_ID_SIZE 16
#define CREATE_YES true
#define CURRENT_PLUGIN null

typedef StorageOperation = function void (KeyValues kv);

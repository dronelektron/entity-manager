#if defined _entity_manager_entity_included
 #endinput
#endif
#define _entity_manager_entity_included

#define WORLD 0
#define INVALID_HAMMER_ID 0
#define CLASS_NAME_SIZE 32

#define EFFECT_FLAG_NO_DRAW (1 << 5)

#define SOLID_TYPE_NONE 0
#define SOLID_TYPE_VPHYSICS 6

#define ENTITY_PROPERTY_EFFECTS "m_fEffects"
#define ENTITY_PROPERTY_SOLID_TYPE "m_nSolidType"
#define ENTITY_PROPERTY_HAMMER_ID "m_iHammerID"
#define ENTITY_PROPERTY_VEC_ORIGIN "m_vecOrigin"
#define ENTITY_PROPERTY_ANG_ROTATION "m_angRotation"
#define ENTITY_PROPERTY_VEC_MINS "m_vecMins"
#define ENTITY_PROPERTY_VEC_MAXS "m_vecMaxs"

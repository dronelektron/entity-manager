#if defined _em_entity_included
 #endinput
#endif
#define _em_entity_included

#define ENTITY_NOT_FOUND -1
#define ENTITY_WORLD 0

#define ENT_PROP_EFFECTS "m_fEffects"
#define ENT_PROP_SOLID_TYPE "m_nSolidType"
#define ENT_PROP_VEC_ORIGIN "m_vecOrigin"
#define ENT_PROP_VEC_MINS "m_vecMins"
#define ENT_PROP_VEC_MAXS "m_vecMaxs"
#define ENT_PROP_ANG_ROTATION "m_angRotation"

#define EFFECT_FLAG_NO_DRAW (1 << 5)

#define SOLID_TYPE_NONE 0
#define SOLID_TYPE_VPHYSICS 6

#define ENTITY_VISIBLE_YES true
#define ENTITY_VISIBLE_NO false

#define ENTITY_CLASS_NAME_SIZE 32

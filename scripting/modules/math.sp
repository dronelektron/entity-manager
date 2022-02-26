void Math_CalculateMiddle(int entity, float middle[VECTOR_SIZE]) {
    float position[VECTOR_SIZE];
    float minBounds[VECTOR_SIZE];
    float maxBounds[VECTOR_SIZE];
    float globalMinBounds[VECTOR_SIZE];
    float globalMaxBounds[VECTOR_SIZE];

    GetEntPropVector(entity, Prop_Send, "m_vecOrigin", position);
    GetEntPropVector(entity, Prop_Send, "m_vecMins", minBounds);
    GetEntPropVector(entity, Prop_Send, "m_vecMaxs", maxBounds);

    AddVectors(position, minBounds, globalMinBounds);
    AddVectors(position, maxBounds, globalMaxBounds);
    AddVectors(globalMinBounds, globalMaxBounds, middle);
    ScaleVector(middle, HALF);
}

void Math_GetMiddle(int entity, float middle[3], bool rotate) {
    float origin[3];
    float mins[3];
    float maxs[3];

    Entity_GetOrigin(entity, origin);
    Entity_GetMins(entity, mins);
    Entity_GetMaxs(entity, maxs);

    if (rotate) {
        float anglesDeg[3];
        float anglesRad[3];
        float rotationMatrix[3][3];

        Entity_GetAngles(entity, anglesDeg);
        Math_DegreesToRadiansVector(anglesDeg, anglesRad);
        Math_GetRotationMatrix(anglesRad, rotationMatrix);
        Math_MultiplyMatrixByVector(rotationMatrix, mins, mins);
        Math_MultiplyMatrixByVector(rotationMatrix, maxs, maxs);
    }

    AddVectors(origin, mins, mins);
    AddVectors(origin, maxs, maxs);
    AddVectors(mins, maxs, middle);
    ScaleVector(middle, HALF);
}

void Math_GetRotatedVertices(int entity, float vertices[8][3]) {
    float origin[3];
    float anglesDeg[3];
    float anglesRad[3];
    float mins[3];
    float maxs[3];
    float rotationMatrix[3][3];

    Entity_GetOrigin(entity, origin);
    Entity_GetAngles(entity, anglesDeg);
    Entity_GetMins(entity, mins);
    Entity_GetMaxs(entity, maxs);
    Math_DegreesToRadiansVector(anglesDeg, anglesRad);
    Math_GetRotationMatrix(anglesRad, rotationMatrix);
    Math_GetVertices(mins, maxs, vertices);

    for (int i = 0; i < sizeof(vertices); i++) {
        Math_MultiplyMatrixByVector(rotationMatrix, vertices[i], vertices[i]);
        AddVectors(vertices[i], origin, vertices[i]);
    }
}

void Math_DegreesToRadiansVector(const float anglesDeg[3], float anglesRad[3]) {
    anglesRad[PITCH] = DegToRad(anglesDeg[PITCH]);
    anglesRad[YAW] = DegToRad(anglesDeg[YAW]);
    anglesRad[ROLL] = DegToRad(anglesDeg[ROLL]);
}

void Math_GetRotationMatrix(const float angles[3], float matrix[3][3]) {
    float cosBeta = Cosine(angles[PITCH]);
    float sinBeta = Sine(angles[PITCH]);
    float cosAlpha = Cosine(angles[YAW]);
    float sinAlpha = Sine(angles[YAW]);
    float cosGamma = Cosine(angles[ROLL]);
    float sinGamma = Sine(angles[ROLL]);

    matrix[0][0] = cosAlpha * cosBeta;
    matrix[0][1] = cosAlpha * sinBeta * sinGamma - sinAlpha * cosGamma;
    matrix[0][2] = cosAlpha * sinBeta * cosGamma + sinAlpha * sinGamma;
    matrix[1][0] = sinAlpha * cosBeta;
    matrix[1][1] = sinAlpha * sinBeta * sinGamma + cosAlpha * cosGamma;
    matrix[1][2] = sinAlpha * sinBeta * cosGamma - cosAlpha * sinGamma;
    matrix[2][0] = -sinBeta;
    matrix[2][1] = cosBeta * sinGamma;
    matrix[2][2] = cosBeta * cosGamma;
}

void Math_MultiplyMatrixByVector(const float matrix[3][3], const float vector[3], float result[3]) {
    float temp[3];

    for (int i = 0; i < 3; i++) {
        temp[i] = 0.0;

        for (int j = 0; j < 3; j++) {
            temp[i] += matrix[i][j] * vector[j];
        }
    }

    result = temp;
}

void Math_GetVertices(const float start[3], const float end[3], float vertices[8][3]) {
    float min[3];
    float max[3];

    min[X] = Min(start[X], end[X]);
    min[Y] = Min(start[Y], end[Y]);
    min[Z] = Min(start[Z], end[Z]);
    max[X] = Max(start[X], end[X]);
    max[Y] = Max(start[Y], end[Y]);
    max[Z] = Max(start[Z], end[Z]);

    FillVector(vertices[LEFT_FRONT_BOTTOM], min[X], max[Y], min[Z]);
    FillVector(vertices[LEFT_FRONT_TOP], min[X], max[Y], max[Z]);
    FillVector(vertices[LEFT_REAR_BOTTOM], min[X], min[Y], min[Z]);
    FillVector(vertices[LEFT_REAR_TOP], min[X], min[Y], max[Z]);
    FillVector(vertices[RIGHT_FRONT_BOTTOM], max[X], max[Y], min[Z]);
    FillVector(vertices[RIGHT_FRONT_TOP], max[X], max[Y], max[Z]);
    FillVector(vertices[RIGHT_REAR_BOTTOM], max[X], min[Y], min[Z]);
    FillVector(vertices[RIGHT_REAR_TOP], max[X], min[Y], max[Z]);
}

static void FillVector(float vector[3], float x, float y, float z) {
    vector[X] = x;
    vector[Y] = y;
    vector[Z] = z;
}

static float Min(float a, float b) {
    return a < b ? a : b;
}

static float Max(float a, float b) {
    return a > b ? a : b;
}

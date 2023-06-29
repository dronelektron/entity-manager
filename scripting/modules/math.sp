void Math_GetMiddle(int entity, float middle[3], bool rotateBounds) {
    float position[3];
    float minBounds[3];
    float maxBounds[3];
    float globalMinBounds[3];
    float globalMaxBounds[3];

    Entity_GetPosition(entity, position);
    Entity_GetMinBounds(entity, minBounds);
    Entity_GetMaxBounds(entity, maxBounds);

    if (rotateBounds) {
        float degAngles[3];
        float radAngles[3];
        float rotationMat[3][3];
        float rotatedMinBounds[3];
        float rotatedMaxBounds[3];

        Entity_GetAngles(entity, degAngles);

        Math_DegreesToRadiansVector(degAngles, radAngles);
        Math_GetRotationMatrix(radAngles, rotationMat);
        Math_MultiplyMatrixByVector(rotationMat, minBounds, rotatedMinBounds);
        Math_MultiplyMatrixByVector(rotationMat, maxBounds, rotatedMaxBounds);

        AddVectors(position, rotatedMinBounds, globalMinBounds);
        AddVectors(position, rotatedMaxBounds, globalMaxBounds);
    } else {
        AddVectors(position, minBounds, globalMinBounds);
        AddVectors(position, maxBounds, globalMaxBounds);
    }

    AddVectors(globalMinBounds, globalMaxBounds, middle);
    ScaleVector(middle, HALF);
}

void Math_DegreesToRadiansVector(const float degAngles[3], float radAngles[3]) {
    radAngles[PITCH] = DegToRad(degAngles[PITCH]);
    radAngles[YAW] = DegToRad(degAngles[YAW]);
    radAngles[ROLL] = DegToRad(degAngles[ROLL]);
}

void Math_GetRotationMatrix(const float angles[3], float rotationMat[3][3]) {
    float cosBeta = Cosine(angles[PITCH]);
    float sinBeta = Sine(angles[PITCH]);
    float cosAlpha = Cosine(angles[YAW]);
    float sinAlpha = Sine(angles[YAW]);
    float cosGamma = Cosine(angles[ROLL]);
    float sinGamma = Sine(angles[ROLL]);

    rotationMat[0][0] = cosAlpha * cosBeta;
    rotationMat[0][1] = cosAlpha * sinBeta * sinGamma - sinAlpha * cosGamma;
    rotationMat[0][2] = cosAlpha * sinBeta * cosGamma + sinAlpha * sinGamma;
    rotationMat[1][0] = sinAlpha * cosBeta;
    rotationMat[1][1] = sinAlpha * sinBeta * sinGamma + cosAlpha * cosGamma;
    rotationMat[1][2] = sinAlpha * sinBeta * cosGamma - cosAlpha * sinGamma;
    rotationMat[2][0] = -sinBeta;
    rotationMat[2][1] = cosBeta * sinGamma;
    rotationMat[2][2] = cosBeta * cosGamma;
}

void Math_MultiplyMatrixByVector(const float mat[3][3], const float vec[3], float result[3]) {
    float temp[3];

    for (int i = 0; i < 3; i++) {
        temp[i] = 0.0;

        for (int j = 0; j < 3; j++) {
            temp[i] += mat[i][j] * vec[j];
        }
    }

    result = temp;
}

void Math_GetVertices(const float start[3], const float end[3], float vertices[8][3]) {
    float min[3];
    float max[3];

    min[X] = Math_Min(start[X], end[X]);
    min[Y] = Math_Min(start[Y], end[Y]);
    min[Z] = Math_Min(start[Z], end[Z]);
    max[X] = Math_Max(start[X], end[X]);
    max[Y] = Math_Max(start[Y], end[Y]);
    max[Z] = Math_Max(start[Z], end[Z]);

    Math_FillVector(vertices[LEFT_FRONT_BOTTOM], min[X], max[Y], min[Z]);
    Math_FillVector(vertices[LEFT_FRONT_TOP], min[X], max[Y], max[Z]);
    Math_FillVector(vertices[LEFT_REAR_BOTTOM], min[X], min[Y], min[Z]);
    Math_FillVector(vertices[LEFT_REAR_TOP], min[X], min[Y], max[Z]);
    Math_FillVector(vertices[RIGHT_FRONT_BOTTOM], max[X], max[Y], min[Z]);
    Math_FillVector(vertices[RIGHT_FRONT_TOP], max[X], max[Y], max[Z]);
    Math_FillVector(vertices[RIGHT_REAR_BOTTOM], max[X], min[Y], min[Z]);
    Math_FillVector(vertices[RIGHT_REAR_TOP], max[X], min[Y], max[Z]);
}

void Math_FillVector(float vector[3], float x, float y, float z) {
    vector[X] = x;
    vector[Y] = y;
    vector[Z] = z;
}

float Math_Min(float a, float b) {
    return a < b ? a : b;
}

float Math_Max(float a, float b) {
    return a > b ? a : b;
}

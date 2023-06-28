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
    for (int i = 0; i < 3; i++) {
        result[i] = 0.0;

        for (int j = 0; j < 3; j++) {
            result[i] += mat[i][j] * vec[j];
        }
    }
}

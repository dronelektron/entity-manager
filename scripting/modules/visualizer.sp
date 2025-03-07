static int g_beamModelIndex;
static int g_beamHaloIndex;

static const int BEAM_COLOR[] = {255, 255, 0, 255};

void Visualizer_Precache() {
    g_beamModelIndex = PrecacheModel("materials/sprites/laser.vmt");
    g_beamHaloIndex  = PrecacheModel("materials/sprites/halo01.vmt");

    AssertModel(g_beamModelIndex);
    AssertModel(g_beamHaloIndex);
}

void Visualizer_DrawBeam(int client, const float start[3], const float end[3]) {
    TE_SetupBeamPoints(
        start,
        end,
        g_beamModelIndex,
        g_beamHaloIndex,
        BEAM_START_FRAME,
        BEAM_FRAME_RATE,
        BEAM_LIFE_TIME,
        BEAM_WIDTH,
        BEAM_END_WIDTH,
        BEAM_FADE_LENGTH,
        BEAM_AMPLITUDE,
        BEAM_COLOR,
        BEAM_SPEED
    );

    TE_SendToClient(client);
}

void Visualizer_DrawBox(int client, const float vertices[8][3]) {
    Visualizer_DrawBeam(client, vertices[LEFT_REAR_BOTTOM], vertices[RIGHT_REAR_BOTTOM]);
    Visualizer_DrawBeam(client, vertices[LEFT_REAR_TOP], vertices[RIGHT_REAR_TOP]);
    Visualizer_DrawBeam(client, vertices[LEFT_FRONT_BOTTOM], vertices[RIGHT_FRONT_BOTTOM]);
    Visualizer_DrawBeam(client, vertices[LEFT_FRONT_TOP], vertices[RIGHT_FRONT_TOP]);
    Visualizer_DrawBeam(client, vertices[LEFT_REAR_BOTTOM], vertices[LEFT_FRONT_BOTTOM]);
    Visualizer_DrawBeam(client, vertices[LEFT_REAR_TOP], vertices[LEFT_FRONT_TOP]);
    Visualizer_DrawBeam(client, vertices[RIGHT_REAR_BOTTOM], vertices[RIGHT_FRONT_BOTTOM]);
    Visualizer_DrawBeam(client, vertices[RIGHT_REAR_TOP], vertices[RIGHT_FRONT_TOP]);
    Visualizer_DrawBeam(client, vertices[LEFT_REAR_BOTTOM], vertices[LEFT_REAR_TOP]);
    Visualizer_DrawBeam(client, vertices[LEFT_FRONT_BOTTOM], vertices[LEFT_FRONT_TOP]);
    Visualizer_DrawBeam(client, vertices[RIGHT_REAR_BOTTOM], vertices[RIGHT_REAR_TOP]);
    Visualizer_DrawBeam(client, vertices[RIGHT_FRONT_BOTTOM], vertices[RIGHT_FRONT_TOP]);
}

static void AssertModel(int index) {
    if (index == INVALID_MODEL_INDEX) {
        SetFailState("Unable to precache a model");
    }
}

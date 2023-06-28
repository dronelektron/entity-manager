static int g_beamModelIndex;
static int g_beamHaloIndex;

static const int BEAM_COLOR[] = {255, 255, 0, 255};

void Visualizer_PrecacheTempEntityModels() {
    g_beamModelIndex = PrecacheModel("materials/sprites/laser.vmt");
    g_beamHaloIndex  = PrecacheModel("materials/sprites/halo01.vmt");
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

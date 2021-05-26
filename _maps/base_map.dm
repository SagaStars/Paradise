#include "map_files\hispania\z2.dmm"
#include "map_files\hispania\z4.dmm"
#include "map_files\hispania\z6.dmm"
#define CC_TRANSITION_CONFIG DECLARE_LEVEL(CENTCOMM, SELFLOOPING, list(ADMIN_LEVEL, BLOCK_TELEPORT, IMPEDES_MAGIC))
#define PLANET_SURFACE DECLARE_LEVEL(PLANET, SELFLOOPING, list(BLOCK_TELEPORT, IMPEDES_MAGIC, REACHABLE))
#define RANDOM_DERELICT_SHIP DECLARE_LEVEL(DERELICT, CROSSLINKED,  list(BLOCK_TELEPORT, IMPEDES_MAGIC, REACHABLE))
#ifdef CIMAP
#include "ci_map_testing.dm"
#endif

#if defined _em_use_case_included
 #endinput
#endif
#define _em_use_case_included

enum UseCaseResult {
    UseCaseResult_Success,
    UseCaseResult_EntityNotFound,
    UseCaseResult_AlreadyHasAction,
    UseCaseResult_NotFrozen,
    UseCaseResult_NotDeleted
};

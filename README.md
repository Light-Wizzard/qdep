# qdep
A very basic yet simple to use dependency management tool for qmake based projects

## vardump
- prf: qdep (explicit load)
- vars: QDEP_PATH, QDEP_VERSION, QDEP_CACHE_SCOPE, QDEP_TOOL, QDEP_DEPENDS, QDEP_LINK_DEPENDS, QDEP_EXPORTS, QDEP_PACKAGE_EXPORTS, QDEP_INCLUDEPATH, QDEP_DEFINES, QDEP_VAR_EXPORTS, QDEP_EXPORT_PATH, QDEP_EXPORT_NAME, QDEP_GENERATED_DIR, QDEP_GENERATED_SOURCES_DIR, QDEP_HOOK_FNS
- config(in): qdep_no_cache, qdep_no_link, qdep_no_pull, qdep_no_clone, qdep_export_all, qdep_no_qm_combine
- config(out): qdep_build
- tests: qdepCollectDependencies, qdepCollectLinkDependencies, qdepSplitPrivateVar
- replaces: qdepJoinPrivateVar
- env_vars: QDEP_CACHE_DIR, QDEP_SOURCE_OVERRIDE, QDEP_DEFAULT_PKG_FN
- install targets: qdep_ts_target
- private:
    - vars: __QDEP_INCLUDE_CACHE, __QDEP_REAL_DEPS_STACK, __QDEP_PRIVATE_VARS_EXPORT, __QDEP_PRIVATE_SEPERATOR, __QDEP_TUPLE_SEPERATOR, __QDEP_RESOURCES_OFFSET, __QDEP_RESOURCES_SUBSET, __QDEP_HOOK_FILES
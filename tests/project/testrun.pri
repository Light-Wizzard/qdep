CONFIG += console
CONFIG -= app_bundle

HEADERS += $$PWD/tests.h
INCLUDEPATH += $$PWD

!no_run_tests_target:!isEmpty(OUT_PWD) {
    win32:!ReleaseBuild:!DebugBuild {
        runtarget.target = run-tests
        runtarget.CONFIG = recursive
        runtarget.recurse_target = run-tests
        QMAKE_EXTRA_TARGETS += runtarget
    } else {
        oneshell.target = .ONESHELL
        QMAKE_EXTRA_TARGETS += oneshell

        LIB_DIRS = $$OUT_PWD
        LIB_DIRS_SHELL = $$shell_path($$OUT_PWD)
        prefix = "-L"
        for(lib_arg, LIBS):equals(prefix, $$str_member($$lib_arg, 0, 1)) {
	        lib_arg = $$str_member($$lib_arg, 2, -1)
            LIB_DIRS += $$lib_arg
            LIB_DIRS_SHELL += $$shell_path($$lib_arg)
        }
        message("Detected library paths as: $$LIB_DIRS")
        message("Detected shell library paths as: $$LIB_DIRS_SHELL")

        win32:!win32-g++ {
            CONFIG(debug, debug|release): outdir_helper = debug
            CONFIG(release, debug|release): outdir_helper = release
            runtarget.target = run-tests
            runtarget.depends += $(DESTDIR_TARGET)
            runtarget.commands += set PATH=$$join(LIB_DIRS_SHELL, ";");$$shell_path($$[QT_INSTALL_BINS]);$(PATH)
            runtarget.commands += $$escape_expand(\\n\\t)set QT_PLUGIN_PATH=$$shadowed($$dirname(_QMAKE_CONF_))/plugins;$(QT_PLUGIN_PATH)
            runtarget.commands += $$escape_expand(\\n\\t)set QML2_IMPORT_PATH=$$shadowed($$dirname(_QMAKE_CONF_))/qml;$(QML2_IMPORT_PATH)
            runtarget.commands += $$escape_expand(\\n\\t)if exist $${outdir_helper}\\fail del $${outdir_helper}\\fail
            runtarget.commands += $$escape_expand(\\n\\t)start /w call $(DESTDIR_TARGET) 2^> $${outdir_helper}\\test.log ^|^| echo FAIL ^> $${outdir_helper}\\fail ^& exit 0
            runtarget.commands += $$escape_expand(\\n\\t)type $${outdir_helper}\\test.log
            runtarget.commands += $$escape_expand(\\n\\t)if exist $${outdir_helper}\\fail exit 42
            QMAKE_EXTRA_TARGETS += runtarget
        } else {
            win32-g++: QMAKE_DIRLIST_SEP = ";"
            runtarget.commands += export PATH=\"$$join(LIB_DIRS_SHELL, ":"):$$shell_path($$[QT_INSTALL_BINS]):$${LITERAL_DOLLAR}$${LITERAL_DOLLAR}PATH\"
            runtarget.commands += $$escape_expand(\\n\\t)export QT_PLUGIN_PATH=\"$$shadowed($$dirname(_QMAKE_CONF_))/plugins/$${QMAKE_DIRLIST_SEP}$(QT_PLUGIN_PATH)\"
            runtarget.commands += $$escape_expand(\\n\\t)export QML2_IMPORT_PATH=\"$$shadowed($$dirname(_QMAKE_CONF_))/qml/$${QMAKE_DIRLIST_SEP}$(QML2_IMPORT_PATH)\"
            win32-g++: QMAKE_DIRLIST_SEP = ":"

            linux|win32-g++ {
                runtarget.commands += $$escape_expand(\\n\\t)export LD_LIBRARY_PATH=\"$$join(LIB_DIRS, "$${QMAKE_DIRLIST_SEP}$$")$${QMAKE_DIRLIST_SEP}$$[QT_INSTALL_LIBS]$${QMAKE_DIRLIST_SEP}$(LD_LIBRARY_PATH)\"
                runtarget.commands += $$escape_expand(\\n\\t)export QT_QPA_PLATFORM=minimal
            } else:mac {
                runtarget.commands += $$escape_expand(\\n\\t)export DYLD_LIBRARY_PATH=\"$$join(LIB_DIRS, ":"):$$[QT_INSTALL_LIBS]:$(DYLD_LIBRARY_PATH)\"
                runtarget.commands += $$escape_expand(\\n\\t)export DYLD_FRAMEWORK_PATH=\"$$join(LIB_DIRS, ":"):$$[QT_INSTALL_LIBS]:$(DYLD_FRAMEWORK_PATH)\"
            }

            runtarget.target = run-tests
            win32-g++ {
                runtarget.depends += $(DESTDIR_TARGET)
                runtarget.commands += $$escape_expand(\\n\\t)./$(DESTDIR_TARGET)
            } else {
                runtarget.depends += $(TARGET)
                runtarget.commands += $$escape_expand(\\n\\t)./$(TARGET)
            }
            QMAKE_EXTRA_TARGETS += runtarget
        }
    }
} else: QMAKE_EXTRA_TARGETS += run-tests

# qdep stats
message("TARGET: $$TARGET")
!qdep_build:error("qdep was loaded, but qdep_build config is not set")
!isEmpty(__QDEP_REAL_DEPS_STACK):error("__QDEP_REAL_DEPS_STACK not empty: $$__QDEP_REAL_DEPS_STACK")
message("__QDEP_INCLUDE_CACHE:")
for(hash, __QDEP_INCLUDE_CACHE) {
    message("    $${hash}.package: $$eval($${hash}.package)")
    message("    $${hash}.version: $$eval($${hash}.version)")
    message("    $${hash}.path: $$eval($${hash}.path)")
    message("    $${hash}.exports: $$eval($${hash}.exports)")
    message("    $${hash}.local: $$eval($${hash}.local)")
    message("    $${hash}.target: $$eval($${hash}.target)")
    message("    $${hash}.file: $$eval($${hash}.file)")
    message("    $${hash}.depends: $$eval($${hash}.depends)")
}
message("QDEP_DEFINES: $$QDEP_DEFINES")
message("DEFINES: $$DEFINES")
message("QDEP_INCLUDEPATH: $$QDEP_INCLUDEPATH")
message("INCLUDEPATH: $$INCLUDEPATH")
message("__QDEP_PRIVATE_VARS_EXPORT: $$__QDEP_PRIVATE_VARS_EXPORT")

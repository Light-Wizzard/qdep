TEMPLATE = subdirs

CONFIG += ordered

SUBDIRS += \
    single \
    basic \
    external

prepareRecursiveTarget(run-tests)
QMAKE_EXTRA_TARGETS += run-tests

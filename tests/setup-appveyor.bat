@echo off

C:\Python37-x64\Scripts\pip.exe install appdirs lockfile argcomplete || exit /B 1
C:\Python37-x64\python.exe ./qdep.py prfgen --qmake "C:\projects\Qt\%QT_VER%\%PLATFORM%\bin\qmake" || exit /B 1
move tests\qdep.pro .\dep.pro || exit /B 1

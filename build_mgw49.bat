@echo off
setlocal enableextensions enabledelayedexpansion

if [%1]==[] (
    echo Usage: %0 ^<boost_dir^>
    goto :eof
)

cd %1
md stage\lib 2> nul
md stage\include\boost 2> nul

b2 --build-dir=build_mgw49-64-s --stagedir=stage_mgw49-64-s toolset=gcc variant=release link=static runtime-link=static address-model=64 -j 3

cd stage_mgw49-64-s\lib
echo create libboost-mgw49-64-s.a >> all.mri
for %%f in (libboost_*.a) do (echo addlib %%f >> all.mri)
echo save >> all.mri
echo end >> all.mri
ar -M < all.mri
del /Q all.mri
move libboost-mgw49-64-s.a ..\..\stage\lib\
cd ..\..

b2 --build-dir=build_mgw49-32-s --stagedir=stage_mgw49-32-s toolset=gcc variant=release link=static runtime-link=static address-model=32 -j 3

cd stage_mgw49-32-s\lib
echo create libboost-mgw49-32-s.a >> all.mri
for %%f in (libboost_*.a) do (echo addlib %%f >> all.mri)
echo save >> all.mri
echo end >> all.mri
ar -M < all.mri
del /Q all.mri
move libboost-mgw49-32-s.a ..\..\stage\lib\
cd ..\..

b2 --build-dir=build_mgw49-64-sd --stagedir=stage_mgw49-64-sd toolset=gcc variant=debug link=static runtime-link=static address-model=64 -j 3

cd stage_mgw49-64-sd\lib
echo create libboost-mgw49-64-sd.a >> all.mri
for %%f in (libboost_*.a) do (echo addlib %%f >> all.mri)
echo save >> all.mri
echo end >> all.mri
ar -M < all.mri
del /Q all.mri
move libboost-mgw49-64-sd.a ..\..\stage\lib\
cd ..\..

b2 --build-dir=build_mgw49-32-sd --stagedir=stage_mgw49-32-sd toolset=gcc variant=debug link=static runtime-link=static address-model=32 -j 3

cd stage_mgw49-32-sd\lib
echo create libboost-mgw49-32-sd.a >> all.mri
for %%f in (libboost_*.a) do (echo addlib %%f >> all.mri)
echo save >> all.mri
echo end >> all.mri
ar -M < all.mri
del /Q all.mri
move libboost-mgw49-32-sd.a ..\..\stage\lib\
cd ..\..

xcopy /E /Y boost stage\include\boost

cd ..

:eof
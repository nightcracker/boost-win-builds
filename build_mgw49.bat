setlocal enableextensions enabledelayedexpansion

md stage\lib 2> nul

b2 --build-dir=build_gcc64 --stagedir=stage64 toolset=gcc variant=release link=static runtime-link=static address-model=64 -j 3

cd stage64\lib
echo create libboost-mgw49-64-s.a >> all.mri
for %%f in (libboost_*.a) do (echo addlib %%f >> all.mri)
echo save >> all.mri
echo end >> all.mri
ar -M < all.mri
del /Q all.mri
move libboost-mgw49-64-s.a ..\..\stage\lib\
cd ..\..

b2 --build-dir=build_gcc32 --stagedir=stage32 toolset=gcc variant=release link=static runtime-link=static address-model=32 -j 3

cd stage32\lib
echo create libboost-mgw49-32-s.a >> all.mri
for %%f in (libboost_*.a) do (echo addlib %%f >> all.mri)
echo save >> all.mri
echo end >> all.mri
ar -M < all.mri
del /Q all.mri
move libboost-mgw49-32-s.a ..\..\stage\lib\
cd ..\..

b2 --build-dir=build_gcc64_debug --stagedir=stage64_debug toolset=gcc variant=debug link=static runtime-link=static address-model=64 -j 3

cd stage64_debug\lib
echo create libboost-mgw49-64-sd.a >> all.mri
for %%f in (libboost_*.a) do (echo addlib %%f >> all.mri)
echo save >> all.mri
echo end >> all.mri
ar -M < all.mri
del /Q all.mri
move libboost-mgw49-64-sd.a ..\..\stage\lib\
cd ..\..

b2 --build-dir=build_gcc32_debug --stagedir=stage32_debug toolset=gcc variant=debug link=static runtime-link=static address-model=32 -j 3

cd stage32_debug\lib
echo create libboost-mgw49-32-sd.a >> all.mri
for %%f in (libboost_*.a) do (echo addlib %%f >> all.mri)
echo save >> all.mri
echo end >> all.mri
ar -M < all.mri
del /Q all.mri
move libboost-mgw49-32-sd.a ..\..\stage\lib\
cd ..\..
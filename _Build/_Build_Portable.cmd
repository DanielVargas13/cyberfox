@echo Off
:top
::----
set BuildFolderPath=%~DP0
set BuildFolderPathIntel=%~DP0_CyberfoxPortable\Intel\CyberfoxPortable\
set BuildFolderPathAmd=%~DP0_CyberfoxPortable\Intel\CyberfoxPortable\
::set NSISCompiler="%BuildFolderPath%_NSISPortable\NSISPortable.exe"  can't be used if /V0 flag is as the NSISPortable does not recognise the command.
::The /V followed numbers between 0 and 4 sets the verbosity of output. (0=no output, 1=errors only, 2=warnings and errors, 3=info, warnings, and errors, 4=all output).
set NSISCompiler="%BuildFolderPath%_NSISPortable\app\nsis\makensis" 
set Argos=/V4
::----
if not exist "%BuildFolderPath%_NSISPortable\app\nsis\makensis.exe" (
echo.The NSIS compiler was not found!
echo.Exiting
goto :exit
) 
::----
ECHO.
ECHO.
ECHO.                                                         			   
ECHO.Please Select Compiler Option           
ECHO.---------------------------------------         	   
ECHO.                                                                      
ECHO.Press 1 to Create (x86) Package.                
ECHO.Press 2 to Create (x64) Package.
ECHO.Press 3 to Create Installer Package.
ECHO.Press 4 to Create Zipped Package.
ECHO.Press E to Exit.                      
ECHO.                                                          
ECHO.---------------------------------------         
ECHO.
ECHO.
ECHO.----------- 
ECHO.1. Create (x86) Package. 
ECHO.2. Create (x64) Package. 
ECHO.3  Create Installer Package.
ECHO.4  Create Zipped Package.
ECHO.E. E to Exit.
ECHO.Any Key. Cancel.             
ECHO.----------- 
SET /P uin=Choose an option (1,2,3,4,E)? 
if /i {%uin%}=={1} (goto :Compile-Package-86)
if /i {%uin%}=={2} (goto :Compile-Package-64)
if /i {%uin%}=={3} (goto :Installer-Package)
if /i {%uin%}=={4} (goto :Zipped-Package)  
if /i {%uin%}=={E} (goto :exit)
if /i {%uin%}=={Exit} (goto :exit)
if /i {%uin%}=={EXIT} (goto :exit)
if /i {%uin%}=={e} (goto :exit)
if /i {%uin%}=={exit} (goto :exit)
goto :top


:Compile-Package-86
echo. Compilation of portable medium is starting!
timeout 1 >nul
::----
if not exist "%BuildFolderPath%_CyberfoxPortable\logs" (
mkdir "%BuildFolderPath%_CyberfoxPortable\logs"
)
::----
echo. Building Intel 86 bit portable package
::----
if exist "%BuildFolderPathIntel%Other\Source\win64.txt" (
del /q /f "%BuildFolderPathIntel%Other\Source\win64.txt"
)
::----
if exist "%BuildFolderPathIntel%CyberfoxPortable.exe" (
del /q /f "%BuildFolderPathIntel%CyberfoxPortable.exe"
) else (
echo.CyberfoxPortable.exe not found!
)
::----
copy /y "%BuildFolderPath%_CyberfoxPortable\BlankConfig\intel86\UpdateConfig.ini" "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable\App\AppInfo\"
::----
if exist "%BuildFolderPathIntel%App\Cyberfox" (
rmdir /q /s "%BuildFolderPathIntel%App\Cyberfox"
)
::----
mkdir "%BuildFolderPathIntel%App\Cyberfox"
::----
@echo on
xcopy /e /v "%BuildFolderPath%_Installer\{content}\browser\intel86" "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable\App\Cyberfox"
@echo off
::----
mkdir "%BuildFolderPathIntel%App\Cyberfox\distribution"
::----
@echo on
xcopy /e /v "%BuildFolderPath%_CyberCTR\distribution" "%BuildFolderPathIntel%App\Cyberfox\distribution"
@echo off
::----
@echo on
%NSISCompiler% %Argos% "%BuildFolderPathIntel%Other\Source\CyberfoxPortableU.nsi" > "%BuildFolderPath%_CyberfoxPortable\logs\build_intel86.log" && type "%BuildFolderPath%_CyberfoxPortable\logs\build_intel86.log"
@echo off
::----
echo. Build Intel 86 bit portable package complete!
::----
timeout 1 >nul
::----
echo. Building Amd 86 bit portable package!
::----
if exist "%BuildFolderPathAmd%Other\Source\win64.txt" (
del /q /f "%BuildFolderPathAmd%Other\Source\win64.txt"
)
::----
if exist "%BuildFolderPathAmd%CyberfoxPortable.exe" (
del /q /f "%BuildFolderPathAmd%CyberfoxPortable.exe"
) else (
echo.CyberfoxPortable.exe not found!
)
::----
copy /y "%BuildFolderPath%_CyberfoxPortable\BlankConfig\amd86\UpdateConfig.ini" "%BuildFolderPathAmd%App\AppInfo\"
::----
if exist "%BuildFolderPathAmd%App\Cyberfox" (
rmdir /q /s "%BuildFolderPathAmd%App\Cyberfox"
)
::----
mkdir "%BuildFolderPathAmd%App\Cyberfox"
::----
@echo on
xcopy /e /v "%BuildFolderPath%_Installer\{content}\browser\amd86" "%BuildFolderPathAmd%App\Cyberfox"
@echo off
::----
mkdir "%BuildFolderPathAmd%App\Cyberfox\distribution"
::----
@echo on
xcopy /e /v "%BuildFolderPath%_CyberCTR\distribution" "%BuildFolderPathAmd%App\Cyberfox\distribution"
@echo off
::----
@echo on
%NSISCompiler% %Argos% "%BuildFolderPathAmd%Other\Source\CyberfoxPortableU.nsi" > "%BuildFolderPath%_CyberfoxPortable\logs\build_amd86.log" && type "%BuildFolderPath%_CyberfoxPortable\logs\build_amd86.log"
@echo off
::----
echo. Build Amd 86 bit portable package complete!
::----
goto :completed
::----
::----
::----
:Compile-Package-64
echo. Compilation of portable medium is starting!
::----
timeout 1 >nul
::----
if not exist "%BuildFolderPath%_CyberfoxPortable\logs" (
mkdir "%BuildFolderPath%_CyberfoxPortable\logs"
)
::----
echo. Building Intel 64 bit portable package!
::----
if not exist "%BuildFolderPathIntel%Other\Source\win64.txt" (
break>"%BuildFolderPathIntel%Other\Source\win64.txt"
)
::----
if exist "%BuildFolderPathIntel%CyberfoxPortable.exe" (
del /q /f "%BuildFolderPathIntel%CyberfoxPortable.exe"
) else (
echo.CyberfoxPortable.exe not found!
)
::----
copy /y "%BuildFolderPath%_CyberfoxPortable\BlankConfig\intel64\UpdateConfig.ini" "%BuildFolderPathIntel%App\AppInfo\"
::----
if exist "%%BuildFolderPathIntel%App\Cyberfox" (
rmdir /q /s "%BuildFolderPathIntel%App\Cyberfox"
)
::----
mkdir "%BuildFolderPathIntel%App\Cyberfox"
::----
@echo on
xcopy /e /v "%BuildFolderPath%_Installer\{content}\browser\intel64" "%BuildFolderPathIntel%App\Cyberfox"
@echo off
::----
mkdir "%BuildFolderPathIntel%App\Cyberfox\distribution"
::----
@echo on
xcopy /e /v "%BuildFolderPath%_CyberCTR\distribution" "%BuildFolderPathIntel%App\Cyberfox\distribution"
@echo off
::----
@echo on
%NSISCompiler% %Argos% "%BuildFolderPathIntel%Other\Source\CyberfoxPortableU.nsi" > "%BuildFolderPath%_CyberfoxPortable\logs\build_intel64.log" && type "%BuildFolderPath%_CyberfoxPortable\logs\build_intel64.log"
@echo off
::----
echo. Build Intel 64 bit portable package complete!
::----
timeout 1 >nul
::----
echo. Building Amd 64 bit portable package!
::----
if not exist "%BuildFolderPathAmd%Other\Source\win64.txt" (
break>"%BuildFolderPathAmd%Other\Source\win64.txt"
)
::----
if exist "%BuildFolderPathAmd%CyberfoxPortable.exe" (
del /q /f "%BuildFolderPathAmd%CyberfoxPortable.exe"
) else (
echo.CyberfoxPortable.exe not found!
)
::----
copy /y "%BuildFolderPath%_CyberfoxPortable\BlankConfig\amd64\UpdateConfig.ini" "%BuildFolderPathAmd%App\AppInfo\"
::----
if exist "%BuildFolderPathAmd%App\Cyberfox" (
rmdir /q /s "%BuildFolderPathAmd%App\Cyberfox"
)
::----
mkdir "%BuildFolderPathAmd%App\Cyberfox"
::----
@echo on
xcopy /e /v "%BuildFolderPath%_Installer\{content}\browser\amd64" "%BuildFolderPathAmd%App\Cyberfox"
@echo off
::----
mkdir "%BuildFolderPathAmd%App\Cyberfox\distribution"
::----
@echo on
xcopy /e /v "%BuildFolderPath%_CyberCTR\distribution" "%BuildFolderPathAmd%App\Cyberfox\distribution"
@echo off
::----
@echo on
%NSISCompiler% %Argos% "%BuildFolderPathAmd%Other\Source\CyberfoxPortableU.nsi" > "%BuildFolderPath%_CyberfoxPortable\logs\build_amd64.log" && type "%BuildFolderPath%_CyberfoxPortable\logs\build_amd64.log" 
@echo off
::----
echo. Build Amd 64 bit portable package complete!
::----
timeout 1 >nul
::----
goto :completed
::----
::----
::----
:Installer-Package
@echo off
::----
set BuildFolderPath=%~DP0
set PortableAppsInstaller="%BuildFolderPath%_PortableApps.comInstaller\PortableApps.comInstaller.exe"
set PortableAppsInstallerOutput="%BuildFolderPath%_Installation"
::----
ECHO.
ECHO.Package Version *(Required)
echo. Must be same as version been package
set /P verdata=Enter Version Number (27.0.1.0)? 
set Version=%verdata%
:top-Installer-Package
ECHO.
ECHO.                                                         			   
ECHO.Please Select Compiler Option           
ECHO.---------------------------------------         	   
ECHO.                                                                      
ECHO.Press 1 to Create (x86) Portable Installer Package.                
ECHO.Press 2 to Create (x64) Portable Installer Package.             
ECHO.Press E to Exit.                      
ECHO.                                                          
ECHO.---------------------------------------         
ECHO.
ECHO.
ECHO.----------- 
ECHO.1. Create (x86) Package. 
ECHO.2. Create (x64) Package. 
ECHO.E. E to Exit.        
ECHO.----------- 
SET /P uin=Choose an option (1,2,E)? 
if /i {%uin%}=={1} (goto :Compile-Package-86-Portable)
if /i {%uin%}=={2} (goto :Compile-Package-64-Portable) 
if /i {%uin%}=={E} (goto :exit)
if /i {%uin%}=={Exit} (goto :exit)
if /i {%uin%}=={EXIT} (goto :exit)
if /i {%uin%}=={e} (goto :exit)
if /i {%uin%}=={exit} (goto :exit)
goto :top-Installer-Package

:Compile-Package-86-Portable
echo. Compilation of %Version% portable installation medium is starting!
::----
timeout 1 >nul
::----
echo. Building Amd 86 bit portable package!
::----
%PortableAppsInstaller% "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable"
::----
echo. Build Amd 86 bit package complete!
::----
if not exist "%BuildFolderPath%_Installation" (
mkdir "%BuildFolderPath%_Installation"
)
::----
ren "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable_%Version%_English.paf.exe"  "CyberfoxPortable_%Version%_English.Amd.86.paf.exe"
::----
copy /y "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable_%Version%_English.Amd.86.paf.exe" "%PortableAppsInstallerOutput%"
::----
timeout 1 >nul
if exist "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable_%Version%_English.Amd.86.paf.exe" (
del /q /f "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable_%Version%_English.Amd.86.paf.exe"
)
timeout 1 >nul
::----
echo. Building intel 86 bit portable package
::----
%PortableAppsInstaller% "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable"
::----
echo. Build intel 86 bit portable package complete!
::----
ren "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable_%Version%_English.paf.exe"  "CyberfoxPortable_%Version%_English.Intel.86.paf.exe"
::----
copy /y "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable_%Version%_English.Intel.86.paf.exe" "%PortableAppsInstallerOutput%"
::----
timeout 1 >nul
if exist "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable_%Version%_English.Intel.86.paf.exe" (
del /q /f "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable_%Version%_English.Intel.86.paf.exe"
)
::----
goto :completed
::----
::----
::----
:Compile-Package-64-Portable
echo. Compilation of %Version% portable installation medium is starting!
::----
timeout 1 >nul
::----
echo. Building Amd 64 bit portable package!
::----
%PortableAppsInstaller% "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable"
::----
echo. Build Amd 64 bit package complete!
::----
if not exist "%BuildFolderPath%_Installation" (
mkdir "%BuildFolderPath%_Installation"
)
::----
ren "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable_%Version%_English.paf.exe"  "CyberfoxPortable_%Version%_English.Amd.paf.exe"
::----
copy /y "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable_%Version%_English.Amd.paf.exe" "%PortableAppsInstallerOutput%"
::----
timeout 1 >nul
if exist "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable_%Version%_English.Amd.paf.exe" (
del /q /f "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable_%Version%_English.Amd.paf.exe"
)
timeout 1 >nul
::----
echo. Building intel 64 bit portable package
::----
%PortableAppsInstaller% "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable"
::----
echo. Build intel64 bit portable package complete!
::----
ren "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable_%Version%_English.paf.exe"  "CyberfoxPortable_%Version%_English.Intel.paf.exe"
::----
copy /y "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable_%Version%_English.Intel.paf.exe" "%PortableAppsInstallerOutput%"
::----
timeout 1 >nul
if exist "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable_%Version%_English.Intel.paf.exe" (
del /q /f "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable_%Version%_English.Intel.paf.exe"
)
::----
goto :completed
::----
::----
::----
:Zipped-Package
@echo Off
::----
set BuildFolderPath=%~DP0
if not exist "%BuildFolderPath%_7ZipPortable\App\7-Zip\7za.exe" goto :bye
set SevenZip=%BuildFolderPath%_7ZipPortable\App\7-Zip\7za.exe
set PortableAppsZippedOutput="%BuildFolderPath%_Installation"
::----
ECHO.
ECHO.Package Version *(Required)
echo. Must be same as version been package
set /P verdata=Enter Version Number (27.0.1.0)? 
if /i {%verdata%}=={E} (goto :exit)
if /i {%verdata%}=={Exit} (goto :exit)
if /i {%verdata%}=={EXIT} (goto :exit)
if /i {%verdata%}=={e} (goto :exit)
if /i {%verdata%}=={exit} (goto :exit)
set Version=%verdata%
:top-Zipped-Package
ECHO.
ECHO.                                                         			   
ECHO.Please Select Compiler Option           
ECHO.---------------------------------------         	   
ECHO.                                                                      
ECHO.Press 1 to Create (x86) Zipped Installer Package.                
ECHO.Press 2 to Create (x64) Zipped Installer Package.                
ECHO.Press E to Exit.                      
ECHO.                                                          
ECHO.---------------------------------------         
ECHO.
ECHO.
ECHO.----------- 
ECHO.1. Create (x86) Package. 
ECHO.2. Create (x64) Package.  
ECHO.E. E to Exit.        
ECHO.----------- 
SET /P uin=Choose an option (1,2,E)? 
if /i {%uin%}=={1} (goto :Compile-Package-86-Zipped)
if /i {%uin%}=={2} (goto :Compile-Package-64-Zipped)
if /i {%uin%}=={E} (goto :exit)
if /i {%uin%}=={Exit} (goto :exit)
if /i {%uin%}=={EXIT} (goto :exit)
if /i {%uin%}=={e} (goto :exit)
if /i {%uin%}=={exit} (goto :exit)
goto :top-Zipped-Package
::----
::----
::----
:Compile-Package-86-Zipped
echo. Compilation of %Version% zipped installation medium is starting!
::----
timeout 1 >nul
::----
echo. Building amd 86 bit zipped package!
::----
%SevenZip% a -mx9 -t7z "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable_%Version%_English.Amd.86.7z" "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable"
::----
echo. Build amd 86 bit package complete!
::----
if not exist "%BuildFolderPath%_Installation" (
mkdir "%BuildFolderPath%_Installation"
)
::----
copy /y "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable_%Version%_English.Amd.86.7z" "%PortableAppsZippedOutput%"
::----
timeout 1 >nul
if exist "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable_%Version%_English.Amd.86.7z" (
del /q /f "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable_%Version%_English.Amd.86.7z"
)
timeout 1 >nul
::----
echo. Building intel 86 bit zipped package
::----
%SevenZip% a -mx9 -t7z  "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable_%Version%_English.Intel.86.7z" "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable"
::----
echo. Build intel 86 bit zipped package complete!
::----
copy /y "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable_%Version%_English.Intel.86.7z" "%PortableAppsZippedOutput%"
::----
timeout 1 >nul
::----
if exist "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable_%Version%_English.Intel.86.7z" (
del /q /f "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable_%Version%_English.Intel.86.7z"
)
::----
goto :completed

:Compile-Package-64-Zipped
echo. Compilation 0f %Version% zipped installation medium is starting!
::----
timeout 1 >nul
::----
echo. Building amd 64 bit zipped package!
::----
%SevenZip% a -mx9 -t7z "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable_%Version%_English.Amd.7z" "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable"
::----
echo. Build Amd 64 bit package complete!
::----
if not exist "%BuildFolderPath%_Installation" (
mkdir "%BuildFolderPath%_Installation"
)
::----
copy /y "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable_%Version%_English.Amd.7z" "%PortableAppsZippedOutput%"
::----
timeout 1 >nul
if exist "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable_%Version%_English.Amd.7z" (
del /q /f "%BuildFolderPath%_CyberfoxPortable\Amd\CyberfoxPortable_%Version%_English.Amd.7z"
)
timeout 1 >nul
::----
echo. Building intel 64 bit zipped package
::----
%SevenZip% a -mx9 -t7z  "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable_%Version%_English.Intel.7z" "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable"
::----
echo. Build intel 64 bit zipped package complete!
::----
copy /y "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable_%Version%_English.Intel.7z" "%PortableAppsZippedOutput%"
::----
timeout 1 >nul
if exist "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable_%Version%_English.Intel.7z" (
del /q /f "%BuildFolderPath%_CyberfoxPortable\Intel\CyberfoxPortable_%Version%_English.Intel.7z"
)
::----
goto :completed
::----
::----
::----
:completed
@echo off
popd
echo. 
echo. 
echo. 
echo.Compilation Complete!
::----
goto :top
::----
::----
::----
:exit
exit /b %ERRORLEVEL%
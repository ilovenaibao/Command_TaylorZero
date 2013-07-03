echo rebuild......
@echo off
:: *******************************************************************************************************************************
::     **********************************************�л{�u�\Ū�u�{�t�m�I*****************************************************
::        ******************************************�_�h�u�{�Ыإi��X��**************************************************
rem readme
rem (*) ----> �����ק�Ϊ̶�g�����e
rem (/) ----> �i�H�ϥ��q�{��
rem �p�Gapk�ͦ����\�A����|�b�u�{�ڥؿ��U�ͦ��Gmake_project_info.txt
rem �o��txt���O�����O�u�{�����H��
rem END
:: *******************************************************************************************************************************
:: �i��u�{�t�m

:: 0. �]�m�һݸ��| ----> Initialize some info

:: �u�{�t�m
:: (*) �u�{�W (*)
set Project_Name=%1
:: (*) �u�{�]�W (*)
set ProjectPackage_Last_Name=%2
set ProjectPackage_Name=%3
:: (*) �u�{�ҥ�adk-addon target ID (*)
set ProjectSDK_ID=%4
:: (/) �u�{���]���귽���W (/)
set ProjectRes_Name=%5
:: (/) �u�{�ͦ�����ñ�W��apk�W (/)
set ProjectUnsigedApk_Name=%6
:: (/) �u�{�̲׿�X��apk�W (/)
set ProjectOutApk_Name=%7
:: *******************************************************************************************************************************

:: keystore�ϥΪ��ӤH�H���t�m
:: (/) �u�{�ͦ���keystore�W (/)
set ProjectKeyStore_Name=%8
:: (*) �ͦ���keystore���Ĥ���Ѽ� (*)
set ValidityDays_Count=%9
:: (/) �A���W�r�m�� (/)
SHIFT /8
set RD_Name=%9
:: (/) �A����´���W�� (/)
SHIFT /8
set Company_Name=%9
:: (/) �A����´�W�� (/)
SHIFT /8
set Organization_Name=%9
:: (/) �A�Ҧb��ΰϰ�W�� (/)
SHIFT /8
set Local_Name=%9
:: (/) �A�Ҧb���{�ά٥� (/)
SHIFT /8
set Province_Name=%9
:: (/) �A�Ҧb��a��2���a�N�X (/)
SHIFT /8
set Country_ID=%9
:: (/) �]�m�ͦ�ñ�W��apk���K�X (/)
SHIFT /8
set MakeApk_Pass=%9
:: (/) �]�mkeystore�D�K�X(�@��i�H��apkñ�W�K�X�@�P) (/)
SHIFT /8
set KeystoreMain_Pass=%9
:: *******************************************************************************************************************************

:: Java & Android SDK ���|�t�m
:: (/) �]�mjavac�sĶ�ɪ�*.java ��󪺽s�X�榡 (/)
SHIFT /8
set Javac_Encode=%9
:: (/) �]�mjavac�sĶ�ɪ�SDK���� (/) %19
SHIFT /8
set JavacSDK_Ver=%9
:: (*) �u�{���| (*) %20
SHIFT /8
set Project_Parent_Path=%9
SHIFT /8
set Project_Path=%9
:: (*) �u�{�����ҥθ��| (*) %22
SHIFT /8
set ProjectInner_Path=%9
:: (*) JavaSDK���| (*) %23
SHIFT /8
set JavaSDK_Path=%9
:: (*) AndroidSDK���| (*) %24
SHIFT /8
set AndroidJar_Path=%9
:: (/) �u�{�Ыئ��\�������H���W (/) %25
SHIFT /8
set Success_Info=%9
:: (/) �u�{�sĶ�H��OutPut�����| (/) %26
SHIFT /8
set Compile_Info_Path=%9
SHIFT /8
set Compile_Info_Full_Path=%9
SHIFT /8
set Compile_Info_File_Name=%9
set Compile_OutPut_Command=>> %Compile_Info_Full_Path%\%Compile_Info_File_Name%

:: *******************************************************************************************************************************

:: delete old compile output info 
::del /s /q %Compile_Info_Path%\*.*
echo.
echo create compile output info folder ...
cd %Project_Path%
cd ..
rmdir /s /q %Compile_Info_Path%
mkdir %Compile_Info_Path%

:: start rebuild a android project

:: 1. �R���W�@��build���
echo.
echo delete old build files ...
cd %Project_Path%
rmdir /s /q gen
rmdir /s /q bin
mkdir gen
mkdir bin

:: 2. �ͦ�R.java���A�����ݭn�Ы�gen���
echo.
echo. >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
echo Remake "R.java" file...
echo Remake "R.java" file... >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%

::call aapt.exe p -f -m --auto-add-overlay -J gen  -M G:\Android_Libs_Projects\My_Static_Method_Lib\AndroidManifest.xml -S G:\Android_Libs_Projects\My_Static_Method_Lib\res -I %AndroidJar_Path%

call aapt.exe p -f -m --auto-add-overlay -J gen -M AndroidManifest.xml -S res -I %AndroidJar_Path% >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
if errorlevel 1 goto ERROR
:: MyLib
call aapt.exe p -f -m --auto-add-overlay -J lib_proj\My_Static_Method_Lib\gen -M lib_proj\My_Static_Method_Lib\AndroidManifest.xml -S lib_proj\My_Static_Method_Lib\res -I %AndroidJar_Path% >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
if errorlevel 1 goto ERROR

call aapt.exe p -f -m --auto-add-overlay -J lib_proj\dslv_library\gen -M lib_proj\dslv_library\AndroidManifest.xml -S lib_proj\dslv_library\res -I %AndroidJar_Path% >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
if errorlevel 1 goto ERROR

:: 3. �ͦ�.class���
:: eg> javac -encoding UTF-8 -target 1.6 -bootclasspath %AndroidJar_Path% -d bin (-cp [path]�]�t���ĤT��jar) src\com\besta\app\cmdtest\*.java gen\com\besta\app\cmdtest\R.java -classpath libs\baidumapapi.jar
echo.
echo. >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
echo make "*.class" file...
echo make "*.class" file... >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
call javac -Xlint -encoding %Javac_Encode% -target %JavacSDK_Ver% -bootclasspath %AndroidJar_Path% -d bin -cp @..\COMPILE_LIB_FILES -sourcepath @..\COMPILE_SOURCE_FILES 1>> %Compile_Info_Full_Path%\%Compile_Info_File_Name% 2>&1
:: 1>>%Compile_Info_Full_Path%\%Compile_Info_File_Name% 2>>&1
:: >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
if errorlevel 1 goto ERROR_JAVAC

:: 4. �ͦ�.dex���
echo.
echo. >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
echo make "*.dex" file...
echo make "*.dex" file... >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
call dx.bat --dex --output=%Project_Path%\bin\classes.dex %Project_Path%\bin G:\no_eclipse_build\Projects\RealTeaching_Projectes\C4A01_RealTeaching\RealTeaching\libs\*.jar >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
if errorlevel 1 goto ERROR

:: 5. �Q��aapt �ͦ�*.ap_���, �Y���]�귽���
:: �ѩ�S��assets��󧨡A�]�����椧�e�ݭn�إ�assets
echo.
echo. >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
echo package "*.ap_" for some resouse file...
echo package "*.ap_" for some resouse file... >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
call aapt.exe package -f -M AndroidManifest.xml -S res -I %AndroidJar_Path% -A assets -F %Project_Path%\bin\%ProjectRes_Name% >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
if errorlevel 1 goto ERROR

:: 6. �ͦ���ñ�W��apk���
echo.
echo. >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
echo make unsigner apk file...
echo make unsigner apk file... >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
call apkbuilder.bat %Project_Path%\bin\%ProjectUnsigedApk_Name% -v -u -z %Project_Path%\bin\%ProjectRes_Name% -f %Project_Path%\bin\classes.dex -rf %Project_Path%\src -nf %Project_Path%\libs -rj %Project_Path%\libs >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
if errorlevel 1 goto ERROR

:: 8. ��jarsigner ñ�WcmdTest_unsigner.apk�ͦ�Target apk : cmdTest.apk
echo.
echo. >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
echo signed that unsigner apk file to make a *.apk file...
echo signed that unsigner apk file to make a *.apk file... >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
call jarsigner.exe -verbose -keystore %ProjectKeyStore_Name% -keypass %MakeApk_Pass% -storepass %KeystoreMain_Pass% -signedjar %ProjectOutApk_Name% %Project_Path%\bin\%ProjectUnsigedApk_Name% %ProjectKeyStore_Name% >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
if errorlevel 1 goto ERROR
goto EXIT_SUCCESS

:ERROR_JAVAC

start %Compile_Info_Full_Path%
goto ERROR

:ERROR
echo.
echo. >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
echo some error occurred, please check!
echo some error occurred, please check! >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
pause
goto EXIT_END

:EXIT_SUCCESS
echo.
echo. >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
echo Rebuild project Success!
echo Rebuild project Success! >> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
start %Compile_Info_Full_Path%
::pause
goto EXIT_END

:EXIT_END
cd %Project_Path%
cd ..
echo.
pause
exit

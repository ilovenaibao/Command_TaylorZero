echo uninstall apk......
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


:: ************** Install apk & start Activity class******************

set Start_Activity_Name=com.besta.app.realteachingtestcallapp.TestaCallApp

:: *******************************************************************

::help
echo ------------------------------------
echo.
echo Help:
call adb.exe devices
echo pkg_name: %ProjectPackage_Name%
echo apk_name: .\%Project_Name%\%ProjectOutApk_Name%
echo command : "adb -s <device_number> install -r .\%Project_Name%\%ProjectOutApk_Name%"
echo.
echo ------------------------------------


:: uninstall old apk which is on the device
echo.
echo Uninstalling old apk ...
call adb.exe uninstall %ProjectPackage_Name%
if errorlevel 1 goto ERROR
goto EXIT_END

:EXIT_END
echo.
pause
exit

:ERROR
echo.
echo some error occurred, please check!
goto EXIT_END

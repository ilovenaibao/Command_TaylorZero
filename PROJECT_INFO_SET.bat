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
set Project_Name=TaylorZero
:: (*) �u�{�]�W (*)
set ProjectPackage_Last_Name=taylorzero
set ProjectPackage_Name=com.android.%ProjectPackage_Last_Name%
:: (*) �u�{�ҥ�adk-addon target ID (*)
set ProjectSDK_ID=39
:: (/) �u�{���]���귽���W (/)
set ProjectRes_Name=%Project_Name%.ap_
:: (/) �u�{�ͦ�����ñ�W��apk�W (/)
set ProjectUnsigedApk_Name=%Project_Name%_unsigner.apk
:: (/) �u�{�̲׿�X��apk�W (/)
set ProjectOutApk_Name=.\bin\%Project_Name%.apk
:: *******************************************************************************************************************************

:: keystore�ϥΪ��ӤH�H���t�m
:: (/) �u�{�ͦ���keystore�W (/)
set ProjectKeyStore_Name=%Project_Name%.keystore
:: (*) �ͦ���keystore���Ĥ���Ѽ� (*)
set ValidityDays_Count=20000
:: (/) �A���W�r�m�� (/)
set RD_Name=Gu
:: (/) �A����´���W�� (/)
set Company_Name="TaylorGu_Co."
:: (/) �A����´�W�� (/)
set Organization_Name=home
:: (/) �A�Ҧb��ΰϰ�W�� (/)
set Local_Name="xi_an"
:: (/) �A�Ҧb���{�ά٥� (/)
set Province_Name=Shannxi
:: (/) �A�Ҧb��a��2���a�N�X (/)
set Country_ID=CN
:: (/) �]�m�ͦ�ñ�W��apk���K�X (/)
set MakeApk_Pass=taylorzero
:: (/) �]�mkeystore�D�K�X(�@��i�H��apkñ�W�K�X�@�P) (/)
set KeystoreMain_Pass=%MakeApk_Pass%
:: *******************************************************************************************************************************

:: Java & Android SDK ���|�t�m
:: (/) �]�mjavac�sĶ�ɪ�*.java ��󪺽s�X�榡 (/)
set Javac_Encode=UTF-8
:: (/) �]�mjavac�sĶ�ɪ�SDK���� (/)
set JavacSDK_Ver=1.6
:: (*) �u�{���| (*)
set Project_Parent_Path=G:\My_Android_Project\Command_TaylorZero\
set Project_Path=%Project_Parent_Path%%Project_Name%
:: (*) �u�{�����ҥθ��| (*)
set ProjectInner_Path=com\android\%ProjectPackage_Last_Name%
:: (*) JavaSDK���| (*)
set JavaSDK_Path=I:\
:: (*) AndroidSDK���| (*)
set AndroidJar_Path=I:\android-sdk-windows_4.0\android-sdk-windows\platforms\android-15\android.jar
:: (/) �u�{�Ыئ��\�������H���W (/)
set Success_Info=%Project_Path%\make_%Project_Name%_ProjectInfo.txt
:: (/) �u�{�sĶ�H��OutPut�����| (/)
set Compile_Info_Path=OutPutInfo
set Compile_Info_Full_Path=%Project_Parent_Path%%Compile_Info_Path%
set Compile_Info_File_Name=out_build_info.txt
set Compile_OutPut_Command=>> %Compile_Info_Full_Path%\%Compile_Info_File_Name%
:: (/) �ǻ��Ѽƶ� (/)
set Input_args=%Project_Name% %ProjectPackage_Last_Name% %ProjectPackage_Name% %ProjectSDK_ID% %ProjectRes_Name% %ProjectUnsigedApk_Name% %ProjectOutApk_Name% %ProjectKeyStore_Name% %ValidityDays_Count% %RD_Name% %Company_Name% %Organization_Name% %Local_Name% %Province_Name% %Country_ID% %MakeApk_Pass% %KeystoreMain_Pass% %Javac_Encode% %JavacSDK_Ver% %Project_Parent_Path% %Project_Path% %ProjectInner_Path% %JavaSDK_Path% %AndroidJar_Path% %Success_Info% %Compile_Info_Path% %Compile_Info_Full_Path% %Compile_Info_File_Name%

:: *******************************************************************************************************************************
if %1 == rebuild_project ( call PROJECT_REBUILD.bat %Input_args%)
if %1 == create_project ( call PROJECT_CREATE.bat %Input_args%)
if %1 == install_apk ( call PROJECT_INSTALL_APK.bat %Input_args% %2)
if %1 == uninstall_apk ( call PROJECT_UNINSTALL_APK.bat %Input_args%)

:END
pause
exit

echo create project......
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
:: start create a android project

:: 1. �Ыؤ@�Ӥu�{
:: -n �u�{�W : cmdTest
:: -p �u�{�s�x���| : .\cmdTestProject
:: -k �u�{�]�W : com.besta.app.cmdtest
:: -a Activity�l���W : CmdTestActivity
:: -t �u�{�ϥΪ����O : 10, �p�G�����D�i�H�ϥ�Android.bat list target �Ӭd��
::echo create project...
call android.bat create project -n %Project_Name% -p %Project_Name% -k %ProjectPackage_Name% -a %Project_Name% -t %ProjectSDK_ID%
if errorlevel 1 goto ERROR

:: 2. �ͦ�R.java���A�����ݭn�Ы�gen���
echo make "R.java" file...
cd %Project_Name%
mkdir gen
call aapt.exe p -f -m -J gen -S res -I %AndroidJar_Path% -M AndroidManifest.xml
if errorlevel 1 goto ERROR

:: 3. �ͦ�.class���
:: eg> javac -encoding UTF-8 -target 1.6 -bootclasspath %AndroidJar_Path% -d bin src\com\besta\app\cmdtest\*.java gen\com\besta\app\cmdtest\R.java -classpath libs\baidumapapi.jar
echo make "*.class" file...
call javac -encoding %Javac_Encode% -target %JavacSDK_Ver% -bootclasspath %AndroidJar_Path% -d bin src\%ProjectInner_Path%\*.java gen\%ProjectInner_Path%\R.java
if errorlevel 1 goto ERROR

:: 4. �ͦ�.dex���
echo make "*.dex" file...
call dx.bat --dex --output=%Project_Path%\bin\classes.dex %Project_Path%\bin
if errorlevel 1 goto ERROR

:: 5. �Q��aapt �ͦ�*.ap_���, �Y���]�귽���
:: �ѩ�S��assets��󧨡A�]�����椧�e�ݭn�إ�assets
echo package "*.ap_" for some resouse file...
mkdir assets
call aapt.exe package -f -S res -I %AndroidJar_Path% -A assets -M AndroidManifest.xml -F %Project_Path%\bin\%ProjectRes_Name%
if errorlevel 1 goto ERROR

:: 6. �ͦ���ñ�W��apk���
echo make unsigner apk file...
call apkbuilder.bat %Project_Path%\bin\%ProjectUnsigedApk_Name% -v -u -z %Project_Path%\bin\%ProjectRes_Name% -f %Project_Path%\bin\classes.dex -rf %Project_Path%\src -nf %Project_Path%\libs -rj %Project_Path%\libs
if errorlevel 1 goto ERROR

:: 7. ��JAVA SDK���Ѫ��u��keytools�ͦ�ñ�W��apk���
:: -dname �Ѽƻ���(������)�G�z��---> �W�r���m��A��´���W�١A��´�W�١A�Ҧb��ΰϰ�W�١A �{�ά٥��A �Ҧb��a��2���a�N�X
:: �Y���g�o�ǫH���h�|�bcmd�B�檺�L�{�����ܿ�J�H���A�]���g���U���t�m�n���H���i�H�������L�椬����
echo make apk's keystore file...
call keytool.exe -genkey -alias %ProjectKeyStore_Name% -keyalg RSA -validity %ValidityDays_Count% -keystore %ProjectKeyStore_Name% -dname "CN=%RD_Name%,OU=%Company_Name%,O=%Organization_Name%,L=%Local_Name%,ST=%Province_Name%,C=%Country_ID%" -keypass %MakeApk_Pass% -storepass %KeystoreMain_Pass%
if errorlevel 1 goto ERROR

:: 8. ��jarsigner ñ�WcmdTest_unsigner.apk�ͦ�Target apk : cmdTest.apk
echo signed that unsigner apk file to make a *.apk file...
call jarsigner.exe -verbose -keystore %ProjectKeyStore_Name% -keypass %MakeApk_Pass% -storepass %KeystoreMain_Pass% -signedjar %ProjectOutApk_Name% %Project_Path%\bin\%ProjectUnsigedApk_Name% %ProjectKeyStore_Name% %MakeApk_Pass%
if errorlevel 1 goto ERROR
goto EXIT_SUCCESS

:ERROR
if exist %Success_Info% del %Success_Info%
echo some error occurred, please check!
goto EXIT_END

:EXIT_SUCCESS
echo make %ProjectOutApk_Name% success!
:: *******************************************************************************************************************************
:: OUTPUT Infomation and print in a file -------> make project's info
@echo off
echo ---------------------- > %Success_Info%
echo Total infomation:    * >> %Success_Info%
echo ---------------------- >> %Success_Info%
echo *************Project Info*************************************** >> %Success_Info%
echo Project path   : %Project_Path% >> %Success_Info%
echo Project Name   : %Project_Name% >> %Success_Info%
echo Package Name   : %ProjectPackage_Name% >> %Success_Info%
echo add-ons        : %ProjectSDK_ID% >> %Success_Info%
echo keystore       : %ProjectKeyStore_Name% >> %Success_Info%
echo keystore pass  : %MakeApk_Pass% >> %Success_Info%
echo keystore main pass: %KeystoreMain_Pass% >> %Success_Info%
echo Validity Days  : %ValidityDays_Count% >> %Success_Info%
echo *************Apk's Info***************************************** >> %Success_Info%
echo apk's Name     : %ProjectOutApk_Name% >> %Success_Info%
echo apk's Path     : %Project_Path%\%ProjectOutApk_Name% >> %Success_Info%
echo *************Developer Info************************************* >> %Success_Info%
echo Developer Name : %RD_Name% >> %Success_Info%
echo Company Name   : %Company_Name% >> %Success_Info%
echo Organization   : %Organization_Name% >> %Success_Info%
echo Country ID     : %Country_ID% >> %Success_Info%
echo *************END************************************************ >> %Success_Info%
:: save in file
::call start /wait %Success_Info%
@echo off
echo ----------------------------------------------------------------
echo Total infomation:                                              ^|
echo ----------------------------------------------------------------
echo *************Project Info***************************************
echo Project path   : %Project_Path%
echo Project Name   : %Project_Name%
echo Package Name   : %ProjectPackage_Name%
echo add-ons        : %ProjectSDK_ID%
echo keystore       : %ProjectKeyStore_Name%
echo keystore pass  : %MakeApk_Pass%
echo keystore main pass: %KeystoreMain_Pass%
echo Validity Days  : %ValidityDays_Count%
echo *************Apk's Info*****************************************
echo apk's Name     : %ProjectOutApk_Name%
echo apk's Path     : %Project_Path%\%ProjectOutApk_Name%
echo *************Developer Info*************************************
echo Developer Name : %RD_Name%
echo Company Name   : %Company_Name%
echo Organization   : %Organization_Name%
echo Country ID     : %Country_ID%
echo *************END************************************************
echo You can also see output file in :
echo %Success_Info%
goto EXIT_END

:EXIT_END
pause
exit

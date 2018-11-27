*** Settings ***
Library              AppiumLibrary


*** Variables ***
${platformName}                     Android
${platformVersion}                  8.1.0
${deviceName}                       Nokia 1
${automationName}                   Appium
${appActivity}                      com.rebtel.android.client.RebtelActivity
${appPackage}                       com.rebtel.android
${APPIUM_SERVER}                    http://localhost:4723/wd/hub
${Get_Started}                      id=com.rebtel.android:id/getStartedButton
${Continue}                         id=com.rebtel.android:id/verifyButton
${My_Number}                        id=com.rebtel.android:id/inputPhoneNumber
${Call_Me}                          id=com.rebtel.android:id/timeoutTryAgain
${Validate_My_Number}               id=com.rebtel.android:id/dialog_number
${Correct}                          id=com.rebtel.android:id/dialog_correct_button
${Dialpad}                          id=com.rebtel.android:id/dialpadButton
${Calling_Number_FIELD}             id=com.rebtel.android:id/dialpadPhoneText
${Call_Button}                      id=com.rebtel.android:id/callButton
${Hangup_Button}                    id=com.rebtel.android:id/hangupButton
${Default_Number}                   id=com.rebtel.android:id/inputPhoneNumber
${Allow_Button}                     id=com.android.packageinstaller:id/permission_allow_button
${Accept_Button}                    id=com.rebtel.android:id/accept



***Test Case***
Calling With Rebtel
    Open Rebtel
    User Login                                     +98 910 924 1640
    Calling A Number                               +33651139037
    AppiumLibrary.Click Element                    ${Hangup_Button}        #Ending the call
    Close Application

***Keywords***
Open Rebtel
    Open Application      ${APPIUM_SERVER}  platformName=${platformName}  platformVersion=${platformVersion}  deviceName=${deviceName}     automationName=${automationName}   appPackage=${appPackage}  appActivity=${appActivity}

User Login
    [Arguments]             ${My_Mobile_Number}
    AppiumLibrary.click Element                       ${Get_Started}
    AppiumLibrary.Click Element                       ${AllowButton}
    AppiumLibrary.Wait Until Page Contains            VERIFY YOUR NUMBER                                 timeout=10
    AppiumLibrary.Clear Text                          ${Default_Number}
    AppiumLibrary.Input Text                          ${My_Number}                                       ${My_Mobile_Number}
    AppiumLibrary.click Element                       ${Continue}
    AppiumLibrary.Wait Until Page Contains            Verification code has been sent to                  timeout=5
    AppiumLibrary.Wait Until Page Contains Element    ${Call_Me}                                          timeout=30
    AppiumLibrary.Click Element                       ${Call_Me}
    AppiumLibrary.Wait Until Page Contains            Is this your number?
    AppiumLibrary.Element Text Should Be              ${Validate_My_Number}                               ${Mobile_Number}
    AppiumLibrary.Click Element                       ${Correct}
    AppiumLibrary.Wait Until Page Contains            Continue                                             timeout=32
    AppiumLibrary.Click Element                       ${Accept_Button}
    AppiumLibrary.Click Element                       ${Allow_Button}
    AppiumLibrary.Wait Until Page Contains            Try now                                timeout=10


Calling A Number
    [Arguments]          ${Calling_Number}
    AppiumLibrary.Click Element                       ${Dialpad}
    AppiumLibrary.Input Number                        ${Calling_Number_FIELD}    ${Calling_Number}
    AppiumLibrary.Click Element                       ${Call_Button}
    AppiumLibrary.Wait Until Page Contains            Checking best connection type…

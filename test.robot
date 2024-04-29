*** Settings ***
Suite Setup                   Setup
Suite Teardown                Teardown
Test Setup                    Reset Emulation
Test Teardown                 Test Teardown
Resource                      ${RENODEKEYWORDS}

*** Variables ***
${SCRIPT}                     ${CURDIR}/test.resc
${UART}                       sysbus.usart3


*** Keywords ***
Load Script
    Execute Script            ${SCRIPT}
    Create Terminal Tester    ${UART}


*** Test Cases ***
Should Run Test Case
    Load Script
    Start Emulation
    Wait For Line On Uart       INFO:<Move potentiometer past 4000 to move to next test>        timeout=10
    Execute Command             sysbus.adc3 FeedSample 4010 7 -1
    Wait For Line On Uart       PASS:<STM32 ADC test done>      timeout=5


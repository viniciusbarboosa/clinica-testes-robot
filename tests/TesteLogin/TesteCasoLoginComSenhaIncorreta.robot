*** Settings *** 
Documentation   Validar login com senha incorreta
Resource        ../Keywords/Login_Steps.robot
Library         Browser
Test Setup      Run Keywords    New Browser   chromium   headless=False
...             AND    New Page   http://187.41.119.192
Test Teardown    Close Browser


*** Test Cases ***
Caso de Teste 02: Validar login com senha incorreta
    [Documentation]  Valida se o usuário consegue logar com as credenciais válidas
    [Tags]  negativo
    Login com senha Incorreta


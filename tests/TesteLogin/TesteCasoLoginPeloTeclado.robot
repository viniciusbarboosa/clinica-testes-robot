*** Settings *** 
Documentation   Validar login com submissão pelo teclado
Resource        ../Keywords/Login_Steps.robot
Library         Browser
Test Setup      Run Keywords    New Browser   chromium   headless=False
...             AND    New Page   http://187.41.119.192
Test Teardown    Close Browser


*** Test Cases ***
Caso de Teste 01: Validar login com submissão pelo teclado
    [Documentation]  Valida se o usuário consegue logar com as credenciais válidas
    [Tags]  positivo
    Login com submissão pelo teclado


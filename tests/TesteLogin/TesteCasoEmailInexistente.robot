*** Settings *** 
Documentation   Validar login com credenciais válidas
Resource        ../Keywords/Login_Steps.robot
Library         Browser
Test Setup      Run Keywords    New Browser   chromium   headless=False
...             AND    New Page   http://187.41.119.192
Test Teardown    Close Browser


*** Test Cases ***
Caso de Teste 03: Validar login com usuário inexistente
    [Documentation]  Valida se o usuário consegue logar com dados inexistentes
    [Tags]  negativo
    Login com email inexistente


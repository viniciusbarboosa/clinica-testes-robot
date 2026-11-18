*** Settings *** 
Documentation   Validar login com credenciais válidas
Resource        ../Keywords/Login_Steps.robot
Library         Browser
Test Setup      Run Keywords    New Browser   chromium   headless=False
...             AND    New Page   http://187.41.119.192
Test Teardown    Close Browser


*** Test Cases ***
Caso de Teste 04: Validar submissão com campos em branco
    [Documentation]  Valida se o usuário consegue logar sem preencher as credenciais
    [Tags]  negativo
    Submissão com campos em branco


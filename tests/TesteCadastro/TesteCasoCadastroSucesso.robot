*** Settings ***
Documentation    Cadastro de usuário com sucesso
Resource         ../Keywords/Cadastro_Steps.robot
Library          Browser
Test Setup       Run Keywords    New Browser    chromium    headless=False
...              AND    New Page    http://187.41.119.192/Account/Register
Test Teardown    Close Browser


*** Test Cases ***
Caso de Teste 01: Cadastro Efetuado Com Sucesso
    [Documentation]    Cadastra um usuário com e-mail aleatório e senha forte.
    [Tags]    positivo
    Verificar Tela De Cadastro Carregada
    ${email}=    Gerar Email Aleatorio
    Cadastrar Usuario    ${email}    @Sistema123
    Verificar Que Saiu Da Tela De Cadastro
    Tirar Print Da Tela    cadastro_sucesso
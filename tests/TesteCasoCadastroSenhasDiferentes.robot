*** Settings ***
Documentation    Cadastro com senhas diferentes
Resource         Keywords/Cadastro_Steps.robot
Library          Browser
Test Setup       Run Keywords    New Browser    chromium    headless=False
...              AND    New Page    http://187.41.119.192/Account/Register
Test Teardown    Close Browser


*** Test Cases ***
Caso de Teste 04: Senhas Diferentes Sao Rejeitadas
    [Documentation]    Confirmação de senha diferente da senha.
    [Tags]    negativo
    Verificar Tela De Cadastro Carregada
    ${email}=    Gerar Email Aleatorio
    Cadastrar Usuario    ${email}    @Sistema123    @Sistema123x
    Verificar Mensagem De Validacao    As senhas não conferem.
    Verificar Que Continua Na Tela De Cadastro
    Tirar Print Da Tela    cadastro_senhas_diferentes
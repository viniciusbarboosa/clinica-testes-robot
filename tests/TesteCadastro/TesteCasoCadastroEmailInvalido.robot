*** Settings ***
Documentation    Cadastro com e-mail inválido
Resource         ../Keywords/Cadastro_Steps.robot
Library          Browser
Test Setup       Run Keywords    New Browser    chromium    headless=False
...              AND    New Page    http://187.41.119.192/Account/Register
Test Teardown    Close Browser


*** Test Cases ***
Caso de Teste 03: E-mail Invalido E Rejeitado
    [Documentation]    Tenta cadastrar com e-mail sem arroba.
    [Tags]    negativo
    Verificar Tela De Cadastro Carregada
    Cadastrar Usuario    email-sem-arroba    @Sistema123
    Verificar Mensagem De Validacao    E-mail inválido.
    Verificar Que Continua Na Tela De Cadastro
    Tirar Print Da Tela    cadastro_email_invalido
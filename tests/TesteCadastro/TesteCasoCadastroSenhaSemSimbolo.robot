*** Settings ***
Documentation    Cadastro com senha sem símbolo
Resource         ../Keywords/Cadastro_Steps.robot
Library          Browser
Test Setup       Run Keywords    New Browser    chromium    headless=False
...              AND    New Page    http://187.41.119.192/Account/Register
Test Teardown    Close Browser


*** Test Cases ***
Caso de Teste 05: Senha Sem Simbolo E Rejeitada
    [Documentation]    Senha sem símbolo não atende à política de senha.
    [Tags]    negativo
    Verificar Tela De Cadastro Carregada
    ${email}=    Gerar Email Aleatorio
    Cadastrar Usuario    ${email}    Sistema123
    Verificar Alerta De Erro    A senha precisa ter pelo menos um símbolo
    Verificar Que Continua Na Tela De Cadastro
    Tirar Print Da Tela    cadastro_senha_sem_simbolo
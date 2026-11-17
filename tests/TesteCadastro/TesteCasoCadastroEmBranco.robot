*** Settings ***
Documentation    Cadastro com formulário em branco
Resource         ../Keywords/Cadastro_Steps.robot
Library          Browser
Test Setup       Run Keywords    New Browser    chromium    headless=False
...              AND    New Page    http://187.41.119.192/Account/Register
Test Teardown    Close Browser


*** Test Cases ***
Caso de Teste 02: Formulario Em Branco Exige E-mail E Senha
    [Documentation]    Envia o formulário vazio e confere as mensagens obrigatórias.
    [Tags]    negativo
    Verificar Tela De Cadastro Carregada
    Submeter Formulario De Cadastro
    Verificar Mensagem De Validacao    Informe o e-mail.
    Verificar Mensagem De Validacao    Informe a senha.
    Verificar Que Continua Na Tela De Cadastro
    Tirar Print Da Tela    cadastro_em_branco
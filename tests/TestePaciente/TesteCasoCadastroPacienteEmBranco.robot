*** Settings ***
Documentation    Cadastro de paciente com campos obrigatórios em branco
Resource         ../Keywords/Paciente_Steps.robot
Resource         ../Keywords/Cadastro_Steps.robot
Library          Browser
Test Setup       Run Keywords    New Browser    chromium    headless=False
...              AND    New Page    http://187.41.119.192/Account/Register
Test Teardown    Close Browser


*** Test Cases ***
Caso de Teste 02: Campos Obrigatorios Em Branco Devem Exibir Validacao
    [Documentation]    Abre o modal de novo paciente, tenta salvar sem preencher nada e valida as mensagens de campo obrigatório.
    [Tags]    negativo    paciente
    Verificar Tela De Cadastro Carregada
    ${user_email}=    Gerar Email Aleatorio
    Cadastrar Usuario    ${user_email}    @Sistema123
    Verificar Que Saiu Da Tela De Cadastro

    Acessar Pagina De Pacientes
    Abrir Modal Novo Paciente
    Submeter Formulario Paciente

    Verificar Mensagem De Validacao Paciente    Informe o nome.
    Verificar Mensagem De Validacao Paciente    Informe o CPF.
    Verificar Mensagem De Validacao Paciente    Informe a data de nascimento.
    Tirar Print Da Tela Paciente    paciente_cadastro_em_branco

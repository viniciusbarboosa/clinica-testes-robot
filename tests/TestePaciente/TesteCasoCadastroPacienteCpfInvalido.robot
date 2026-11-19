*** Settings ***
Documentation    Cadastro de paciente com CPF inválido
Resource         ../Keywords/Paciente_Steps.robot
Resource         ../Keywords/Cadastro_Steps.robot
Library          Browser
Test Setup       Run Keywords    New Browser    chromium    headless=False
...              AND    New Page    http://187.41.119.192/Account/Register
Test Teardown    Close Browser


*** Test Cases ***
Caso de Teste 03: CPF Invalido Deve Ser Rejeitado
    [Documentation]    Tenta cadastrar paciente com formato de CPF incorreto ou dígitos verificadores inválidos.
    [Tags]    negativo    paciente
    Verificar Tela De Cadastro Carregada
    ${user_email}=    Gerar Email Aleatorio
    Cadastrar Usuario    ${user_email}    @Sistema123
    Verificar Que Saiu Da Tela De Cadastro

    Acessar Pagina De Pacientes
    Cadastrar Paciente Completo    Maria Oliveira    11111111111    1990-10-10    11999998888    maria@exemplo.com

    Verificar Mensagem De Validacao Paciente    CPF inválido.
    Tirar Print Da Tela Paciente    paciente_cpf_invalido

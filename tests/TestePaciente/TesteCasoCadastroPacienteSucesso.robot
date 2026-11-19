*** Settings ***
Documentation    Cadastro de paciente com sucesso
Resource         ../Keywords/Paciente_Steps.robot
Resource         ../Keywords/Cadastro_Steps.robot
Library          Browser
Test Setup       Run Keywords    New Browser    chromium    headless=False
...              AND    New Page    http://187.41.119.192/Account/Register
Test Teardown    Close Browser


*** Test Cases ***
Caso de Teste 01: Cadastrar Paciente Com Sucesso
    [Documentation]    Cria uma conta, navega para a tela de pacientes e cadastra um novo paciente válido.
    [Tags]    positivo    paciente
    Verificar Tela De Cadastro Carregada
    ${user_email}=    Gerar Email Aleatorio
    Cadastrar Usuario    ${user_email}    @Sistema123
    Verificar Que Saiu Da Tela De Cadastro

    Acessar Pagina De Pacientes
    ${cpf}=    Gerar Cpf Valido
    ${email_paciente}=    Gerar Email Aleatorio Paciente
    Cadastrar Paciente Completo    Carlos Eduardo da Silva    ${cpf}    1995-05-20    11988887777    ${email_paciente}

    Verificar Sucesso No Cadastro De Paciente
    Verificar Paciente Na Listagem    Carlos Eduardo da Silva
    Tirar Print Da Tela Paciente    paciente_cadastro_sucesso

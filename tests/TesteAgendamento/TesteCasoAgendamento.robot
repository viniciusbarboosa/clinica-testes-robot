*** Settings ***
Documentation    Casos de validação do agendamento de consultas
Resource         ../Keywords/Agendamento_Steps.robot
Resource         ../Keywords/Cadastro_Steps.robot
Resource         ../Keywords/Paciente_Steps.robot
Library          Browser
Test Setup       Run Keywords    New Browser    chromium    headless=False
...              AND    New Page    http://187.41.119.192/Account/Register
...              AND    Preparar Ambiente Agendamento
Test Teardown    Close Browser


*** Test Cases ***
Caso de Teste 001: Validacao De Agendamento De Consulta
    [Documentation]    Agenda uma consulta informando médico, paciente, data e horário válidos.
    [Tags]    positivo    agendamento
    ${data}=    Gerar Data Futura
    Abrir Modal Nova Consulta
    Preencher Agendamento    Dra. Ana Silva - Clínica Geral    Carlos Eduardo da Silva    ${data}    15:30
    Submeter Agendamento
    Verificar Sucesso No Agendamento
    Tirar Print Da Tela Agendamento    agendamento_sucesso

Caso de Teste 002: Marcar Consulta Com Hora Passada
    [Documentation]    Tenta agendar uma consulta em horário anterior ao horário atual.
    [Tags]    negativo    agendamento
    ${data}=    Gerar Data Atual
    ${hora}=    Gerar Hora Passada
    Abrir Modal Nova Consulta
    Preencher Agendamento    Dra. Ana Silva - Clínica Geral    Carlos Eduardo da Silva    ${data}    ${hora}
    Submeter Agendamento
    Verificar Validacao Do Agendamento    A data e o horário precisam estar no futuro.
    Tirar Print Da Tela Agendamento    agendamento_hora_passada

Caso de Teste 003: Marcar Consulta Sem Informar O Medico
    [Documentation]    Tenta agendar sem selecionar o médico.
    [Tags]    negativo    agendamento
    ${data}=    Gerar Data Futura
    Abrir Modal Nova Consulta
    Preencher Agendamento    ${EMPTY}    Carlos Eduardo da Silva    ${data}    15:30
    Submeter Agendamento
    Verificar Validacao Do Agendamento    Selecione o médico.
    Tirar Print Da Tela Agendamento    agendamento_sem_medico

Caso de Teste 004: Marcar Consulta Sem Informar O Paciente
    [Documentation]    Tenta agendar sem selecionar o paciente.
    [Tags]    negativo    agendamento
    ${data}=    Gerar Data Futura
    Abrir Modal Nova Consulta
    Preencher Agendamento    Dra. Ana Silva - Clínica Geral    ${EMPTY}    ${data}    15:30
    Submeter Agendamento
    Verificar Validacao Do Agendamento    Selecione o paciente.
    Tirar Print Da Tela Agendamento    agendamento_sem_paciente

Caso de Teste 005: Marcar Consulta Sem A Data
    [Documentation]    Tenta agendar sem informar a data da consulta.
    [Tags]    negativo    agendamento
    Abrir Modal Nova Consulta
    Preencher Agendamento    Dra. Ana Silva - Clínica Geral    Carlos Eduardo da Silva    ${EMPTY}    15:30
    Submeter Agendamento
    Verificar Validacao Do Agendamento    Informe a data.
    Tirar Print Da Tela Agendamento    agendamento_sem_data

Caso de Teste 008: Marcar Consulta Com Data No Passado
    [Documentation]    Tenta agendar com data anterior à data atual.
    [Tags]    negativo    agendamento
    ${data}=    Gerar Data Passada
    Abrir Modal Nova Consulta
    ${data_minima}=    Get Attribute    ${INPUT_AGENDAMENTO_DATA}    min
    ${data_atual}=    Gerar Data Atual
    Should Be Equal    ${data_minima}    ${data_atual}
    Evaluate JavaScript    ${INPUT_AGENDAMENTO_DATA}    (element) => element.removeAttribute('min')
    Preencher Agendamento    Dra. Ana Silva - Clínica Geral    Carlos Eduardo da Silva    ${data}    15:30
    Submeter Agendamento
    Verificar Validacao Do Agendamento    A data e o horário precisam estar no futuro.
    Tirar Print Da Tela Agendamento    agendamento_data_passada

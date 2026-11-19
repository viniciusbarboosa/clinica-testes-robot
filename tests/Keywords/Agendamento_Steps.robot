*** Settings ***
Library    Browser
Library    DateTime
Resource   ../Pages/Agendamento_Page.robot
Resource   ../Pages/Login_Page.robot
Resource   ../Pages/Cadastro_Page.robot
Resource   ../Pages/Paciente_Page.robot
Resource   ../Keywords/Cadastro_Steps.robot
Resource   ../Keywords/Paciente_Steps.robot


*** Keywords ***
Login Para Agendamento
    [Arguments]    ${email}=agenda17839@example.com    ${senha}=@Sistema123
    Fill Text    ${INPUT_EMAIL}     ${email}
    Fill Text    ${INPUT_SENHA}     ${senha}
    Click        ${BUTTON_ENTRAR}
    Wait For Elements State    ${TITULO_AGENDAMENTO}    visible

Acessar Pagina De Agendamento
    Go To    http://187.41.119.192/
    Wait For Elements State    ${TITULO_AGENDAMENTO}    visible

Acessar Pagina De Medicos
    Go To    http://187.41.119.192/medicos
    Wait For Elements State    //h5[contains(normalize-space(.),'Médicos')]    visible

Cadastrar Dados Para Agendamento
    [Arguments]    ${cpf}    ${email_paciente}
    Wait For Elements State    //button[contains(.,'Novo médico')]    enabled
    Sleep    1s
    Click    //button[contains(.,'Novo médico')]
    Wait For Elements State    //div[@role='dialog']    visible
    Fill Text    //div[@role='dialog']//input[@id='nome']    Dra. Ana Silva
    Fill Text    //div[@role='dialog']//input[@id='crm']    CRM12345
    Fill Text    //div[@role='dialog']//input[@id='especialidade']    Clínica Geral
    Fill Text    //div[@role='dialog']//input[@id='telefone']    11988887777
    Click    //div[@role='dialog']//button[@type='submit']
    Wait For Elements State    //div[contains(@class,'alert-success')]    visible

    Go To    http://187.41.119.192/pacientes
    Wait For Elements State    ${BOTAO_NOVO_PACIENTE}    visible
    Wait For Elements State    ${BOTAO_NOVO_PACIENTE}    enabled
    Sleep    1s
    Cadastrar Paciente Completo    Carlos Eduardo da Silva    ${cpf}    1995-05-20    11988887777    ${email_paciente}
    Verificar Sucesso No Cadastro De Paciente

Preparar Ambiente Agendamento
    Verificar Tela De Cadastro Carregada
    ${user_email}=    Gerar Email Aleatorio
    Cadastrar Usuario    ${user_email}    @Sistema123
    Verificar Que Saiu Da Tela De Cadastro
    ${cpf}=    Gerar Cpf Valido
    ${email_paciente}=    Gerar Email Aleatorio Paciente
    Acessar Pagina De Medicos
    Cadastrar Dados Para Agendamento    ${cpf}    ${email_paciente}
    Acessar Pagina De Agendamento

Abrir Modal Nova Consulta
    Wait For Elements State    ${BOTAO_NOVA_CONSULTA}    visible
    Wait For Elements State    ${BOTAO_NOVA_CONSULTA}    enabled
    Sleep    1s
    Click    ${BOTAO_NOVA_CONSULTA}
    Wait For Elements State    ${MODAL_NOVA_CONSULTA}    visible

Preencher Agendamento
    [Arguments]    ${medico}=Dra. Ana Silva - Clínica Geral    ${paciente}=Carlos Eduardo da Silva
    ...            ${data}=${EMPTY}    ${hora}=${EMPTY}
    IF    '${medico}' != '${EMPTY}'
        Select Options By    ${SELECT_AGENDAMENTO_MEDICO}    label    ${medico}
    END
    IF    '${paciente}' != '${EMPTY}'
        Select Options By    ${SELECT_AGENDAMENTO_PACIENTE}    label    ${paciente}
    END
    Fill Text    ${INPUT_AGENDAMENTO_DATA}    ${data}
    Fill Text    ${INPUT_AGENDAMENTO_HORA}    ${hora}

Submeter Agendamento
    Click    ${BOTAO_SALVAR_CONSULTA}

Verificar Sucesso No Agendamento
    Wait For Elements State    ${ALERTA_SUCESSO_AGENDAMENTO}    visible
    Get Text    ${ALERTA_SUCESSO_AGENDAMENTO}    contains    Consulta agendada com sucesso.

Verificar Validacao Do Agendamento
    [Arguments]    ${texto}
    Get Text    //body    contains    ${texto}

Gerar Data Futura
    ${hoje}=    Get Current Date
    ${futura}=    Add Time To Date    ${hoje}    30 days    %Y-%m-%d
    RETURN    ${futura}

Gerar Data Atual
    ${hoje}=    Get Current Date
    ${atual}=    Convert Date    ${hoje}    result_format=%Y-%m-%d
    RETURN    ${atual}

Gerar Data Passada
    ${hoje}=    Get Current Date
    ${passada}=    Add Time To Date    ${hoje}    -1 day    %Y-%m-%d
    RETURN    ${passada}

Gerar Hora Passada
    ${agora}=    Get Current Date
    ${hora_atual}=    Convert Date    ${agora}    result_format=%H
    IF    ${hora_atual} == 0
        ${passada}=    Set Variable    00:00
    ELSE
        ${passada}=    Add Time To Date    ${agora}    -1 hour    %H:%M
    END
    RETURN    ${passada}

Tirar Print Da Tela Agendamento
    [Arguments]    ${nome}
    Take Screenshot    ${nome}

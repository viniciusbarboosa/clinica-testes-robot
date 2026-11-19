*** Settings ***
Documentation     Suíte de testes automatizados - Cadastro e Gerenciamento de Médicos (Viita v1.0.1).
Library           Browser
Resource          ../Keywords/Medico_Steps.robot

Suite Setup       Realizar Login No Sistema Viita
Suite Teardown    Close Browser
Test Setup        Acessar Pagina De Medicos

*** Keywords ***
Gerar Codigo Unico
    ${timestamp}=    Get Time    epoch
    ${codigo}=       Evaluate    str(${timestamp})[-6:]
    RETURN           ${codigo}

*** Test Cases ***
CT01 - Cadastrar medico com todas as informacoes completas
    [Tags]             cadastro    positivo
    ${codigo}=         Gerar Codigo Unico
    ${nome}=           Set Variable    Dr. Teste Automatizado ${codigo}
    ${crm}=            Set Variable    ${codigo}-PE
    ${especialidade}=  Set Variable    Cardiologia
    ${telefone}=       Set Variable    (81) 99999-1234

    Abrir Formulario De Cadastro De Medico
    Preencher Dados Do Medico    nome=${nome}    crm=${crm}    especialidade=${especialidade}    telefone=${telefone}
    Salvar Cadastro Do Medico
    Validar Medico Na Listagem   nome=${nome}    crm=${crm}    especialidade=${especialidade}

CT02 - Impedir cadastro de medico sem informar CRM
    [Tags]             cadastro    negativo
    ${codigo}=         Gerar Codigo Unico
    ${nome}=           Set Variable    Dr. Sem CRM ${codigo}

    Abrir Formulario De Cadastro De Medico
    Preencher Dados Do Medico              nome=${nome}    crm=${EMPTY}    especialidade=Ortopedia    telefone=(81) 98888-0000
    Salvar Cadastro Do Medico
    Validar Bloqueio Por Campo Obrigatorio    ${INPUT_CRM}    ${nome}

CT03 - Impedir cadastro de medico sem informar a especializacao
    [Tags]             cadastro    negativo
    ${codigo}=         Gerar Codigo Unico
    ${nome}=           Set Variable    Dr. Sem Especialidade ${codigo}

    Abrir Formulario De Cadastro De Medico
    Preencher Dados Do Medico              nome=${nome}    crm=99${codigo}-PE    especialidade=${EMPTY}    telefone=(81) 97777-0000
    Salvar Cadastro Do Medico
    Validar Bloqueio Por Campo Obrigatorio    ${CAMPO_ESPECIALIDADE}    ${nome}

CT04 - Excluir medicos sem vinculos ativos
    [Tags]             exclusao    positivo
    ${codigo}=         Gerar Codigo Unico
    ${nome}=           Set Variable    Dr. Exclusao ${codigo}
    ${crm}=            Set Variable    EX${codigo}-PE

    Abrir Formulario De Cadastro De Medico
    Preencher Dados Do Medico           nome=${nome}    crm=${crm}    especialidade=Dermatologia    telefone=(81) 96666-0000
    Salvar Cadastro Do Medico
    Validar Medico Na Listagem          nome=${nome}    crm=${crm}    especialidade=Dermatologia

    Solicitar Exclusao Do Medico        ${crm}
    Confirmar Modal De Exclusao
    Validar Medico Excluido Da Listagem    ${crm}

CT05 - Nao permitir exclusao de medicos com consultas registradas
    [Tags]             exclusao    negativo
    Solicitar Exclusao Do Medico                    ${MEDICO_COM_CONSULTA}
    Validar Bloqueio De Exclusao Com Consulta Registrada    ${MEDICO_COM_CONSULTA}
*** Settings ***
Library     Browser
Library     String
Resource    ../Pages/Cadastro_Page.robot


*** Keywords ***
Gerar Email Aleatorio
    ${agora}=        Get Time    epoch
    ${aleatorio}=    Evaluate    random.randint(100, 999)    modules=random
    RETURN           testuser_${agora}${aleatorio}@exemplo.com

Verificar Tela De Cadastro Carregada
    Wait For Elements State    ${TITULO_CADASTRO}    visible

Preencher Dados De Cadastro
    [Arguments]    ${email}    ${senha}    ${confirmacao}=${senha}
    Fill Text    ${INPUT_EMAIL}            ${email}
    Fill Text    ${INPUT_SENHA}            ${senha}
    Fill Text    ${INPUT_CONFIRMAR_SENHA}  ${confirmacao}

Submeter Formulario De Cadastro
    Click    ${BUTTON_CRIAR_CONTA}

Cadastrar Usuario
    [Arguments]    ${email}    ${senha}    ${confirmacao}=${senha}
    Preencher Dados De Cadastro    ${email}    ${senha}    ${confirmacao}
    Submeter Formulario De Cadastro

Verificar Mensagem De Validacao
    [Arguments]    ${texto}
    ${seletor}=    Replace String    ${MSG_VALIDACAO}    {TEXTO}    ${texto}
    Wait For Elements State    ${seletor}    visible

Verificar Alerta De Erro
    [Arguments]    ${texto}
    Wait For Elements State    ${ALERTA_ERRO}    visible
    Get Text    ${ALERTA_ERRO}    contains    ${texto}

Verificar Que Continua Na Tela De Cadastro
    ${url}=    Get Url
    Should Contain    ${url}    /Account/Register

Url Nao Deve Conter Cadastro
    ${url}=    Get Url
    Should Not Contain    ${url}    /Account/Register

Verificar Que Saiu Da Tela De Cadastro
    Wait Until Keyword Succeeds    10s    500ms    Url Nao Deve Conter Cadastro

Tirar Print Da Tela
    [Arguments]    ${nome}
    Take Screenshot    ${nome}
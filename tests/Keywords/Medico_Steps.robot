*** Settings ***
Documentation     Keywords de autenticação e regras de negócio do módulo de Médicos.
Library           Browser
Resource          ../Pages/Medico_Page.robot

*** Keywords ***
Realizar Login No Sistema Viita
    New Browser    chromium    headless=False
    Set Browser Timeout    30s
    New Context    viewport={'width': 1366, 'height': 768}
    New Page       ${URL_MEDICOS}    wait_until=domcontentloaded

    Wait For Elements State    ${TITULO_ENTRAR}       visible
    Wait For Elements State    ${INPUT_EMAIL_LOGIN}   visible
    Sleep    1.5s

    Fill Text     ${INPUT_EMAIL_LOGIN}    ${EMAIL_SISTEMA}
    Press Keys    ${INPUT_EMAIL_LOGIN}    Tab
    Fill Text     ${INPUT_SENHA_LOGIN}    ${SENHA_SISTEMA}
    Press Keys    ${INPUT_SENHA_LOGIN}    Tab

    Click    ${BTN_ENTRAR_LOGIN}
    Wait For Elements State    ${TITULO_ENTRAR}    hidden

Acessar Pagina De Medicos
    Go To    ${URL_MEDICOS}    wait_until=domcontentloaded
    Wait For Elements State    ${BTN_NOVO_MEDICO}    visible
    Sleep    1.5s

Abrir Formulario De Cadastro De Medico
    Click    ${BTN_NOVO_MEDICO}
    ${abriu}=    Run Keyword And Return Status
    ...    Wait For Elements State    ${BTN_SALVAR}    visible    timeout=4s
    IF    not ${abriu}
        Click    ${BTN_NOVO_MEDICO}
        Wait For Elements State    ${BTN_SALVAR}    visible    timeout=15s
    END
    Sleep    0.5s

Preencher Dados Do Medico
    [Arguments]    ${nome}=${EMPTY}    ${crm}=${EMPTY}    ${especialidade}=${EMPTY}    ${telefone}=${EMPTY}
    IF    '${nome}' != '${EMPTY}'
        Fill Text    ${INPUT_NOME}    ${nome}
        Press Keys   ${INPUT_NOME}    Tab
    END

    IF    '${crm}' != '${EMPTY}'
        Fill Text    ${INPUT_CRM}    ${crm}
        Press Keys   ${INPUT_CRM}    Tab
    END

    IF    '${especialidade}' != '${EMPTY}'
        ${tag}=    Get Property    ${CAMPO_ESPECIALIDADE}    tagName
        IF    '${tag}' == 'SELECT'
            Select Options By    ${CAMPO_ESPECIALIDADE}    label    ${especialidade}
        ELSE
            Fill Text    ${CAMPO_ESPECIALIDADE}    ${especialidade}
        END
        Press Keys   ${CAMPO_ESPECIALIDADE}    Tab
    END

    IF    '${telefone}' != '${EMPTY}'
        Fill Text    ${INPUT_TELEFONE}    ${telefone}
        Press Keys   ${INPUT_TELEFONE}    Tab
    END

Salvar Cadastro Do Medico
    Click    ${BTN_SALVAR}

Validar Medico Na Listagem
    [Arguments]    ${nome}    ${crm}    ${especialidade}
    ${linha}=    Set Variable    css=tr:has-text("${crm}") >> nth=0
    Wait For Elements State    ${linha}    visible
    Get Text    ${linha}    contains    ${nome}
    Get Text    ${linha}    contains    ${especialidade}

Validar Bloqueio Por Campo Obrigatorio
    [Arguments]    ${seletor_campo}    ${nome_medico}=${EMPTY}
    Sleep    1s
    # 1. Garante que o modal/formulário permaneceu aberto e não concluiu o cadastro
    Wait For Elements State    ${BTN_SALVAR}    visible

    # 2. Verifica validação nativa HTML5 via JavaScript (sem erro de validity.valid)
    ${html5_valido}=    Evaluate JavaScript    ${seletor_campo}    (el) => el.checkValidity()
    Log    Validação HTML5 do campo: ${html5_valido}

    # 3. Garante que o médico não foi adicionado na listagem
    IF    '${nome_medico}' != '${EMPTY}'
        ${qtd_na_lista}=    Get Element Count    css=tr:has-text("${nome_medico}")
        Should Be Equal As Integers    ${qtd_na_lista}    0    msg=O médico não deveria ter sido cadastrado sem o campo obrigatório.
    END

Solicitar Exclusao Do Medico
    [Arguments]    ${identificador}
    ${linha}=          Set Variable    css=tr:has-text("${identificador}") >> nth=0
    Wait For Elements State    ${linha}    visible
    ${btn_excluir}=    Set Variable    ${linha} >> css=:is(button, a) >> nth=1
    Click    ${btn_excluir}

Confirmar Modal De Exclusao
    Wait For Elements State    ${BTN_CONFIRMAR_EXCLUSAO}    visible
    Click    ${BTN_CONFIRMAR_EXCLUSAO}

Validar Medico Excluido Da Listagem
    [Arguments]    ${identificador}
    ${linha}=    Set Variable    css=tr:has-text("${identificador}")
    Wait For Elements State    ${linha}    detached

Validar Bloqueio De Exclusao Com Consulta Registrada
    [Arguments]    ${identificador}
    ${modal_visivel}=    Run Keyword And Return Status
    ...    Wait For Elements State    ${BTN_CONFIRMAR_EXCLUSAO}    visible    timeout=3s
    IF    ${modal_visivel}
        Click    ${BTN_CONFIRMAR_EXCLUSAO}
    END
    Wait For Elements State    ${ALERTA_ERRO_INTEGRIDADE}    visible
    ${linha}=    Set Variable    css=tr:has-text("${identificador}") >> nth=0
    Wait For Elements State    ${linha}    visible
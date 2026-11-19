*** Settings ***
Library     Browser
Library     String
Resource    ../Pages/Paciente_Page.robot
Resource    ../Pages/Cadastro_Page.robot


*** Keywords ***
Gerar Cpf Valido
    # Gera os 9 primeiros dígitos aleatórios
    ${d1}=    Evaluate    random.randint(0, 9)    modules=random
    ${d2}=    Evaluate    random.randint(0, 9)    modules=random
    ${d3}=    Evaluate    random.randint(0, 9)    modules=random
    ${d4}=    Evaluate    random.randint(0, 9)    modules=random
    ${d5}=    Evaluate    random.randint(0, 9)    modules=random
    ${d6}=    Evaluate    random.randint(0, 9)    modules=random
    ${d7}=    Evaluate    random.randint(0, 9)    modules=random
    ${d8}=    Evaluate    random.randint(0, 9)    modules=random
    ${d9}=    Evaluate    random.randint(0, 9)    modules=random

    # Calcula primeiro dígito verificador
    ${soma1}=    Evaluate    ${d1}*10 + ${d2}*9 + ${d3}*8 + ${d4}*7 + ${d5}*6 + ${d6}*5 + ${d7}*4 + ${d8}*3 + ${d9}*2
    ${resto1}=   Evaluate    ${soma1} % 11
    ${dv1}=      Evaluate    0 if ${resto1} < 2 else 11 - ${resto1}

    # Calcula segundo dígito verificador
    ${soma2}=    Evaluate    ${d1}*11 + ${d2}*10 + ${d3}*9 + ${d4}*8 + ${d5}*7 + ${d6}*6 + ${d7}*5 + ${d8}*4 + ${d9}*3 + ${dv1}*2
    ${resto2}=   Evaluate    ${soma2} % 11
    ${dv2}=      Evaluate    0 if ${resto2} < 2 else 11 - ${resto2}

    ${cpf}=      Catenate    SEPARATOR=    ${d1}    ${d2}    ${d3}    ${d4}    ${d5}    ${d6}    ${d7}    ${d8}    ${d9}    ${dv1}    ${dv2}
    RETURN       ${cpf}

Gerar Email Aleatorio Paciente
    ${agora}=        Get Time    epoch
    ${aleatorio}=    Evaluate    random.randint(100, 999)    modules=random
    RETURN           paciente_${agora}${aleatorio}@exemplo.com

Login No Sistema
    [Arguments]    ${email}    ${senha}
    Fill Text    //input[@id='Input.Email']       ${email}
    Fill Text    //input[@id='Input.Password']    ${senha}
    Click        //button[@type='submit']
    Wait For Navigation

Acessar Pagina De Pacientes
    [Arguments]    ${base_url}=http://187.41.119.192
    Go To    ${base_url}/pacientes
    Verificar Tela De Pacientes Carregada

Verificar Tela De Pacientes Carregada
    Wait For Elements State    ${TITULO_PACIENTES}    visible

Abrir Modal Novo Paciente
    Click    ${BOTAO_NOVO_PACIENTE}
    Wait For Elements State    ${TITULO_MODAL_PACIENTE}    visible

Preencher Formulario Paciente
    [Arguments]    ${nome}    ${cpf}    ${nascimento}    ${telefone}=${EMPTY}    ${email}=${EMPTY}
    Fill Text    ${INPUT_PACIENTE_NOME}          ${nome}
    Fill Text    ${INPUT_PACIENTE_CPF}           ${cpf}
    Fill Text    ${INPUT_PACIENTE_NASCIMENTO}    ${nascimento}
    IF    '${telefone}' != '${EMPTY}'
        Fill Text    ${INPUT_PACIENTE_TELEFONE}    ${telefone}
    END
    IF    '${email}' != '${EMPTY}'
        Fill Text    ${INPUT_PACIENTE_EMAIL}       ${email}
    END

Submeter Formulario Paciente
    Click    ${BOTAO_SALVAR_PACIENTE}

Cadastrar Paciente Completo
    [Arguments]    ${nome}    ${cpf}    ${nascimento}    ${telefone}=${EMPTY}    ${email}=${EMPTY}
    Abrir Modal Novo Paciente
    Preencher Formulario Paciente    ${nome}    ${cpf}    ${nascimento}    ${telefone}    ${email}
    Submeter Formulario Paciente

Verificar Sucesso No Cadastro De Paciente
    Wait For Elements State    ${ALERTA_SUCESSO}    visible
    Get Text    ${ALERTA_SUCESSO}    contains    Paciente cadastrado com sucesso.

Verificar Mensagem De Validacao Paciente
    [Arguments]    ${texto}
    ${seletor}=    Replace String    ${MSG_VALIDACAO}    {TEXTO}    ${texto}
    Wait For Elements State    ${seletor}    visible

Verificar Alerta De Erro Paciente
    [Arguments]    ${texto}
    Wait For Elements State    ${ALERTA_ERRO}    visible
    Get Text    ${ALERTA_ERRO}    contains    ${texto}

Verificar Paciente Na Listagem
    [Arguments]    ${nome}
    ${seletor}=    Replace String    ${LINHA_PACIENTE}    {NOME}    ${nome}
    Wait For Elements State    ${seletor}    visible

Tirar Print Da Tela Paciente
    [Arguments]    ${nome}
    Take Screenshot    ${nome}


*** Settings ***
Library     Browser
Library     String
Resource    ../Pages/Login_Page.robot


*** Keywords ***
Login com credenciais válidas
    ${email}=    Set Variable    sistema@gmail.com
    ${senha}=    Set Variable    @Sistema123

    Fill Text    css=input[name="Input.Email"]    ${email}
    Fill Text    css=input[type="password"]    ${senha}

    Click    css=button:has-text("Entrar")

    Sleep    1s

    Get Title   ==   Marcação


Login com senha Incorreta
    ${email}=    Set Variable    sistema@gmail.com
    ${senha}=    Set Variable    @Sistema1234
    ${mensagem}=    Set Variable    E-mail ou senha inválidos. Se você acabou de se cadastrar, confirme sua conta antes de entrar.

    Fill Text    css=input[name="Input.Email"]    ${email}
    Fill Text    css=input[type="password"]    ${senha}

    Click    css=button:has-text("Entrar")

    Sleep    1s

    Wait For Elements State    text="${mensagem}"    visible    timeout=10s


Login com email inexistente
    ${email}=    Set Variable    sistema-inexistente@gmail.com
    ${senha}=    Set Variable    @Sistema1234
    ${mensagem}=    Set Variable    E-mail ou senha inválidos. Se você acabou de se cadastrar, confirme sua conta antes de entrar.

    Fill Text    css=input[name="Input.Email"]    ${email}
    Fill Text    css=input[type="password"]    ${senha}

    Click    css=button:has-text("Entrar")

    Sleep    1s

    Wait For Elements State    text="${mensagem}"    visible    timeout=10s


Submissão com campos em branco
    Click    css=button:has-text("Entrar")

    Sleep    1s

    Wait For Elements State    text="Informe o e-mail."    visible    timeout=2s
    Wait For Elements State    text="Informe a senha."    visible    timeout=2s


Login com submissão pelo teclado
    ${email}=    Set Variable    sistema@gmail.com
    ${senha}=    Set Variable    @Sistema123

    Fill Text    css=input[name="Input.Email"]    ${email}
    Fill Text    css=input[type="password"]    ${senha}

    Press Keys    css=input[type="password"]    Enter

    Sleep    1s

    Get Title   ==   Marcação

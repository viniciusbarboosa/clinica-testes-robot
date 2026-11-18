
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
 

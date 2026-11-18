*** Settings ***
Library     Browser
Library     String
Resource    ../Pages/Login_Page.robot


*** Keywords ***
Login com credenciais válidas
    ${email} Set Variable sistema@gmail.com
    ${senha} Set Variable @Sistema123

    Fill Text css=input[type='email']   

    Log ${email}
    Log ${senha}
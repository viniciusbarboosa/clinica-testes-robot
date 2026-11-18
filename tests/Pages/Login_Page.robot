*** Variables ***
${TITULO_LOGIN}        //h3[contains(normalize-space(.),'Entrar')]
${INPUT_EMAIL}            //input[@id='Input.Email']
${INPUT_SENHA}            //input[@id='Input.Password']
${BUTTON_ENTRAR}     //button[@type='submit']
${ALERTA_ERRO}            //div[contains(@class,'alert-danger')]
${MSG_VALIDACAO}          //*[contains(@class,'text-danger')][contains(normalize-space(.),'{TEXTO}')]
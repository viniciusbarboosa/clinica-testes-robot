*** Variables ***
${TITULO_CADASTRO}        //h3[contains(normalize-space(.),'Criar conta')]
${INPUT_EMAIL}            //input[@id='Input.Email']
${INPUT_SENHA}            //input[@id='Input.Password']
${INPUT_CONFIRMAR_SENHA}  //input[@id='Input.ConfirmPassword']
${BUTTON_CRIAR_CONTA}     //button[@type='submit']
${ALERTA_ERRO}            //div[contains(@class,'alert-danger')]
${MSG_VALIDACAO}          //*[contains(@class,'text-danger')][contains(normalize-space(.),'{TEXTO}')]
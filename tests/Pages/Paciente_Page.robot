*** Variables ***
# Navegação e Header da Listagem
${TITULO_PACIENTES}           //h5[contains(normalize-space(.),'Pacientes')]
${BOTAO_NOVO_PACIENTE}        //button[contains(.,'Novo paciente')]
${CAMPO_BUSCA_PACIENTE}       //input[@type='search']

# Modal de Cadastro / Edição
${TITULO_MODAL_PACIENTE}      //h5[contains(@class,'modal-title') and contains(.,'Novo paciente')]
${INPUT_PACIENTE_NOME}        //input[@id='nome']
${INPUT_PACIENTE_CPF}         //input[@id='cpf']
${INPUT_PACIENTE_NASCIMENTO}  //input[@id='nascimento']
${INPUT_PACIENTE_TELEFONE}    //input[@id='telefone']
${INPUT_PACIENTE_EMAIL}       //input[@id='email']
${BOTAO_SALVAR_PACIENTE}      //div[contains(@class,'modal-footer')]//button[@type='submit']
${BOTAO_CANCELAR_PACIENTE}    //div[contains(@class,'modal-footer')]//button[contains(.,'Cancelar')]

# Feedback e Alertas
${ALERTA_SUCESSO}             //div[contains(@class,'alert-success')]
${ALERTA_ERRO}                //div[contains(@class,'alert-danger')]
${MSG_VALIDACAO}              //*[contains(@class,'text-danger')][contains(normalize-space(.),'{TEXTO}')]

# Elementos de Listagem
${TABELA_PACIENTES}           //table[contains(@class,'table')]
${LINHA_PACIENTE}             //table[contains(@class,'table')]//tr[contains(.,'{NOME}')]

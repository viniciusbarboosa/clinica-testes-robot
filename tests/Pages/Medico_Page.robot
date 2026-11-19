*** Settings ***
Documentation     Mapeamento de elementos de Login e da página de Médicos (/medicos) - Sistema Viita.
Library           Browser

*** Variables ***
${URL_MEDICOS}                http://187.41.119.192/medicos

# Credenciais de Acesso
${EMAIL_SISTEMA}              sistema@gmail.com
${SENHA_SISTEMA}              \@Sistema123

# Tela de Login (Entrar)
${TITULO_ENTRAR}              role=heading[name=/entrar/i]
${INPUT_EMAIL_LOGIN}          css=input:not([type="hidden"]):not([type="password"]):not([type="checkbox"]):not([type="submit"]) >> nth=0
${INPUT_SENHA_LOGIN}          css=input[type="password"] >> nth=0
${BTN_ENTRAR_LOGIN}           css=:is(button[type="submit"], button:has-text("Entrar"), input[type="submit"]) >> nth=0

# Botões principais da tela de Médicos
${BTN_NOVO_MEDICO}            text=Novo médico >> nth=0
${BTN_SALVAR}                 css=:is(button[type="submit"], button:has-text("Salvar"), button:has-text("Cadastrar")) >> nth=0
${TABELA_MEDICOS}             css=table

# Campos do formulário (ignora a barra "Buscar por nome, CRM ou especialidade")
${INPUT_NOME}                 css=input:not([type="hidden"]):not([type="search"]):not([placeholder*="Buscar" i]) >> nth=0
${INPUT_CRM}                  css=input:not([type="hidden"]):not([type="search"]):not([placeholder*="Buscar" i]) >> nth=1
${CAMPO_ESPECIALIDADE}        css=:is(input:not([type="hidden"]):not([type="search"]):not([placeholder*="Buscar" i]), select) >> nth=2
${INPUT_TELEFONE}             css=input:not([type="hidden"]):not([type="search"]):not([placeholder*="Buscar" i]) >> nth=3

# Modais e Mensagens (nth=-1 seleciona o botão de confirmação dentro do modal)
${BTN_CONFIRMAR_EXCLUSAO}     css=:is(button:has-text("Excluir"), button:has-text("Confirmar"), button:has-text("Apagar"), button:has-text("Sim")) >> nth=-1
${MSG_VALIDACAO}              css=.validation-message, .invalid-feedback, .text-danger, [class*="text-red"]
${ALERTA_ERRO_INTEGRIDADE}    css=:is([role="alert"], .toast-error, .swal2-popup, div:has-text("consulta"), div:has-text("vínculo"), div:has-text("não é possível")) >> nth=0

# CRM de um médico que já tenha consulta vinculada no banco (ex.: 50010 = Gustavo, 50011 = Pedro, 50012 = Mauricio)
${MEDICO_COM_CONSULTA}        50010
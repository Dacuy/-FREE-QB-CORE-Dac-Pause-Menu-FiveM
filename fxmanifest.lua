fx_version 'cerulean'
game 'gta5'

name 'Nombre de tu recurso'
description 'Descripción de tu recurso'
author 'Tu nombre'
version '2.1'

ui_page 'nui/ui/index.html'

files {
    'nui/ui/assets/**.svg',
    'nui/ui/assets/**.wav',
    'nui/ui/index.html',
    'nui/ui/script.js',
    'nui/ui/styles.css'
}

client_script 'client/client.lua'
server_script 'server/server.lua'
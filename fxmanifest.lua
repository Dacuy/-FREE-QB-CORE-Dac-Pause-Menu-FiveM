fx_version 'cerulean'
game 'gta5'

name 'Dac Pause Menu'
description 'qb-core script'
author 'dac_'
version '2.1'

ui_page 'nui/ui/index.html'

files {
    'nui/ui/assets/**.png',
    'nui/ui/assets/**.svg',
    'nui/ui/assets/**.wav',
    'nui/ui/index.html',
    'nui/ui/script.js',
    'nui/ui/styles.css'
}

client_scripts {
    'client/client.lua',
    'config.lua'
}

server_script 'server/server.lua'

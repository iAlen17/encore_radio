fx_version 'adamant'
games      { 'gta5' }

client_scripts {
    'config.lua',
    'client/client.lua',
}

server_scripts {
    'config.lua',
    'server/update.lua',
}

--
-- NUI
--

ui_page 'nui/dist/index.html'

files {
    'nui/dist/index.html',
    'nui/dist/app.css',
    'nui/dist/app.js',

    'nui/dist/img/radio.png',
}

--
-- Dependencies
--

dependencies {
    'tokovoip_script',
}

--
-- About
--

name        "encore_radio"
description "Radio script for TokoVoip."
author      "CharlesHacks#9999"
version     "1.0.0"
license     "MIT"
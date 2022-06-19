fx_version 'adamant'
game 'gta5'

version '1.0.0'
author 'Hugo'
description 'Creation UI'

client_scripts {
    'client/*.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/*.lua',
}

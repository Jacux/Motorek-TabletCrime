fx_version 'cerulean'
games { 'gta5' }
shared_script 'config.lua'
client_script "client.lua"
lua54 'yes'

ui_page "html/index.html"
files {
    'html/index.html',
    'html/script.js',
    'html/style.css'
}

server_scripts {

	'server.lua',
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua'
}


shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/locale.lua'
}
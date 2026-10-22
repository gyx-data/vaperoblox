-- Vape V4 custom : ignore automatiquement les amis Roblox
-- Fork : https://github.com/gyx-data/vaperoblox
--
-- Principe : on ecrit nos 3 fichiers modifies dans le cache de Vape (newvape/)
-- SANS le watermark de suppression, puis on lance le loader officiel. Le loader
-- ne retelecharge un fichier que s'il n'existe pas deja -> il utilise les notres.
-- Nos fichiers survivent aussi aux mises a jour de Vape (le wipe ne touche que
-- les fichiers portant le watermark officiel).

local repo = 'https://raw.githubusercontent.com/gyx-data/vaperoblox/main/compiled/'

-- destination dans le cache  ->  nom du fichier patche dans le repo
local patched = {
	['newvape/libraries/entity.lua'] = 'entity.lua',
	['newvape/games/universal.lua']  = 'universal.lua',
	['newvape/guis/new.lua']         = 'new.lua',
}

for _, folder in {'newvape', 'newvape/libraries', 'newvape/games', 'newvape/guis'} do
	if not isfolder(folder) then
		makefolder(folder)
	end
end

for dest, name in pairs(patched) do
	local ok, res = pcall(function()
		return game:HttpGet(repo .. name, true)
	end)
	if ok and res and res ~= '404: Not Found' then
		writefile(dest, res)
	else
		warn('[VapeCustom] echec telechargement ' .. name .. ' : ' .. tostring(res))
	end
end

-- Lance le loader officiel (il utilisera nos fichiers deja en cache)
return loadstring(game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua', true), 'VapeCustom')()

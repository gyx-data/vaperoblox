-- Vape V4 custom : ignore automatiquement les amis Roblox
-- Fork : https://github.com/gyx-data/vaperoblox
--
-- On ecrit nos 3 fichiers modifies dans le cache de Vape (newvape/) SANS le
-- watermark de suppression, puis on lance le loader officiel. Le loader
-- n'ecrase pas un fichier deja present -> il utilise les notres.
--
-- Les fichiers sont telecharges depuis un COMMIT FIXE (pas la branche) pour
-- eviter tout cache CDN de GitHub qui servirait une vieille version.

local commit = 'fa81e22a5b62fc356fccd6d8334746e98303e51f'
local repo = 'https://raw.githubusercontent.com/gyx-data/vaperoblox/' .. commit .. '/compiled/'

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
		writefile(dest, res) -- writefile ecrase la version eventuellement cassee en cache
	else
		warn('[VapeCustom] echec telechargement ' .. name .. ' : ' .. tostring(res))
	end
end

-- Lance le loader officiel (il utilisera nos fichiers deja en cache)
return loadstring(game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua', true), 'VapeCustom')()

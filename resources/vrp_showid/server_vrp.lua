local lang = vRP.lang
local Luang = module("vrp", "lib/Luang")

local SI = class("SI", vRP.Extension)

function SI:__construct()
	vRP.Extension.__construct(self)
  
	self.cfg = module("vrp_showid", "cfg/cfg")
	
	-- load lang
	self.luang = Luang()
	self.luang:loadLocale(vRP.cfg.lang, module("vrp_showid", "cfg/lang/"..vRP.cfg.lang))
	self.lang = self.luang.lang[vRP.cfg.lang]
	
end

-- EVENT
SI.event = {}

function SI.event:playerSpawn(user, first_spawn)
	if first_spawn then
		local content = ""
		local id = user.cid
		name = content.."<div style="..self.cfg.color..">ID:</div>"
		info = content.."<div style="..self.cfg.id_color..">"..id.."</div>"
		vRP.EXT.GUI.remote._setDiv(user.source,"name",self.cfg.display_css,self.lang.id.name({name}))
		vRP.EXT.GUI.remote._setDiv(user.source,"id",self.cfg.display_css,self.lang.id.my_id({info}))
	end
	
end

vRP:registerExtension(SI)
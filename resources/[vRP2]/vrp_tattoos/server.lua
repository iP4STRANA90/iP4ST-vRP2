--[[
    FiveM Scripts
    Copyright C 2018  Sighmir

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    at your option any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

-- a basic tattooshop implementation
--[[local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPts = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_tattoos")
TSclient = Tunnel.getInterface("vrp_tattoos","vrp_tattoos")
Tunnel.bindInterface("vrp_tattoos",vRPts)

local Lang = module("vrp", "lib/Lang")
local lcfg = module("vrp", "cfg/base")
local lang = Lang.new(module("vrp", "cfg/lang/"..lcfg.lang) or {})]]


local Tattoos = class("Tattoos", vRP.Extension)

function Tattoos:__construct()
  vRP.Extension.__construct(self)

  self.cfg = module("vrp_tattoos", "cfg/tattoos")

  local function m_buy(menu, tatuaj)
    local user = menu.user
    local tattoo = menu.data.tattoos[tatuaj]
    local owned = false
	  if tatuaj == "CLEAR" then-- get player weapons to not rebuy the body
        -- payment
      if user ~= nil and user:tryPayment(tattoo[2]) then
          self.remote._cleanPlayer(user.source)
		      --TriggerEvent("vRP:cloakroom:update", player)
		      vRP:setUData(user.id,"vRP:tattoos",json.encode({}))
          vRP.EXT.Base.remote._notify(user.source,lang.money.paid({tattoo[2]}))
        else
          vRP.EXT.Base.remote._notify(user.source,lang.money.not_enough())
        end
	  else
        -- get player tattoos to not rebuy
      local value = vRP:getUData(user.id,"vRP:tattoos")
        local tattooss = json.decode(value)
        if tattooss ~= nil then
          for k,v in pairs(tattooss) do
            if k == tatuaj then
              owned = true
            end
          end
        end
        if not owned then
          -- payment
              if user:tryPayment(tattoo[2]) then
                addTattoo(user, tatuaj, menu.data.type)
                vRP.EXT.Base.remote._notify(user.source,lang.money.paid({tattoo[2]}))
              else
                vRP.EXT.Base.remote._notify(user.source,lang.money.not_enough())
              end
        else
              vRP.EXT.Base.remote._notify(user.source,"Ya tienes ese tatuaje")
        end
	  end

  end

  vRP.EXT.GUI:registerMenuBuilder("tattoos_main", function(menu)
    local user = menu.user
    menu.title = "Tienda (Tattoos)"
    for k,v in pairs(menu.data.tattoos) do
      if k ~= "_config" then
        menu:addOption(v[1], m_buy, "Este tatuaje cuesta $"..v[2], k)
      end
    end
  end)
end



local tattooshop_menus = {}

function addTattoo(user, tattoo, store)
  local player = user.source
  if player ~= nil then
    vRP.EXT.Tattoos.remote._drawTattoo(player,tattoo,store)
	  local value = vRP:getUData(user.id,"vRP:tattoos")
	  local tattoos = json.decode(value)
	  if tattoos == nil then
	    tattoos = {}
	  end
	  tattoos[tattoo] = store
	  vRP:setUData(user.id,"vRP:tattoos",json.encode(tattoos))
  end
end




Tattoos.event = {}
function Tattoos.event:playerSpawn(user,first_spawn)
  if first_spawn then
    for k,v in pairs(self.cfg.shops) do
      local shop,x,y,z = table.unpack(v)
      local group = self.cfg.tattoos[shop]

      if group then
        local gcfg = group._config

        local function tattooshop_enter(user)
          if user:hasPermissions(gcfg.permissions or {}) then
            menu = user:openMenu("tattoos_main",{type = shop, tattoos = group})
          end
        end

        local function tattooshop_leave(user)
          if menu then
            user:closeMenu(menu)
          end
        end
        local ment = clone(gcfg.map_entity)
        ment[2].title = "Tienda (Tattoos)"
        ment[2].pos = {x,y,z-1}
        vRP.EXT.Map.remote._addEntity(user.source,ment[1], ment[2])

        user:setArea("vRP:tattooshop"..k,x,y,z,1,1.5,tattooshop_enter,tattooshop_leave)
      end
    end
	SetTimeout(5000,function() -- increase this if you have problems with tattoos not saving on login has to be >31000
	  local value = vRP:getUData(user.id,"vRP:tattoos")
	    local tattoos = json.decode(value)
        if tattoos ~= nil then
		  for k,v in pairs(tattoos) do
        vRP.EXT.Tattoos.remote._drawTattoo(user.source,k,v)
		  end
        end
	end)
  else
	SetTimeout(5000,function() -- increase this if you have problems with tattoos not saving after death has to be >16000
	  local value = vRP:getUData(user_id,"vRP:tattoos")
	    local tattoos = json.decode(value)
        if tattoos ~= nil then
		  for k,v in pairs(tattoos) do
        vRP.EXT.Tattoos.remote._drawTattoo(user.source,k,v)
		  end
        end
	end)
  end
end


vRP:registerExtension(Tattoos)
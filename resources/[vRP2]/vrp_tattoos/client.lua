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

Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")


local cvRP = module("vrp", "client/vRP")
vRP = cvRP() 


local Tattoos = class("Tattoos", vRP.Extension)



function Tattoos:cleanPlayer()
	ClearPedDecorations(GetPlayerPed(-1))
end

function Tattoos:drawTattoo(tattoo,tattooshop)
  ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(tattooshop), GetHashKey(tattoo))
end

Tattoos.tunnel = {}
Tattoos.tunnel.cleanPlayer = Tattoos.cleanPlayer
Tattoos.tunnel.drawTattoo = Tattoos.drawTattoo

vRP:registerExtension(Tattoos)
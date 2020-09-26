local lang = vRP.lang
local Luang = module("vrp", "lib/Luang")

local basic_paycheck = class("basic_paycheck", vRP.Extension)

function basic_paycheck:__construct()
	vRP.Extension.__construct(self)
	
	self.cfg = module("vrp_paycheck", "cfg/paycheck")
	
	-- load lang
  self.luang = Luang()
  self.luang:loadLocale(vRP.cfg.lang, module("vrp_paycheck", "cfg/lang/"..vRP.cfg.lang))
  self.lang = self.luang.lang[vRP.cfg.lang]
  
	-- task: mission
	local function task_paycheck()
		SetTimeout(60000*self.cfg.minutes,task_paycheck)
		self:taskPaycheck()
	end
	async(function()
		task_paycheck()
	end)
end

function basic_paycheck:taskPaycheck()
  for perm,paycheck in pairs(self.cfg.paycheck) do
    local users = vRP.EXT.Group:getUsersByPermission(perm)
    for _,user in pairs(users) do
		if self.cfg.bank then
			user:giveBank(paycheck)
		else
			user:giveWallet(paycheck)
		end	
		vRP.EXT.Base.remote._notify(user.source,self.lang.money.salary({paycheck}))
	end	
  end
end

vRP:registerExtension(basic_paycheck)

local cfg = {}

cfg.bank = true 		-- if true money goes to bank, false goes to wallet

cfg.minutes = 2		-- minutes between payment for paycheck

cfg.paycheck = { -- ["permission"] = paycheck
	["police.paycheck"] = 3000
  --["jobName.paycheck"] = paycheckAmount
}

return cfg

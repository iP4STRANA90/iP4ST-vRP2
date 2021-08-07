
local cfg = {}

-- define static transformers
-- see https://github.com/ImagicTheCat/vRP modules documentation to understand the transformer concept/definition

cfg.transformers = {
  {
    -- example transformers
    title="Body training", -- menu name
    color={255,125,0}, -- color
    max_units=1000,
    units_per_minute=1000,
    position={-1202.96252441406,-1566.14086914063,4.61040639877319},
    radius=7.5, height=1.5, -- area
    recipes = {
      ["Strength"] = { -- action name
        description="Increase your strength.", -- action description
        reagents={}, 
        products={
          aptitudes={ 
            ["physical.strength"] = 1 -- "group.aptitude", give 1 exp per unit
          }
        },
      }
    }
  }
}

return cfg

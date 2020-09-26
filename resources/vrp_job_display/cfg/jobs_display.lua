
local cfg = {}

cfg.firstjob = "citizen"
cfg.showjob = true



cfg.job = [[
.div_job{
  position: absolute;
  top: 100px;
  right: 30px;
  font-size: 30px;
  font-family: pricedown !important;
  src: url(nui://vrp/gui/font/pricedown.ttf);  
  color: white;
  text-shadow: rgb(0, 0, 0) 1px 0px 0px, rgb(0, 0, 0) 0.533333px 0.833333px 0px, rgb(0, 0, 0) -0.416667px 0.916667px 0px, rgb(0, 0, 0) -0.983333px 0.133333px 0px, rgb(0, 0, 0) -0.65px -0.75px 0px, rgb(0, 0, 0) 0.283333px -0.966667px 0px, rgb(0, 0, 0) 0.966667px -0.283333px 0px;
}
]]



cfg.permissions = {
  ["admin_display"] = { --permissions for admins
  text = "Admin",
  css = [[
  .div_admin_display{
  position: absolute;
  top: 320px;
  right: 10px;
  font-size: 35px;
  font-family: pricedown !important;
  src: url(nui://vrp/gui/font/pricedown.ttf);  
  color: white;
  text-shadow: black 0 0 10px;
      }
    ]],
  },
  ["staff_display"] = { --permissions for staff
  text = "Staff",
  css = [[
  .div_staff_display{
  position: absolute;
  top: 320px;
  right: 10px;
  font-size: 35px;
  font-family: pricedown !important;
  src: url(nui://vrp/gui/font/pricedown.ttf);  
  color: white;
  text-shadow: black 0 0 10px;
      }
    ]], 
  },

  ["civ_display"] = { --permissions for staff
  text = "Citizen",
  css = [[
  .div_civ_display{
  position: absolute;
  top: 320px;
  right: 10px;
  font-size: 35px;
  font-family: pricedown !important;
  src: url(nui://vrp/gui/font/pricedown.ttf);  
  color: white;
  text-shadow: black 0 0 10px;
      }
    ]], 
  },  
  
}


return cfg


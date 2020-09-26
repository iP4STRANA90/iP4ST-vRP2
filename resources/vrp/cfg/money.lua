
local cfg = {}

-- start wallet/bank values
cfg.open_wallet = 150
cfg.open_bank = 1000

cfg.lose_wallet_on_death = true

cfg.money_display = true

-- money display css
cfg.display_css = [[
.div_money{
  position: absolute;
  top: 10px;
  right: 30px;
  font-size: 30px;
  font-family: pricedown !important;
  src: url(nui://vrp/gui/font/pricedown.ttf);  
  color: white;
  text-shadow: rgb(0, 0, 0) 1px 0px 0px, rgb(0, 0, 0) 0.533333px 0.833333px 0px, rgb(0, 0, 0) -0.416667px 0.916667px 0px, rgb(0, 0, 0) -0.983333px 0.133333px 0px, rgb(0, 0, 0) -0.65px -0.75px 0px, rgb(0, 0, 0) 0.283333px -0.966667px 0px, rgb(0, 0, 0) 0.966667px -0.283333px 0px;
}
.div_money .symbol{
  padding-right: 10px;
  content: url('https://i.imgur.com/CpUJ2PN.png');
}

.div_bmoney{
  position: absolute;
  top: 40px;
  right: 30px;
  font-size: 30px;
  font-family: pricedown !important;
  src: url(nui://vrp/gui/font/pricedown.ttf);  
  color: white;
  text-shadow: rgb(0, 0, 0) 1px 0px 0px, rgb(0, 0, 0) 0.533333px 0.833333px 0px, rgb(0, 0, 0) -0.416667px 0.916667px 0px, rgb(0, 0, 0) -0.983333px 0.133333px 0px, rgb(0, 0, 0) -0.65px -0.75px 0px, rgb(0, 0, 0) 0.283333px -0.966667px 0px, rgb(0, 0, 0) 0.966667px -0.283333px 0px;
}
.div_bmoney .symbol{
  padding-right: 10px;
  content: url('https://i.imgur.com/LUVkO85.png');
}
]]

return cfg


local cfg = {}
-- define garage types with their associated vehicles
-- (vehicle list: https://wiki.fivem.net/wiki/Vehicles)

cfg.rent_factor = 0.1 -- 10% of the original price if a rent
cfg.sell_factor = 0.45 -- sell for 75% of the original price

cfg.force_out_fee = 1000 -- amount of money (fee) to force re-spawn an already out vehicle

-- default chest weight for vehicle trunks
cfg.default_vehicle_chest_weight = 50

cfg.vehicle_update_interval = 15 -- seconds
cfg.vehicle_check_interval = 15 -- seconds, re-own/respawn task
cfg.vehicle_respawn_radius = 150 -- radius for the out vehicle respawn feature

-- define vehicle chest weight by model in lower case
cfg.vehicle_chest_weights = {
  ["tanker"] = 5000
}

-- each garage type is a map of veh_name => {title, price, description}
-- _config: map_entity, permissions (optional, only users with the permissions will have access to the shop)
--- map_entity: {ent,cfg} will fill cfg.title, cfg.pos
cfg.garage_types = {
  ["compacts"]  = {
    _config = {map_entity = {"PoI", {blip_id = 50, blip_color = 4, marker_id = 1}}},
    ["blista"] = {"Blista", 15000, ""},
    ["brioso"] = {"Brioso R/A", 15500, ""},
    ["dilettante"] = {"Dilettante", 25000, ""},
    ["issi2"] = {"Issi", 18000, ""},
    ["panto"] = {"Panto", 85000, ""},
    ["prairie"] = {"Prairie", 30000, ""},
    ["rhapsody"] = {"Rhapsody", 120000, ""}
  },
  ["bicycles"] = {
    _config = {map_entity = {"PoI", {blip_id = 376, blip_color = 4, marker_id = 1}}},
    ["tribike"] = {"Tribike", 250, ""},
    ["BMX"] = {"BMX", 450, ""}
  },
  ["taxi"] = {
    _config = {map_entity = {"PoI", {blip_id = 56, blip_color = 5, marker_id = 1}}, permissions = {"taxi.vehicle"} },
    ["taxi"] = {"Taxi",1000,""}
  },
  ["police"] = {
    _config = {map_entity = {"PoI", {blip_id = 50, blip_color = 38, marker_id = 1}}, permissions = {"police.vehicle"} },
    ["police"] = {"Basic",1000,"Basic model."},
    ["police3"] = {"Classic",1000,"Sport model."},
    ["police2"] = {"Furtive",1000,"Furtive model."}
  },
  ["emergency"] = {
    _config = {map_entity = {"PoI", {blip_id = 61, blip_color = 3, marker_id = 1}}, permissions = {"emergency.vehicle"} },
    ["ambulance"] = {"Basic",1000,""}
  }
}

-- {garage_type,x,y,z}
cfg.garages = {
  {"compacts",-356.146, -134.69, 39.0097},
  {"bicycles",-352.038482666016,-109.240043640137,38.6970825195313},
  {"taxi",-286.870056152344,-917.948181152344,31.080623626709},
  {"police",454.4,-1017.6,28.4},
  {"emergency",-492.08544921875,-336.749206542969,34.3731842041016}
}

return cfg

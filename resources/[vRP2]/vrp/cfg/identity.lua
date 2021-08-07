
local cfg = {}

-- city hall position
cfg.city_hall = {-546.12933349609,-205.25981140137,38.215141296387}

-- {ent,cfg} will fill cfg.title, cfg.pos
cfg.city_hall_map_entity = {"PoI", {blip_id = 181, blip_color = 4, marker_id = 1, color = {0,255,125,125}}}

-- cost of a new identity
cfg.new_identity_cost = 100

-- phone format (max: 20 chars, use D for a random digit)
cfg.phone_format = "662-DDDDDD"
-- cfg.phone_format = "06DDDDDDDD" -- another example for cellphone in France


-- config the random name generation (first join identity)
-- (I know, it's a lot of names for a little feature)
-- (cf: http://names.mongabay.com/most_common_surnames.htm)
cfg.random_first_names = {
  "Chema"
}

cfg.random_last_names = {
  "Vega"
}

return cfg

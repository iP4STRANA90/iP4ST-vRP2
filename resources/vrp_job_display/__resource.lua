resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description "jobs_display_vrp2"

dependency "vrp"

server_scripts{ 
  "@vrp/lib/utils.lua",
  "vrp.lua"
}


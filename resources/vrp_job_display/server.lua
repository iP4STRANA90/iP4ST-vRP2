

local cfg = module("vrp_job_display", "cfg/jobs_display")


local JobsDisplay = class("JobsDisplay", vRP.Extension)


JobsDisplay.event = {}


function JobsDisplay.event:playerSpawn(user, first_spawn)
    if first_spawn then
        SetTimeout(20100, function()
            local job = user:getGroupByType("job")
            job = vRP.EXT.Group:getGroupTitle(job)
            if (job == nil or job == "") and cfg.firstjob then
                user:addGroup(cfg.firstjob)
            end
				local job = user:getGroupByType("job")
				job = vRP.EXT.Group:getGroupTitle(job)
                vRP.EXT.GUI.remote._setDiv(user.source, "job", cfg.job, "<span id='icon'></span>" .. job)
				
			for permissions,gcfg in pairs(cfg.permissions) do
				if user:hasPermission(permissions) then
				vRP.EXT.GUI.remote._setDiv(user.source,permissions, gcfg.css,"<span id='icon'></span>"..gcfg.text)
				end
			end			
        end)
    end
end

function JobsDisplay.event:playerJoinGroup(user, group, gtype)


  if gtype == "job" then
  	local job = user:getGroupByType("job")
	job = vRP.EXT.Group:getGroupTitle(job)
    vRP.EXT.GUI.remote._setDiv(user.source,"job",cfg.job,"<span id='icon'></span>"..job)
  end
  for permissions,gcfg in pairs(cfg.permissions) do 
    if user:hasPermission(permissions) then
      vRP.EXT.GUI.remote._setDiv(user.source, permissions, gcfg.css,"<span id='icon'></span>"..gcfg.text)
	else
	  vRP.EXT.GUI.remote._removeDiv(user.source, permissions)
    end
  end
end

function JobsDisplay.event:playerLeaveGroup(user, group, gtype)

  if gtype == "job" then
  vRP.EXT.GUI.remote._removeDiv(user.source,"job")
    end
  for permissions,gcfg in pairs(cfg.permissions) do 
    if not user:hasPermission(permissions) then
  vRP.EXT.GUI.remote._removeDiv(user.source,permissions)
      end
  end
end



vRP:registerExtension(JobsDisplay)


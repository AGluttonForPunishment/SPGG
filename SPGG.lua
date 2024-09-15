-- Simple Persistent Ground Groups (SPGG)
-- By A Glutton For Punishment (aka Kanelbolle)

env.info('-- SPGG v026 : Loading!')
spgg = spgg or {} -- do not remove

-- todo: Add livery defaults for units!

------------------
-- Settings :	--
------------------



--------------------------------------------------------------------------------------------------------------
-- DO NOT CHANGE the "spgg.loadDir" IF YOU DON'T WANT TO CHANGE THE DEFAULT PATH FOR THE SAVE FILE!!! 	--
-- MOST CASES CHANGING THIS IS NOT NEEDED SINCE IT SAVES THE FILE IN THE SERVER INSTANC PROFILE PATH!!		--
--------------------------------------------------------------------------------------------------------------

-- This parameter is used to determine where the SPGG save file is placed.
-- "lfs.writedir()" is the same as : <your dcs profile path>\ 
--
-- The code “lfs.writedir()” will always get the current DCS profile your server or game is using.
-- If you run multiple instances of DCS servers, you do not need to change this line! It will find the path to the server's profile!
--
-- Example Locations:
-- The line below is Example: <your dcs profile path>\Missions\SPGG\
-- spgg.loadDir = lfs.writedir() .. [[Missions\SPGG\]]
--
-- 
--
-- The line below is Example to point the script folder to : C:\MyScripts\DCS\SPGG\
-- (We have here removed "lfs.writedir()" to get the direct path)
--
-- spgg.loadDir = [[C:\MyScripts\DCS\SPGG\]]
-- 
--
-- The line below is : <your dcs profile path>\Scripts\
spgg.loadDir = lfs.writedir() .. [[Scripts\]]

-- Save filename
spgg.saveFilename = "SPGG_savefile.lua"

-- Combine above path and file
spgg.saveFilePath = spgg.loadDir .. spgg.saveFilename

-- Writing the path to the save file used above to dcs.log
env.info('-- SPGG : SAVE Dir: ' .. spgg.saveFilePath)


-- Backup folder name (Folder must be crated if it does not exist)
-- Uses the spgg.loadDir as a starting path 
spgg.backupSaveDirName = "SPGG-Backup-Saves\\" -- must have \\ between every folder level\sub-folder


-- Saves backup files of your save at the "spgg.backupSaveDirName" directory!
-- (Folder must be crated if it does not exist)
-- Uses the spgg.loadDir as a starting path 
spgg.enableBackupSaves = false


-- Save loop in min
spgg.Savetime = 30

-- Reuse GroupNames from save file
-- (If names exist the group will overwrite the existing unit, recommended to be false if mission is not designed for this)
spgg.ReuseGroupNames = true

-- Reuse Unit Names from save file
-- (If names exist the unit will overwrite or not spawn, recommended to be false if mission is not designed for this)
spgg.ReuseUnitNames = true


-- Reuse Unit and Group ID from save file (Overrides "spgg.useMIST" unit and group ID assignment)
-- (If id's exist the group will overwrite or not spawn, recommended to be false if mission is not designed for this.
-- Also enables Datalink for ground units when they spawn)
-- WARNING : Do not turn on if you have a old save file. Start the mission first with "false", let spgg save. Then change this to "true"
spgg.ReuseID = true

-- If you don't want to use "MIST" you can disable it here. (The MIST version of CTLD will not work without MIST)
-- MIST is only used for the mist.getNextGroupId() & mist.getNextUnitId() functions in the script (MIST unit Table).
-- If this option is false, DCS will controle what ID's are used.
-- Hardcoded groupid's and unitid's in other scripts might cause problems. (check that this is not the case)
-- Datalink for ground units is off if this is false (the script does not know what GroupID to assigne it to)
spgg.useMIST = false


-- If "true", only the Ground groups and Sea groups that are active in the Mission are saved. (Static objects does not support this)
spgg.saveOnlyActiveGroups = true

-- If "true", the units will spawn back with the same "Late Activated" state as when they where saved.
-- (See spgg.saveOnlyActiveGroups if you want to save Inactive groups)
spgg.spawnGroupsAsSavedLateActivatedState = false

-- If "true", all units spawn as "Late Activated". (Mission maker has to make custom activation code. See spgg.saveOnlyActiveGroups if you want to save Inactive groups)
-- (Static Objects does not support this in DCS)
-- Overrides "spgg.spawnGroupsAsSavedLateActivatedState" !!!
spgg.spawnAllGroupsAsInactive = false

-- If "true", all units spawn as visible when "Late Activated" is on (Only active if spgg.spawnAllGroupsAsInactive or spgg.spawnGroupsAsSavedLateActivatedState is true)
spgg.spawnVisibleInactive = false

-- Set "true" if you want to save CTLD crates that are on the spaned in to the world. Will spawn with static objects spawning commands.
spgg.saveCtldCrates = false

-- Don't show Message box in DCS. Use logg file insted. (spgg.showEnvinfo)
env.setErrorMessageBoxEnabled(false)

-- For debugging
spgg.showEnvinfo = false	




-- All groups names beginning with strings in this array will be excluded from saveing.
-- Example a group placed in the mission editor or spawned by scripts with the name "AF_TestGroup-1" will not be saved!
spgg.excludeGroupNameTbl = {
"AF_",
"StandAlone_",
"SA_Convoy_",
"Clone_",
"Build_",

}

-- All Static Objects with type names in this array will be included when saveing. (Not all types objects are able to be saved!)
-- See list of types here: https://github.com/mrSkortch/DCS-miscScripts/tree/master/ObjectDB
spgg.includeStaticObjectTypeTbl = {
"outpost",
"house2arm",
"WindTurbine"

}


-- Select what type of livery/paint/camoflage is used when spawning ground units.
-- DCS does not allow checking livery of units by script, so you can set the type you want in your mission when spawning from a save file here.

-- Liverys:

-- Type 0 is default.
-- Type 1 is desert 
-- Type 2 is winter
spgg.liveryType = 0


spgg.defaultBlueLiveryDesert = "desert"
spgg.defaultBlueLiveryWinter = "winter"

spgg.defaultRedLiveryDesert = "desert"
spgg.defaultRedLiveryWinter = "RUS_winter"

spgg.defaultNeutralLiveryDesert = "desert"
spgg.defaultNeutralLiveryWinter = "winter"


--------------------------
-- Special livery names --
--------------------------


spgg.groundUnitLivery = {}


-- You can add more special livery or change the current.
-- Errors in syntax will brake the script!


-- Red

spgg.groundUnitLivery["S-200_Launcher"] =
{
	[1] = {
		["livery_id"] = "desert_summer",
	},
	[2] = {
		["livery_id"] = "green_winter",
	},
}

spgg.groundUnitLivery["RPC_5N62V"] =
{
	[1] = {
		["livery_id"] = "desert_summer",
	},
	[2] = {
		["livery_id"] = "green_winter",
	},
}

spgg.groundUnitLivery["ZBD04A"] =
{
	[1] = {
		["livery_id"] = "generic desert",
	},
	[2] = {
		["livery_id"] = "RUS_winter",
	},
}


spgg.groundUnitLivery["ZU-23 Emplacement Closed"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "GRC_winter",
	},
}

spgg.groundUnitLivery["ZU-23 Emplacement"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "GRC_winter",
	},
}

spgg.groundUnitLivery["S-300PS 64H6E sr"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "GRC_winter",
	},
}

spgg.groundUnitLivery["S-300PS 54K6 cp"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "GRC_winter",
	},
}

spgg.groundUnitLivery["S-300PS 40B6M tr"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "GRC_winter",
	},
}

spgg.groundUnitLivery["S-300PS 5P85D ln"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "GRC_winter",
	},
}

spgg.groundUnitLivery["S-300PS 5P85C ln"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "GRC_winter",
	},
}

spgg.groundUnitLivery["S-300PS 40B6MD sr"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "GRC_winter",
	},
}

spgg.groundUnitLivery["SNR_75V"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "winter",
	},
}

spgg.groundUnitLivery["S_75M_Volhov"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "winter",
	},
}

spgg.groundUnitLivery["p-19 s-125 sr"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "winter",
	},
}

spgg.groundUnitLivery["Kub 2P25 ln"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "winter",
	},
}

spgg.groundUnitLivery["Kub 1S91 str"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "winter",
	},
}

spgg.groundUnitLivery["Osa 9A33 ln"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "grc_winter",
	},
}

spgg.groundUnitLivery["Strela-1 9P31"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "winter",
	},
}

spgg.groundUnitLivery["ZSU-23-4 Shilka"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "winter",
	},
}

spgg.groundUnitLivery["ZSU_57_2"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "winter",
	},
}

spgg.groundUnitLivery["BTR-80"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "winter",
	},
}

spgg.groundUnitLivery["BTR_D"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "winter",
	},
}

spgg.groundUnitLivery["BTR-82A"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "green winter",
	},
}

spgg.groundUnitLivery["2B11 mortar"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "winter",
	},
}



-- Blue


spgg.groundUnitLivery["Stinger comm"] =
{
	[1] = {
		["livery_id"] = "multicam",
	},
	[2] = {
		["livery_id"] = "winter",
	},
}

spgg.groundUnitLivery["Soldier stinger"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "digital_grey",
	},
}

spgg.groundUnitLivery["Patriot cp"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "GRC_winter",
	},
}

spgg.groundUnitLivery["Patriot AMG"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "GRC_winter",
	},
}

spgg.groundUnitLivery["Patriot ECS"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "GRC_winter",
	},
}

spgg.groundUnitLivery["Patriot EPP"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "GRC_winter",
	},
}

spgg.groundUnitLivery["Patriot ln"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "GRC_winter",
	},
}

spgg.groundUnitLivery["Patriot str"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "GRC_winter",
	},
}

spgg.groundUnitLivery["Vulcan"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "USA_winter",
	},
}

spgg.groundUnitLivery["M48 Chaparral"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "USA_winter",
	},
}

spgg.groundUnitLivery["M48 Chaparral"] =
{
	[1] = {
		["livery_id"] = "desert",
	},
	[2] = {
		["livery_id"] = "USA_winter",
	},
}





-----------------------------------
-- DO NOT EDIT BELOW THIS LINE!! --
-----------------------------------



-- Backup Path string
spgg.backupPath = spgg.loadDir .. spgg.backupSaveDirName

-- make shure the value exist!
spgg.initalstart = true
trigger.action.setUserFlag("spgginitalstart" , true )

function spgg.filenameexist(filename)
   local f=io.open(filename,"r")
   if f~=nil then io.close(f) return true else return false end
end



-- Load Saved Groups data to prepare for spawning
if spgg.filenameexist(spgg.saveFilePath) then
	env.info('-- SPGG : Loading Save file : ' .. spgg.saveFilePath)
	assert(loadfile(spgg.saveFilePath))()
else
	env.info('-- SPGG : Loading Save file : NO SAVE FILE LOCATED AT: ' .. spgg.saveFilePath)
end


-- Check if persistent mission start (Loading previus groups) or initial start of the mission
-- This is a flag and a parameter users can use to detirmen if SPGG loads a save file or the file is empty.
-- FLAG or parameter can example be used for the mission maker to determine if example units should only spawn if lua parameter "spgg.initalstart == true" or the flag "spgginitalstart = true"
-- Se included .miz file for example how to do this.
if (spgg.initalstart ~= nil) then

	if (spgg.initalstart == true) then
	
		trigger.action.setUserFlag("spgginitalstart" , true )
		env.info('-- SPGG : spgg.initalstart was TRUE, this is the missions first start and not a persistent save!')
	
	else
	
		trigger.action.setUserFlag("spgginitalstart" , false )
		env.info('-- SPGG : spgg.initalstart was FALSE, this is a persisten session of the mission!')
	
	end -- of if (spgg.initalstart == true) then
	
else

	-- Parameter was nil, then this is the initial start of the mission
	spgg.initalstart = true
	trigger.action.setUserFlag("spgginitalstart" , true )
	env.info('-- SPGG : spgg.initalstart was nil, this is the missions first start and not a persistent save!')
	
end -- of if (spgg.initalstart ~= nil) then





if (spgg.saveCtldCrates == true) then

	if (ctld ~= nil) then
	
		if ctld.slingLoad then
           table.insert(spgg.includeStaticObjectTypeTbl, ctld.spawnableCratesModel_sling.type)
		   env.info('-- SPGG : spgg.saveCtldCrates = true : Type: ' .. ctld.spawnableCratesModel_sling.type)
        else
           table.insert(spgg.includeStaticObjectTypeTbl, ctld.spawnableCratesModel_load.type)
		   env.info('-- SPGG : spgg.saveCtldCrates = true : Type: ' .. ctld.spawnableCratesModel_load.type)
        end
				
	end

end






-----------------------------------
-- LOAD FUNCTIONS --
-----------------------------------




env.info('-- SPGG :  Loading Function for Loading Groups!')



spgg.tblPrevSamSystems = {}

spgg.noMistCountGrp = 0
spgg.noMistCountUnit = 0





-- gpUnitSize , _unitType, _unitCoord.x, _unitCoord.z, _unitHdg, _uCountry
function spgg.spawnBlueGroundGroup()


	--env.info("-- Running SpawnBlueGroundGroup!")
	
	--local _coaId = 2
	env.info('-- SPGG :  Coalition BLUE : Spawning Ground Forces')
	
	if (spgg ~= nil) and (spgg.bluegroups ~= nil) then	

		for spwnGpIdx = 1, #spgg.bluegroups do

			spgg.noMistCountGrp = spgg.noMistCountGrp + 1 
			
			local _isJtacAdd = false
			local _ctldjtacGroupName = ""
			local _ctldjtacUnit = ""
			local _groupId = 0
			
			
			if (spgg.useMIST == true) and (mist ~= nil) then 
				_groupId = mist.getNextGroupId()
			end
			
			
			
			local newUnitName = ""
			local newGroupName = ""
	
			local _prevGroupName = spgg.bluegroups[spwnGpIdx].groupname or nil
			local _loadGrpName = ""
	
			if (spgg.ReuseGroupNames == true) then
				_loadGrpName = _prevGroupName
			else
			
				if (spgg.useMIST == true) and (mist ~= nil) then 
					_loadGrpName = "BlueAiGroundGroup".. _groupId
				else
					_loadGrpName = "BlueAiGroundGroupNM" .. spgg.noMistCountGrp
				end -- of if (spgg.useMIST == true) and (mist ~= nil) then
				
			end -- of if (spgg.ReuseGroupNames == true) then
		

			local _data = {

								["visible"] = false,
                                ["tasks"] = 
                                {
                                }, -- end of ["tasks"]
                                ["uncontrollable"] = false,
                                ["task"] = "Ground Nothing",
                                ["taskSelected"] = true,
                                
								["route"] =
								{
								
								},
								
                                --["groupId"] = _groupId,
                                ["hidden"] = false,
                                ["units"] = 
                                {
                                   								
							
								}, -- end of ["units"]
                            --["y"] = _uCoordZ1,
                            --["x"] = _uCoordX1,
                            ["name"] = _loadGrpName,
                            ["start_time"] = 0,
			} -- end of data

			if (spgg.useMIST == true) and (mist ~= nil) then 
		
				_data["groupId"] = _groupId
				--env.info('-- groupId with MIST: ' .. data.groupId)
		
			end
			
			if (spgg.ReuseID == true) and (spgg.bluegroups[spwnGpIdx].groupid ~= nil) then 
		
				_data["groupId"] = spgg.bluegroups[spwnGpIdx].groupid
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG : bluegroups groupId with ReuseID : ' .. _data.groupId)
				end
			end
			
			
			if (spgg.spawnGroupsAsSavedLateActivatedState == true) then
				
				if (spgg.bluegroups[spwnGpIdx].lateActivation ~= nil) then 
					
					local _lateActivation = spgg.bluegroups[spwnGpIdx].lateActivation
					
					if (_lateActivation == 1) then
						_data["lateActivation"] = true
						
						if (spgg.spawnVisibleInactive == true) then
							_data["visible"] = true
						end
						
					else
						
						_data["lateActivation"] = false
					end -- if (_lateActivation == 1) then
					
				end -- of if (spgg.bluegroups[spwnGpIdx].lateActivation ~= nil) then
				
			end -- if (spgg.spawnGroupsAsSavedLateActivatedState == true) then
			
			
			
			-- Overrides spgg.spawnGroupsAsSavedLateActivatedState
			if (spgg.spawnAllGroupsAsInactive == true) then
				
				_data["lateActivation"] = true
				
				if (spgg.spawnVisibleInactive == true) then
					_data["visible"] = true
				end
				
			end
			


		if (spgg.showEnvinfo == true) then
			local _Msg = spgg.bluegroups[spwnGpIdx].units[1].type
			env.info("-- SPGG :  Loading Blue groups - Unit type : " .._Msg)
		end

					
		
					
			for spwnUnitIdx = 1, #spgg.bluegroups[spwnGpIdx].units do
                       

				spgg.noMistCountUnit = spgg.noMistCountUnit + 1
				local _unitId = 0
				
				if (spgg.useMIST == true) and (spgg.bluegroups[spwnGpIdx].units[spwnUnitIdx].unitid ~= nil) then
					
					_unitId 		= mist.getNextUnitId()
				end
				
				if (spgg.ReuseID == true) and (spgg.bluegroups[spwnGpIdx].units[spwnUnitIdx].unitid ~= nil) then
				 
					_unitId 		= spgg.bluegroups[spwnGpIdx].units[spwnUnitIdx].unitid
					if (spgg.showEnvinfo == true) then
						env.info('-- SPGG :  bluegroups unitId with ReuseID : ' .. spgg.bluegroups[spwnGpIdx].units[spwnUnitIdx].unitid)
					end
				end
			
				local _uType		= spgg.bluegroups[spwnGpIdx].units[spwnUnitIdx].type or ''
				local _uName		= spgg.bluegroups[spwnGpIdx].units[spwnUnitIdx].name or ''
				local _uskill		= spgg.bluegroups[spwnGpIdx].units[spwnUnitIdx].skill or ''
				local _uCoordX		= spgg.bluegroups[spwnGpIdx].units[spwnUnitIdx].x or 0
				local _uCoordY		= spgg.bluegroups[spwnGpIdx].units[spwnUnitIdx].y or 0
				local _uHdg			= spgg.bluegroups[spwnGpIdx].units[spwnUnitIdx].heading or 0
				_uCountry		= spgg.bluegroups[spwnGpIdx].units[spwnUnitIdx].country or 80
				_uPrevName		= spgg.bluegroups[spwnGpIdx].units[spwnUnitIdx].name or ''
			

				_data.route = {
			
					["spans"] = 
					{
					}, -- end of ["spans"]
					["points"] = 
					{
						[1] = 
						{
							["alt"] = 59,
							["type"] = "Turning Point",
							["ETA"] = 0,
							["alt_type"] = "BARO",
							["formation_template"] = "",
							["y"] = _uCoordY,
							["x"] = _uCoordX,
							["ETA_locked"] = true,
							["speed"] = 0,
							["action"] = "Off Road",
							["task"] = 
							{
							["id"] = "ComboTask",
							["params"] = 
							{
							-- params (EPLRS) needs to know the spawning groups GroupID. Will be added only if MIST is active.
								
							}, -- end of ["params"]
						}, -- end of ["task"]
							["speed_locked"] = true,
						}, -- end of [1]
					}, -- end of ["points"]
	
				}


				if ((spgg.useMIST == true) and (mist ~= nil)) or ((spgg.ReuseID == true) and (spgg.bluegroups[spwnGpIdx].units[spwnUnitIdx].unitid ~= nil)) then
				
					--Since we know the groupID, we can enable EPLRS (datalink) for the group
					_data.route.points[1].params = {
					
						["tasks"] = 
								{
									[1] = 
									{
										["number"] = 1,
										["auto"] = true,
										["id"] = "WrappedAction",
										["enabled"] = true,
										["params"] = 
										{
											["action"] = 
											{
												["id"] = "EPLRS",
												["params"] = 
												{
													["value"] = true,
													["groupId"] = _groupId,
												}, -- end of ["params"]
											}, -- end of ["action"]
										}, -- end of ["params"]
									}, -- end of [1]
						}, -- end of ["tasks"]
							
					
					
					} -- end of data.route.points[1].params = {
		

					--env.info('-- GroupID with MIST: ' .. data.route.points[1].params.tasks[1].params.action.params.groupId)
					--env.info('-- EPLRS groupId with MIST: ' .. data.route.points[1].params.tasks[1].params.action.id )
				
				end -- of if (spgg.useMIST == true) and (mist ~= nil) then


				newGroupName = _loadGrpName
				--newUnitName = "BlueAiGroundUnit".. _unitId
				
				
				
				if (spgg.ReuseUnitNames == true) then
					newUnitName = _uName
				else
				
					if (spgg.useMIST == true) and (mist ~= nil) then 
						newUnitName = "BlueAiGroundUnit".. _unitId
					else
						newUnitName = "BlueAiGroundUnitNM".. spgg.noMistCountUnit
						--env.info("-- Blue Unit Name:  " .. newUnitName)
					end -- of if (spgg.useMIST == true) and (mist ~= nil) then
					
				end -- of if (spgg.ReuseUnitNames == true) then


				--env.info("-- Blue Group Name:  " .. newGroupName)
				
				
				_data.units[spwnUnitIdx] = {
			
					["type"] = _uType,
					--["unitId"] = _unitId,
					["skill"] = _uskill,
					["y"] = _uCoordY,
					["x"] = _uCoordX,
					["name"] = newUnitName,
					["heading"] = _uHdg,
					["playerCanDrive"] = true,
			
				}
			
			
				--data["name"] = _loadGrpName
				
				if (spgg.useMIST == true) and (mist ~= nil) then
					_data.units[spwnUnitIdx]["unitId"] = _unitId
					--env.info('-- UnitID with MIST: ' .. data.units[spwnUnitIdx].unitId)
					
				end -- of if (spgg.useMIST == true) and (mist ~= nil) then
				
				if (spgg.ReuseID == true) and (spgg.bluegroups[spwnGpIdx].units[spwnUnitIdx].unitid ~= nil) then
				 
					_data.units[spwnUnitIdx]["unitId"] = _unitId
					if (spgg.showEnvinfo == true) then
						env.info('-- SPGG :  bluegroups unitid with ReuseID : ' .. _unitId)
					end
				end
				
				
				
				if (spgg.liveryType) and (spgg.liveryType ~= 0) then
				
					if (spgg.groundUnitLivery[_uType]) then
						_data.units[spwnUnitIdx]["livery_id"] = spgg.groundUnitLivery[_uType][spgg.liveryType].livery_id
						env.info('-- SPGG : Unit Type: '.._uType .. ' - livery_id: ' .. spgg.groundUnitLivery[_uType][spgg.liveryType].livery_id)
					else
					
									
						if (spgg.liveryType == 1) then
							_data.units[spwnUnitIdx]["livery_id"] = spgg.defaultBlueLiveryDesert
						
						
						elseif (spgg.liveryType == 2) then
							_data.units[spwnUnitIdx]["livery_id"] = spgg.defaultBlueLiveryWinter
					
						--env.info('-- SPGG :  Unit type not found in spgg.groundUnitLivery,using default type for what was selected!')
						end
						
					end
					
				end -- of if (spgg.liveryType) and (spgg.liveryType ~= 0) then
			
				

				if (ctld ~= nil) then
					-- Borrowed from CTLD (Combat Troop and Logistics Drop) for integration of JTAC in save - See https://github.com/ciribob/DCS-CTLD 
					if (ctld.isJTACUnitType ~= nil) and (ctld.JTAC_dropEnabled ~= nil) and (ctld.jtacGeneratedLaserCodes ~= nil) then
				
						if ctld.isJTACUnitType(_uType) and ctld.JTAC_dropEnabled then

							_isJtacAdd = true
							_ctldjtacGroupName = _loadGrpName
							_ctldjtacUnitName =	newUnitName
						
						end -- of if ctld.isJTACUnitType(_uType) and ctld.JTAC_dropEnabled then
			
					end -- of if (ctld.isJTACUnitType ~= nil) and (ctld.JTAC_dropEnabled ~= nil) and (ctld.jtacGeneratedLaserCodes ~= nil) then


			
					if (spgg.showEnvinfo == true) then
					
						if (spgg.useMIST == true) and (mist ~= nil) then 
							env.info("-- SPGG :  Load Blue groups Unit type : " .. _uType .. " - Index : " .. spwnUnitIdx .. " - GroupID : " .. _groupId .. " - unitID : " .. _unitId)
						else
							env.info("-- SPGG :  Load Blue groups Unit type without MIST : " .. _uType .. " - Index : " .. spwnUnitIdx .. " - GroupID : Unknown" .. " - unitID : Unknown")
						end
						
					end -- of if (spgg.showEnvinfo == true) then



					if (spgg.completeAASystems ~= nil)  then
						
						if (spgg.showEnvinfo == true) then
							env.info("-- SPGG :  running spgg.completeAASystems check for :  " .. newGroupName)
						end

						for _groupName, _hawkDetails in pairs(spgg.completeAASystems) do
				
							if (_prevGroupName ~= nil) then
						

								local _grpName = _loadGrpName
								local _unitName = newUnitName
						
								local _systemName = _hawkDetails[1].system

								if (_groupName == _prevGroupName) then
							
						
									spgg.tblPrevSamSystems[_groupName] = spgg.tblPrevSamSystems[_groupName] or {}
						
									--env.info('-- spgg.completeAASystems - Grp :' .. _groupName)
						
									for i = 1, #_hawkDetails do
						
										--env.info('_hawkDetails['.. i ..'].name : ' .. _hawkDetails[i].name .. ' - ')
								
										if (_hawkDetails[i].name == _uPrevName) then
						
											local _pointX = _hawkDetails[i].pointX
											local _pointY = _hawkDetails[i].pointY
											local _pointZ = _hawkDetails[i].pointZ
						
											if (spgg.showEnvinfo == true) then
												env.info('-- SPGG :  spgg.completeAASystems - Found : Old group: ' .. _prevGroupName .. ' - New Group: ' .. _grpName .. ' - Old Unit Name: ' .. _hawkDetails[i].name .. ' - New Unit Name: ' ..  _unitName .. ' - System: ' .. _systemName)
											end
											
											table.insert(spgg.tblPrevSamSystems[_groupName], { ["oldSamGroupName"] = _prevGroupName, ["newSamGroupName"] = newGroupName, ["oldUnitName"] = _hawkDetails[i].name , ["newUnitName"] = _unitName ,  ["Type"] = _uType, ["pointX"] = _pointX , ["pointY"] = _pointY ,["pointZ"] = _pointZ ,["systemName"] = _systemName })
								
										end	-- end of if (_hawkDetails[i].name == _uPrevName) then

									end -- end of for i = 1, #_hawkDetails do
							
						
								end -- end of if (spgg.bluetroops[i].name == _prevGroupName) then
						
							end -- end of if (_prevGroupName ~= nil) then
					
						end -- end of for _groupName, _hawkDetails in pairs(spgg.completeAASystems) do
				
					end -- end of if (spgg.completeAASystems ~= nil)  then

				
				end -- end of if (ctld ~= nil) then
				
				
			
			end -- of for spwnUnitIdx = 1, #spgg.bluegroups[spwnGpIdx].units do
		
		
			-- Spawn group
			coalition.addGroup(_uCountry, Group.Category.GROUND, _data)	

			
				if (ctld ~= nil) then
					-- Borrowed from CTLD (Combat Troop and Logistics Drop) for integration of JTAC in save - See https://github.com/ciribob/DCS-CTLD 
					if (_isJtacAdd == true) then
							
						
						local _ctldjtacUnit = Unit.getByName(_ctldjtacUnitName)
						ctld.jtacUnits[_ctldjtacGroupName] = { name = _ctldjtacUnitName, side = _ctldjtacUnit:getCoalition(), radio = _radio }

                        local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
                        --put to the end
                        table.insert(ctld.jtacGeneratedLaserCodes, _code)

                        ctld.JTACAutoLase(_loadGrpName, _code) --(_jtacGroupName, _laserCode, _smoke, _lock, _colour)
						
						if (spgg.showEnvinfo == true) then
							env.info('-- SPGG :  Coalition Blue JTAC ADDED : ' .. _loadGrpName .. ' with Laser code : ' .. _code)
						end
					end
		

					if (ctld.droppedTroopsRED ~= nil) and (spgg.bluetroops ~= nil) then
			
						for i = 1, #spgg.bluetroops do
				
							if (_prevGroupName ~= nil) then
					
								if (spgg.bluetroops[i].name == _prevGroupName) then
						
							
									if spgg.findValue(ctld.droppedTroopsRED, _loadGrpName) then
							
							
									else
							
										table.insert(ctld.droppedTroopsRED, _loadGrpName)
								
									end

							
								end -- end of if (spgg.bluetroops[i].name == _prevGroupName) then
						
							end -- end of if (_prevGroupName ~= nil) then
					
						end -- end of for i = 1, #spgg.bluetroops do
				
					end -- end of if (ctld.droppedTroopsRED ~= nil) and (spgg.bluetroops ~= nil) then
				
				end -- end of if (ctld ~= nil) then	
			








			
			--env.info('-- Spawning Group')
			
		end
									
	end		


end -- of function spgg.spawnBlueGroundGroup()






-- gpUnitSize , _unitType, _unitCoord.x, _unitCoord.z, _unitHdg, _uCountry
function spgg.spawnRedGroundGroup()


	--env.info("-- Running SpawnRedGroundGroup!")
	
	--local _coaId = 1
	env.info('-- SPGG :  Coalition RED : Spawning Ground Forces')
	
	if (spgg ~= nil) and (spgg.redgroups ~= nil) then	

		for spwnGpIdx = 1, #spgg.redgroups do

			spgg.noMistCountGrp = spgg.noMistCountGrp + 1 
			
			local _isJtacAdd = false
			local _ctldjtacGroupName = ""
			local _ctldjtacUnit = ""
			local _groupId = 0
			
			if (spgg.useMIST == true) and (mist ~= nil) then 
				_groupId = mist.getNextGroupId()
			end
			
			
			local newUnitName = ""
			local newGroupName = ""
	
			local _prevGroupName = spgg.redgroups[spwnGpIdx].groupname or nil
			local _loadGrpName = ""
	
			if (spgg.ReuseGroupNames == true) then
				_loadGrpName = _prevGroupName
			else
			
				if (spgg.useMIST == true) and (mist ~= nil) then 
					_loadGrpName = "RedAiGroundGroup".. _groupId
				else
					_loadGrpName = "RedAiGroundGroupNM" .. spgg.noMistCountGrp
				end -- of if (spgg.useMIST == true) and (mist ~= nil) then
				
			end -- of if (spgg.ReuseGroupNames == true) then
		

			local _data = {

								["visible"] = false,
                                ["tasks"] = 
                                {
                                }, -- end of ["tasks"]
                                ["uncontrollable"] = false,
                                ["task"] = "Ground Nothing",
                                ["taskSelected"] = true,
                                
								["route"] =
								{
								
								},
								
                                --["groupId"] = _groupId,
                                ["hidden"] = false,
                                ["units"] = 
                                {
                                   								
							
								}, -- end of ["units"]
                            --["y"] = _uCoordZ1,
                            --["x"] = _uCoordX1,
                            ["name"] = _loadGrpName,
                            ["start_time"] = 0,
			} -- end of data

			if (spgg.useMIST == true) and (mist ~= nil) then 
		
				_data["groupId"] = _groupId
				--env.info('-- groupId with MIST: ' .. data.groupId)
		
			end
			
			if (spgg.ReuseID == true) and (spgg.redgroups[spwnGpIdx].groupid ~= nil) then 
		
				_data["groupId"] = spgg.redgroups[spwnGpIdx].groupid
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  redgroups groupId with ReuseID : ' .. _data.groupId)
				end
			end

			
			if (spgg.spawnGroupsAsSavedLateActivatedState == true) then
				
				if (spgg.redgroups[spwnGpIdx].lateActivation ~= nil) then 
					
					local _lateActivation = spgg.redgroups[spwnGpIdx].lateActivation
						
					if (_lateActivation == 1) then
					
						_data["lateActivation"] = true
						
						if (spgg.spawnVisibleInactive == true) then
							_data["visible"] = true
						end
						
					else
						
						_data["lateActivation"] = false
					end -- if (_lateActivation == 1) then
					
				end -- of if (spgg.redgroups[spwnGpIdx].lateActivation ~= nil) then
				
			end -- if (spgg.spawnGroupsAsSavedLateActivatedState == true) then
			
			
			
			-- Overrides spgg.spawnGroupsAsSavedLateActivatedState
			if (spgg.spawnAllGroupsAsInactive == true) then
				
				_data["lateActivation"] = true
				
				if (spgg.spawnVisibleInactive == true) then
					_data["visible"] = true
				end
				
			end


		if (spgg.showEnvinfo == true) then
			local _Msg = spgg.redgroups[spwnGpIdx].units[1].type
			env.info("-- SPGG :  Loading Red groups - Unit type : " .._Msg)
		end

					
		
					
			for spwnUnitIdx = 1, #spgg.redgroups[spwnGpIdx].units do
                       

				spgg.noMistCountUnit = spgg.noMistCountUnit + 1
				local _unitId = 0
				
				if (spgg.useMIST == true) and (mist ~= nil) then
					_unitId 		= mist.getNextUnitId()
				end
				
				if (spgg.ReuseID == true) and (spgg.redgroups[spwnGpIdx].units[spwnUnitIdx].unitid ~= nil) then
				 
					_unitId 		= spgg.redgroups[spwnGpIdx].units[spwnUnitIdx].unitid
					if (spgg.showEnvinfo == true) then
						env.info('-- SPGG :  redgroups unitId with ReuseID : ' .. spgg.redgroups[spwnGpIdx].units[spwnUnitIdx].unitid)
					end
				end
			
				local _uType		= spgg.redgroups[spwnGpIdx].units[spwnUnitIdx].type or ''
				local _uName		= spgg.redgroups[spwnGpIdx].units[spwnUnitIdx].name or ''
				local _uskill		= spgg.redgroups[spwnGpIdx].units[spwnUnitIdx].skill or ''
				local _uCoordX		= spgg.redgroups[spwnGpIdx].units[spwnUnitIdx].x or 0
				local _uCoordY		= spgg.redgroups[spwnGpIdx].units[spwnUnitIdx].y or 0
				local _uHdg			= spgg.redgroups[spwnGpIdx].units[spwnUnitIdx].heading or 0
				_uCountry		= spgg.redgroups[spwnGpIdx].units[spwnUnitIdx].country or 81
				_uPrevName		= spgg.redgroups[spwnGpIdx].units[spwnUnitIdx].name or ''
			

				_data.route = {
			
					["spans"] = 
					{
					}, -- end of ["spans"]
					["points"] = 
					{
						[1] = 
						{
							["alt"] = 59,
							["type"] = "Turning Point",
							["ETA"] = 0,
							["alt_type"] = "BARO",
							["formation_template"] = "",
							["y"] = _uCoordY,
							["x"] = _uCoordX,
							["ETA_locked"] = true,
							["speed"] = 0,
							["action"] = "Off Road",
							["task"] = 
							{
							["id"] = "ComboTask",
							["params"] = 
							{
							-- params (EPLRS) needs to know the spawning groups GroupID. Will be added only if MIST is active.
								
							}, -- end of ["params"]
						}, -- end of ["task"]
							["speed_locked"] = true,
						}, -- end of [1]
					}, -- end of ["points"]
	
				}


				if ((spgg.useMIST == true) and (mist ~= nil)) or ((spgg.ReuseID == true) and (spgg.redgroups[spwnGpIdx].units[spwnUnitIdx].unitid ~= nil)) then
				
					--Since we know the groupID, we can enable EPLRS (datalink) for the group
					_data.route.points[1].params = {
					
						["tasks"] = 
								{
									[1] = 
									{
										["number"] = 1,
										["auto"] = true,
										["id"] = "WrappedAction",
										["enabled"] = true,
										["params"] = 
										{
											["action"] = 
											{
												["id"] = "EPLRS",
												["params"] = 
												{
													["value"] = true,
													["groupId"] = _groupId,
												}, -- end of ["params"]
											}, -- end of ["action"]
										}, -- end of ["params"]
									}, -- end of [1]
						}, -- end of ["tasks"]
							
					
					
					} -- end of data.route.points[1].params = {
		

					--env.info('-- GroupID with MIST: ' .. data.route.points[1].params.tasks[1].params.action.params.groupId)
					--env.info('-- EPLRS groupId with MIST: ' .. data.route.points[1].params.tasks[1].params.action.id )
				
				end -- of if (spgg.useMIST == true) and (mist ~= nil) then


				newGroupName = _loadGrpName
				--newUnitName = "RedAiGroundUnit".. _unitId
				
				
				
				if (spgg.ReuseUnitNames == true) then
					newUnitName = _uName
				else
				
					if (spgg.useMIST == true) and (mist ~= nil) then
						newUnitName = "RedAiGroundUnit".. _unitId
					else
						newUnitName = "RedAiGroundUnitNM".. spgg.noMistCountUnit
						--env.info("-- Red Unit Name:  " .. newUnitName)
					end -- of if (spgg.useMIST == true) and (mist ~= nil) then
					
				end -- of if (spgg.ReuseUnitNames == true) then


				--env.info("-- Red Group Name:  " .. newGroupName)
				
				
				_data.units[spwnUnitIdx] = {
			
					["type"] = _uType,
					--["unitId"] = _unitId,
					["skill"] = _uskill,
					["y"] = _uCoordY,
					["x"] = _uCoordX,
					["name"] = newUnitName,
					["heading"] = _uHdg,
					["playerCanDrive"] = true,
			
				}
			
			
				--data["name"] = _loadGrpName
				
				if (spgg.useMIST == true) and (mist ~= nil) then
					_data.units[spwnUnitIdx]["unitId"] = _unitId
					--env.info('-- UnitID with MIST: ' .. data.units[spwnUnitIdx].unitId)
					
				end -- of if (spgg.useMIST == true) and (mist ~= nil) then
			
				
				if (spgg.ReuseID == true) and (spgg.redgroups[spwnGpIdx].units[spwnUnitIdx].unitid ~= nil) then
				 
					_data.units[spwnUnitIdx]["unitId"] = _unitId
					if (spgg.showEnvinfo == true) then
						env.info('-- SPGG :  redgroups unitid with ReuseID : ' .. _unitId)
					end
				end
				
				
				if (spgg.liveryType) and (spgg.liveryType ~= 0) then
				
					if (spgg.groundUnitLivery[_uType]) then
						_data.units[spwnUnitIdx]["livery_id"] = spgg.groundUnitLivery[_uType][spgg.liveryType].livery_id
						env.info('-- SPGG : Unit Type: '.._uType .. ' - livery_id: ' .. spgg.groundUnitLivery[_uType][spgg.liveryType].livery_id)
					else
					

						if (spgg.liveryType == 1) then
							_data.units[spwnUnitIdx]["livery_id"] = spgg.defaultRedLiveryDesert
						
						
						elseif (spgg.liveryType == 2) then
							_data.units[spwnUnitIdx]["livery_id"] = spgg.defaultRedLiveryWinter
					
						--env.info('-- SPGG :  Unit type not found in spgg.groundUnitLivery,using default type for what was selected!')
						end
						
					end
					
				end -- of if (spgg.liveryType) and (spgg.liveryType ~= 0) then
				

				if (ctld ~= nil) then
					-- Borrowed from CTLD (Combat Troop and Logistics Drop) for integration of JTAC in save - See https://github.com/ciribob/DCS-CTLD 
					if (ctld.isJTACUnitType ~= nil) and (ctld.JTAC_dropEnabled ~= nil) and (ctld.jtacGeneratedLaserCodes ~= nil) then
				
						if ctld.isJTACUnitType(_uType) and ctld.JTAC_dropEnabled then

							_isJtacAdd = true
							_ctldjtacGroupName = _loadGrpName
							_ctldjtacUnitName =	newUnitName
						
						end -- of if ctld.isJTACUnitType(_uType) and ctld.JTAC_dropEnabled then
			
					end -- of if (ctld.isJTACUnitType ~= nil) and (ctld.JTAC_dropEnabled ~= nil) and (ctld.jtacGeneratedLaserCodes ~= nil) then


			
					if (spgg.showEnvinfo == true) then
					
						if (spgg.useMIST == true) and (mist ~= nil) then
							env.info("-- SPGG :  Load Red groups Unit type : " .. _uType .. " - Index : " .. spwnUnitIdx .. " - GroupID : " .. _groupId .. " - unitID : " .. _unitId)
						else
							env.info("-- SPGG :  Load Red groups Unit type without MIST : " .. _uType .. " - Index : " .. spwnUnitIdx .. " - GroupID : Unknown" .. " - unitID : Unknown")
						end
						
					end -- of if (spgg.showEnvinfo == true) then



					if (spgg.completeAASystems ~= nil)  then
						
						if (spgg.showEnvinfo == true) then
							env.info("-- SPGG :  SPGG running spgg.completeAASystems check for :  " .. newGroupName)
						end

						for _groupName, _hawkDetails in pairs(spgg.completeAASystems) do
				
							if (_prevGroupName ~= nil) then
						

								local _grpName = _loadGrpName
								local _unitName = newUnitName
						
								local _systemName = _hawkDetails[1].system

								if (_groupName == _prevGroupName) then
							
						
									spgg.tblPrevSamSystems[_groupName] = spgg.tblPrevSamSystems[_groupName] or {}
						
									--env.info('-- spgg.completeAASystems - Grp :' .. _groupName)
						
									for i = 1, #_hawkDetails do
						
										--env.info('_hawkDetails['.. i ..'].name : ' .. _hawkDetails[i].name .. ' - ')
								
										if (_hawkDetails[i].name == _uPrevName) then
						
											local _pointX = _hawkDetails[i].pointX
											local _pointY = _hawkDetails[i].pointY
											local _pointZ = _hawkDetails[i].pointZ
						
											if (spgg.showEnvinfo == true) then
												env.info('-- SPGG :  spgg.completeAASystems - Found : Old group: ' .. _prevGroupName .. ' - New Group: ' .. _grpName .. ' - Old Unit Name: ' .. _hawkDetails[i].name .. ' - New Unit Name: ' ..  _unitName .. ' - System: ' .. _systemName)
											end
											
											table.insert(spgg.tblPrevSamSystems[_groupName], { ["oldSamGroupName"] = _prevGroupName, ["newSamGroupName"] = newGroupName, ["oldUnitName"] = _hawkDetails[i].name , ["newUnitName"] = _unitName ,  ["Type"] = _uType, ["pointX"] = _pointX , ["pointY"] = _pointY ,["pointZ"] = _pointZ ,["systemName"] = _systemName })
								
										end	-- end of if (_hawkDetails[i].name == _uPrevName) then

									end -- end of for i = 1, #_hawkDetails do
							
						
								end -- end of if (spgg.redtroops[i].name == _prevGroupName) then
						
							end -- end of if (_prevGroupName ~= nil) then
					
						end -- end of for _groupName, _hawkDetails in pairs(spgg.completeAASystems) do
				
					end -- end of if (spgg.completeAASystems ~= nil)  then

				
				end -- end of if (ctld ~= nil) then
				
				
			
			end -- of for spwnUnitIdx = 1, #spgg.redgroups[spwnGpIdx].units do
		
		
			-- Spawn group
			coalition.addGroup(_uCountry, Group.Category.GROUND, _data)	

			
				if (ctld ~= nil) then
					-- Borrowed from CTLD (Combat Troop and Logistics Drop) for integration of JTAC in save - See https://github.com/ciribob/DCS-CTLD 
					if (_isJtacAdd == true) then
							
						
						local _ctldjtacUnit = Unit.getByName(_ctldjtacUnitName)
						ctld.jtacUnits[_ctldjtacGroupName] = { name = _ctldjtacUnitName, side = _ctldjtacUnit:getCoalition(), radio = _radio }

                        local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
                        --put to the end
                        table.insert(ctld.jtacGeneratedLaserCodes, _code)

                        ctld.JTACAutoLase(_loadGrpName, _code) --(_jtacGroupName, _laserCode, _smoke, _lock, _colour)
						
						if (spgg.showEnvinfo == true) then
							env.info('-- SPGG :  SPGG - Coalition Red JTAC ADDED : ' .. _loadGrpName .. ' with Laser code : ' .. _code)
						end
					end
		

					if (ctld.droppedTroopsRED ~= nil) and (spgg.redtroops ~= nil) then
			
						for i = 1, #spgg.redtroops do
				
							if (_prevGroupName ~= nil) then
					
								if (spgg.redtroops[i].name == _prevGroupName) then
						
							
									if spgg.findValue(ctld.droppedTroopsRED, _loadGrpName) then
							
							
									else
							
										table.insert(ctld.droppedTroopsRED, _loadGrpName)
								
									end

							
								end -- end of if (spgg.redtroops[i].name == _prevGroupName) then
						
							end -- end of if (_prevGroupName ~= nil) then
					
						end -- end of for i = 1, #spgg.redtroops do
				
					end -- end of if (ctld.droppedTroopsRED ~= nil) and (spgg.redtroops ~= nil) then
				
				end -- end of if (ctld ~= nil) then	
			








			
			--env.info('-- Spawning Group')
			
		end
									
	end		


end -- of function spgg.spawnRedGroundGroup()








-- gpUnitSize , _unitType, _unitCoord.x, _unitCoord.z, _unitHdg, _uCountry
function spgg.spawnNeutralGroundGroup()


	--env.info("-- Running spawnNeutralGroundGroup!")
	
	--local _coaId = 1
	env.info('-- SPGG :  Coalition NEUTRAL : Spawning Ground Forces')
	
	if (spgg ~= nil) and (spgg.neutralgroups ~= nil) then	

		for spwnGpIdx = 1, #spgg.neutralgroups do

			spgg.noMistCountGrp = spgg.noMistCountGrp + 1 
			
			local _isJtacAdd = false
			local _ctldjtacGroupName = ""
			local _ctldjtacUnit = ""
			local _groupId = 0
			
			if (spgg.useMIST == true) and (mist ~= nil) then 
				_groupId = mist.getNextGroupId()
			end
			
			
			local newUnitName = ""
			local newGroupName = ""
	
			local _prevGroupName = spgg.neutralgroups[spwnGpIdx].groupname or nil
			local _loadGrpName = ""
	
			if (spgg.ReuseGroupNames == true) then
				_loadGrpName = _prevGroupName
			else
			
				if (spgg.useMIST == true) and (mist ~= nil) then 
					_loadGrpName = "NeutralAiGroundGroup".. _groupId
				else
					_loadGrpName = "NeutralAiGroundGroupNM" .. spgg.noMistCountGrp
				end -- of if (spgg.useMIST == true) and (mist ~= nil) then
				
			end -- of if (spgg.ReuseGroupNames == true) then
		

			local _data = {

								["visible"] = false,
                                ["tasks"] = 
                                {
                                }, -- end of ["tasks"]
                                ["uncontrollable"] = false,
                                ["task"] = "Ground Nothing",
                                ["taskSelected"] = true,
                                
								["route"] =
								{
								
								},
								
                                --["groupId"] = _groupId,
                                ["hidden"] = false,
                                ["units"] = 
                                {
                                   								
							
								}, -- end of ["units"]
                            --["y"] = _uCoordZ1,
                            --["x"] = _uCoordX1,
                            ["name"] = _loadGrpName,
                            ["start_time"] = 0,
			} -- end of data

			if (spgg.useMIST == true) and (mist ~= nil) then 
		
				_data["groupId"] = _groupId
				--env.info('-- groupId with MIST: ' .. data.groupId)
		
			end
			
			if (spgg.ReuseID == true) and (spgg.neutralgroups[spwnGpIdx].groupid ~= nil) then 
		
				_data["groupId"] = spgg.neutralgroups[spwnGpIdx].groupid
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  neutralgroups groupId with ReuseID : ' .. _data.groupId)
				end
			end
			
			
			if (spgg.spawnGroupsAsSavedLateActivatedState == true) then
				
				if (spgg.neutralgroups[spwnGpIdx].lateActivation ~= nil) then 
					
					local _lateActivation = spgg.neutralgroups[spwnGpIdx].lateActivation
					
					if (_lateActivation == 1) then
						_data["lateActivation"] = true
						
						if (spgg.spawnVisibleInactive == true) then
							_data["visible"] = true
						end
						
					else
						
						_data["lateActivation"] = false
					end -- if (_lateActivation == 1) then
					
				end -- of if (spgg.neutralgroups[spwnGpIdx].lateActivation ~= nil) then
				
			end -- if (spgg.spawnGroupsAsSavedLateActivatedState == true) then
			
			
			
			-- Overrides spgg.spawnGroupsAsSavedLateActivatedState
			if (spgg.spawnAllGroupsAsInactive == true) then
				
				_data["lateActivation"] = true
				
				if (spgg.spawnVisibleInactive == true) then
					_data["visible"] = true
				end
				
			end


		if (spgg.showEnvinfo == true) then
			local _Msg = spgg.neutralgroups[spwnGpIdx].units[1].type
			env.info("-- SPGG :  Loading Neutral groups - Unit type : " .._Msg)
		end

					
		
					
			for spwnUnitIdx = 1, #spgg.neutralgroups[spwnGpIdx].units do
                       

				spgg.noMistCountUnit = spgg.noMistCountUnit + 1
				local _unitId = 0
				
				if (spgg.useMIST == true) and (mist ~= nil) then
					_unitId 		= mist.getNextUnitId()
				end
				
				if (spgg.ReuseID == true) and (spgg.neutralgroups[spwnGpIdx].units[spwnUnitIdx].unitid ~= nil) then
				 
					_unitId 		= spgg.neutralgroups[spwnGpIdx].units[spwnUnitIdx].unitid
					if (spgg.showEnvinfo == true) then
						env.info('-- SPGG :  neutralgroups unitId with ReuseID : ' .. spgg.neutralgroups[spwnGpIdx].units[spwnUnitIdx].unitid)
					end
				end
			
				local _uType		= spgg.neutralgroups[spwnGpIdx].units[spwnUnitIdx].type or ''
				local _uName		= spgg.neutralgroups[spwnGpIdx].units[spwnUnitIdx].name or ''
				local _uskill		= spgg.neutralgroups[spwnGpIdx].units[spwnUnitIdx].skill or ''
				local _uCoordX		= spgg.neutralgroups[spwnGpIdx].units[spwnUnitIdx].x or 0
				local _uCoordY		= spgg.neutralgroups[spwnGpIdx].units[spwnUnitIdx].y or 0
				local _uHdg			= spgg.neutralgroups[spwnGpIdx].units[spwnUnitIdx].heading or 0
				_uCountry		= spgg.neutralgroups[spwnGpIdx].units[spwnUnitIdx].country or 81
				_uPrevName		= spgg.neutralgroups[spwnGpIdx].units[spwnUnitIdx].name or ''
			

				_data.route = {
			
					["spans"] = 
					{
					}, -- end of ["spans"]
					["points"] = 
					{
						[1] = 
						{
							["alt"] = 59,
							["type"] = "Turning Point",
							["ETA"] = 0,
							["alt_type"] = "BARO",
							["formation_template"] = "",
							["y"] = _uCoordY,
							["x"] = _uCoordX,
							["ETA_locked"] = true,
							["speed"] = 0,
							["action"] = "Off Road",
							["task"] = 
							{
							["id"] = "ComboTask",
							["params"] = 
							{
							-- params (EPLRS) needs to know the spawning groups GroupID. Will be added only if MIST is active.
								
							}, -- end of ["params"]
						}, -- end of ["task"]
							["speed_locked"] = true,
						}, -- end of [1]
					}, -- end of ["points"]
	
				}


				if ((spgg.useMIST == true) and (mist ~= nil)) or ((spgg.ReuseID == true) and (spgg.neutralgroups[spwnGpIdx].units[spwnUnitIdx].unitid ~= nil)) then
				
					--Since we know the groupID, we can enable EPLRS (datalink) for the group
					_data.route.points[1].params = {
					
						["tasks"] = 
								{
									[1] = 
									{
										["number"] = 1,
										["auto"] = true,
										["id"] = "WrappedAction",
										["enabled"] = true,
										["params"] = 
										{
											["action"] = 
											{
												["id"] = "EPLRS",
												["params"] = 
												{
													["value"] = true,
													["groupId"] = _groupId,
												}, -- end of ["params"]
											}, -- end of ["action"]
										}, -- end of ["params"]
									}, -- end of [1]
						}, -- end of ["tasks"]
							
					
					
					} -- end of data.route.points[1].params = {
		

					--env.info('-- GroupID with MIST: ' .. data.route.points[1].params.tasks[1].params.action.params.groupId)
					--env.info('-- EPLRS groupId with MIST: ' .. data.route.points[1].params.tasks[1].params.action.id )
				
				end -- of if (spgg.useMIST == true) and (mist ~= nil) then


				newGroupName = _loadGrpName
				--newUnitName = "NeutralAiGroundUnit".. _unitId
				
				
				
				if (spgg.ReuseUnitNames == true) then
					newUnitName = _uName
				else
				
					if (spgg.useMIST == true) and (mist ~= nil) then
						newUnitName = "NeutralAiGroundUnit".. _unitId
					else
						newUnitName = "NeutralAiGroundUnitNM".. spgg.noMistCountUnit
						--env.info("-- Neutral Unit Name:  " .. newUnitName)
					end -- of if (spgg.useMIST == true) and (mist ~= nil) then
					
				end -- of if (spgg.ReuseUnitNames == true) then


				--env.info("-- Neutral Group Name:  " .. newGroupName)
				
				
				_data.units[spwnUnitIdx] = {
			
					["type"] = _uType,
					--["unitId"] = _unitId,
					["skill"] = _uskill,
					["y"] = _uCoordY,
					["x"] = _uCoordX,
					["name"] = newUnitName,
					["heading"] = _uHdg,
					["playerCanDrive"] = true,
			
				}
			
			
				--data["name"] = _loadGrpName
				
				if (spgg.useMIST == true) and (mist ~= nil) then
					_data.units[spwnUnitIdx]["unitId"] = _unitId
					--env.info('-- UnitID with MIST: ' .. data.units[spwnUnitIdx].unitId)
					
				end -- of if (spgg.useMIST == true) and (mist ~= nil) then
			
				
				if (spgg.ReuseID == true) and (spgg.neutralgroups[spwnGpIdx].units[spwnUnitIdx].unitid ~= nil) then
				 
					_data.units[spwnUnitIdx]["unitId"] = _unitId
					if (spgg.showEnvinfo == true) then
						env.info('-- SPGG :  neutralgroups unitid with ReuseID : ' .. _unitId)
					end
				end
				
				
				if (spgg.liveryType) and (spgg.liveryType ~= 0) then
				
					if (spgg.groundUnitLivery[_uType]) then
						_data.units[spwnUnitIdx]["livery_id"] = spgg.groundUnitLivery[_uType][spgg.liveryType].livery_id
						env.info('-- SPGG : Unit Type: '.._uType .. ' - livery_id: ' .. spgg.groundUnitLivery[_uType][spgg.liveryType].livery_id)
					else
					
									
						if (spgg.liveryType == 1) then
							_data.units[spwnUnitIdx]["livery_id"] = spgg.defaultNeutralLiveryDesert
						
						
						elseif (spgg.liveryType == 2) then
							_data.units[spwnUnitIdx]["livery_id"] = spgg.defaultNeutralLiveryWinter
					
						--env.info('-- SPGG :  Unit type not found in spgg.groundUnitLivery,using default type for what was selected!')
						end
						
					end
					
				end -- of if (spgg.liveryType) and (spgg.liveryType ~= 0) then
				

				if (ctld ~= nil) then
					-- Borrowed from CTLD (Combat Troop and Logistics Drop) for integration of JTAC in save - See https://github.com/ciribob/DCS-CTLD 
					if (ctld.isJTACUnitType ~= nil) and (ctld.JTAC_dropEnabled ~= nil) and (ctld.jtacGeneratedLaserCodes ~= nil) then
				
						if ctld.isJTACUnitType(_uType) and ctld.JTAC_dropEnabled then

							_isJtacAdd = true
							_ctldjtacGroupName = _loadGrpName
							_ctldjtacUnitName =	newUnitName
						
						end -- of if ctld.isJTACUnitType(_uType) and ctld.JTAC_dropEnabled then
			
					end -- of if (ctld.isJTACUnitType ~= nil) and (ctld.JTAC_dropEnabled ~= nil) and (ctld.jtacGeneratedLaserCodes ~= nil) then


			
					if (spgg.showEnvinfo == true) then
					
						if (spgg.useMIST == true) and (mist ~= nil) then
							env.info("-- SPGG :  Load Neutral groups Unit type : " .. _uType .. " - Index : " .. spwnUnitIdx .. " - GroupID : " .. _groupId .. " - unitID : " .. _unitId)
						else
							env.info("-- SPGG :  Load Neutral groups Unit type without MIST : " .. _uType .. " - Index : " .. spwnUnitIdx .. " - GroupID : Unknown" .. " - unitID : Unknown")
						end
						
					end -- of if (spgg.showEnvinfo == true) then



					if (spgg.completeAASystems ~= nil)  then
						
						if (spgg.showEnvinfo == true) then
							env.info("-- SPGG :  SPGG running spgg.completeAASystems check for :  " .. newGroupName)
						end

						for _groupName, _hawkDetails in pairs(spgg.completeAASystems) do
				
							if (_prevGroupName ~= nil) then
						

								local _grpName = _loadGrpName
								local _unitName = newUnitName
						
								local _systemName = _hawkDetails[1].system

								if (_groupName == _prevGroupName) then
							
						
									spgg.tblPrevSamSystems[_groupName] = spgg.tblPrevSamSystems[_groupName] or {}
						
									--env.info('-- spgg.completeAASystems - Grp :' .. _groupName)
						
									for i = 1, #_hawkDetails do
						
										--env.info('_hawkDetails['.. i ..'].name : ' .. _hawkDetails[i].name .. ' - ')
								
										if (_hawkDetails[i].name == _uPrevName) then
						
											local _pointX = _hawkDetails[i].pointX
											local _pointY = _hawkDetails[i].pointY
											local _pointZ = _hawkDetails[i].pointZ
						
											if (spgg.showEnvinfo == true) then
												env.info('-- SPGG :  spgg.completeAASystems - Found : Old group: ' .. _prevGroupName .. ' - New Group: ' .. _grpName .. ' - Old Unit Name: ' .. _hawkDetails[i].name .. ' - New Unit Name: ' ..  _unitName .. ' - System: ' .. _systemName)
											end
											
											table.insert(spgg.tblPrevSamSystems[_groupName], { ["oldSamGroupName"] = _prevGroupName, ["newSamGroupName"] = newGroupName, ["oldUnitName"] = _hawkDetails[i].name , ["newUnitName"] = _unitName ,  ["Type"] = _uType, ["pointX"] = _pointX , ["pointY"] = _pointY ,["pointZ"] = _pointZ ,["systemName"] = _systemName })
								
										end	-- end of if (_hawkDetails[i].name == _uPrevName) then

									end -- end of for i = 1, #_hawkDetails do
							
						
								end -- end of if (spgg.neutraltroops[i].name == _prevGroupName) then
						
							end -- end of if (_prevGroupName ~= nil) then
					
						end -- end of for _groupName, _hawkDetails in pairs(spgg.completeAASystems) do
				
					end -- end of if (spgg.completeAASystems ~= nil)  then

				
				end -- end of if (ctld ~= nil) then
				
				
			
			end -- of for spwnUnitIdx = 1, #spgg.neutralgroups[spwnGpIdx].units do
		
		
			-- Spawn group
			coalition.addGroup(_uCountry, Group.Category.GROUND, _data)	

			
				if (ctld ~= nil) then
					-- Borrowed from CTLD (Combat Troop and Logistics Drop) for integration of JTAC in save - See https://github.com/ciribob/DCS-CTLD 
					if (_isJtacAdd == true) then
							
						
						local _ctldjtacUnit = Unit.getByName(_ctldjtacUnitName)
						ctld.jtacUnits[_ctldjtacGroupName] = { name = _ctldjtacUnitName, side = _ctldjtacUnit:getCoalition(), radio = _radio }

                        local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
                        --put to the end
                        table.insert(ctld.jtacGeneratedLaserCodes, _code)

                        ctld.JTACAutoLase(_loadGrpName, _code) --(_jtacGroupName, _laserCode, _smoke, _lock, _colour)
						
						if (spgg.showEnvinfo == true) then
							env.info('-- SPGG :  SPGG - Coalition Neutral JTAC ADDED : ' .. _loadGrpName .. ' with Laser code : ' .. _code)
						end
					end
		

					if (ctld.droppedTroopsRED ~= nil) and (spgg.neutraltroops ~= nil) then
			
						for i = 1, #spgg.neutraltroops do
				
							if (_prevGroupName ~= nil) then
					
								if (spgg.neutraltroops[i].name == _prevGroupName) then
						
							
									if spgg.findValue(ctld.droppedTroopsRED, _loadGrpName) then
							
							
									else
							
										table.insert(ctld.droppedTroopsRED, _loadGrpName)
								
									end

							
								end -- end of if (spgg.neutraltroops[i].name == _prevGroupName) then
						
							end -- end of if (_prevGroupName ~= nil) then
					
						end -- end of for i = 1, #spgg.neutraltroops do
				
					end -- end of if (ctld.droppedTroopsRED ~= nil) and (spgg.neutraltroops ~= nil) then
				
				end -- end of if (ctld ~= nil) then	
			








			
			--env.info('-- Spawning Group')
			
		end
									
	end		


end -- of function spgg.spawnNeutralGroundGroup()










function spgg.spawnBlueStaticObject()


	local _coaId = 2
	
	
		
	env.info('-- SPGG :  - Coalition BLUE : Spawning Static Objects')
			
		

	if (spgg ~= nil) and (spgg.bluestaticobj ~= nil) then

	

		for spwnSoIdx = 1, #spgg.bluestaticobj do


			local _unitId = 0
			local _groupId = 0
			
			spgg.noMistCountGrp = spgg.noMistCountGrp + 1 
			spgg.noMistCountUnit = spgg.noMistCountUnit + 1
			
			
			if (spgg.useMIST == true) and (mist ~= nil) then
				_unitId = mist.getNextGroupId()
				_groupId = mist.getNextGroupId()
			end
			

			
			local _soType		= spgg.bluestaticobj[spwnSoIdx].obj[1].type or ''
			
			local _soCategory		= spgg.bluestaticobj[spwnSoIdx].obj[1].category or 1
			
			local _soPrevName	= spgg.bluestaticobj[spwnSoIdx].obj[1].name or ''
			local _soCoordX		= spgg.bluestaticobj[spwnSoIdx].obj[1].x or 0
			local _soCoordY		= spgg.bluestaticobj[spwnSoIdx].obj[1].y or 0
			local _soHdg		= spgg.bluestaticobj[spwnSoIdx].obj[1].heading or 0
			local _uCountry		= spgg.bluestaticobj[spwnSoIdx].obj[1].country or 80
			local _uWeight		= spgg.bluestaticobj[spwnSoIdx].obj[1].mass or 0
	
	
	
			local _data = {
				
				["category"] = _soCategory,
				["type"] = _soType,
				--["unitId"] = _unitId,
				["y"] = _soCoordY,
				["x"] = _soCoordX,
				["canCargo"] = false,
				["heading"] = _soHdg,
				["mass"] = _uWeight,
				--["groupId"] = _groupId,
				
			}

			if (spgg.useMIST == true) and (mist ~= nil) then
		
				--_data["groupId"] = _groupId
				_data["unitId"] = _unitId
				--_data.units[1]["unitId"] = _unitId
				
		
			end
			
			
				
			
			if (spgg.ReuseID == true) and (spgg.bluestaticobj[spwnSoIdx].obj[1].unitid ~= nil) then 
		
				--data["groupId"] = spgg.bluestaticobj[spwnSoIdx].obj[1].unitid
				_data["unitId"] = spgg.bluestaticobj[spwnSoIdx].obj[1].unitid
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  bluestaticobj unitId with ReuseID : ' .. _data.unitId)
				end
			end

			if (spgg.ReuseUnitNames == true) then
					_soNewName = _soPrevName
			else
				
					if (spgg.useMIST == true) and (mist ~= nil) then
						_soNewName = "Static Object #" .._unitId.. " Blue"
					else

						_soNewName = "Static Object NM #" .. spgg.noMistCountUnit .. " Blue"
						
					end -- of if (spgg.useMIST == true) and (mist ~= nil) then
					
			end -- of if (spgg.ReuseUnitNames == true) then

		
			
			_data["country"] = _uCountry
			_data["name"] = _soNewName
			
			--_soNewName = "Static Object #" .._unitId.. " Blue"
			--_data.units[1]["name"] = _soNewName .. '-1-1'
			--_data.units[1]["type"] = _soType
			--_data.units[1]["heading"] = _soHdg
			--_data.units[1]["category"] = _soCategory
			
			
			if (ctld ~= nil) then
			
				if spgg.saveCtldCrates == true then
			
					if (ctld.slingLoad == true) and (ctld.enableCrates == true) then
						
						_data["canCargo"] = true
						
						if (_soType == ctld.spawnableCratesModel_sling.type) then
							env.error('ctld.spawnableCratesModel_sling.type : ' .. ctld.spawnableCratesModel_sling.shape_name)
							_data["shape_name"] = ctld.spawnableCratesModel_sling.shape_name
							
							local _crateType = ctld.crateLookupTable[tostring(_uWeight)]
							-- local _coaId = 2
							if _coaId == 1 then
								ctld.spawnedCratesRED[_soNewName] = {}
								ctld.spawnedCratesRED[_soNewName] =_crateType
								 env.info('-- Readded : ' .._soNewName.. ' - to  ctld.spawnedCratesRED!')
							else
								ctld.spawnedCratesBLUE[_soNewName] = {}
								ctld.spawnedCratesBLUE[_soNewName] = _crateType
								env.info('-- Readded : ' .._soNewName.. ' - to  ctld.spawnedCratesBLUE!')
							end
							
						end
						
					elseif (ctld.slingLoad == false) and (ctld.enableCrates == true) then
					
						if (_soType == ctld.spawnableCratesModel_load.type) then
							env.error('ctld.spawnableCratesModel_load.type : ' .. ctld.spawnableCratesModel_load.shape_name)
							_data["shape_name"] = ctld.spawnableCratesModel_load.shape_name
							
							local _crateType = ctld.crateLookupTable[tostring(_uWeight)]
							-- local _coaId = 2
							if _coaId == 1 then
								ctld.spawnedCratesRED[_soNewName] = {}
								ctld.spawnedCratesRED[_soNewName] =_crateType
								 env.info('-- Readded : ' .._soNewName.. ' - to  ctld.spawnedCratesRED!')
							else
								ctld.spawnedCratesBLUE[_soNewName] = {}
								ctld.spawnedCratesBLUE[_soNewName] = _crateType
								env.info('-- Readded : ' .._soNewName.. ' - to  ctld.spawnedCratesBLUE!')
							end
							
						end
					end
			
				end -- of if spgg.saveCtldCrates == true then
				
			end -- of if (ctld ~= nil) then
			
			
			coalition.addStaticObject(_uCountry, _data)	
			--mist.dynAddStatic(_data)
		
			if (spgg.showEnvinfo == true) then
				env.info("-- SPGG :  Load Blue Static Object type : " .. _soType .. " - Category: " .. _soCategory .. " - Index : " .. spwnSoIdx .. " - GroupID : " .. _groupId .. " - unitID : " .. _unitId .. " - New Name : " .. _soNewName)
			end
		
		
			if (ctld ~= nil) then
			
				-- Check if CTLD has base building Enabled
				if (ctld.enabledFOBBuilding ~= nil) then
		
					if (ctld.enabledFOBBuilding == true) then
		
						--table.insert(ctld.logisticUnits, _soNewName)



						if (ctld.logisticUnits ~= nil) and (spgg.logisticUnits ~= nil) then
			
							for i = 1, #spgg.logisticUnits do
				
								if (_soPrevName ~= nil) then
					
									if (spgg.logisticUnits[i].name == _soPrevName) then
						
							
										if spgg.findValue(ctld.logisticUnits, _soNewName) then
							
										else
											
											if (spgg.showEnvinfo == true) then
												env.info("-- SPGG :  Load Blue Static Object type in to ctld.logisticUnits : " .. _soType .. " - Category: " .. _soCategory .. " - Index : " .. spwnSoIdx .. " - GroupID : " .. _groupId .. " - unitID : " .. _unitId)
											end
											table.insert(ctld.logisticUnits, _soNewName)
								
										end -- end of: if spgg.findValue(ctld.logisticUnits, _soNewName) then

							
									end -- end of: if (spgg.logisticUnits[i].name == _soPrevName) then
						
								end -- end of: if (_soPrevName ~= nil) then
					
							end -- end of: for i = 1, #spgg.logisticUnits do
				
						end -- end of: if (ctld.logisticUnits ~= nil) and (spgg.logisticUnits ~= nil) then

						
						
						
						
						if (ctld.troopPickupAtFOB == true) then
							--table.insert(ctld.builtFOBS, _soNewName)
							
							
							
							if (ctld.builtFOBS ~= nil) and (spgg.builtFOBS ~= nil) then
			
								for i = 1, #spgg.builtFOBS do
				
									if (_soPrevName ~= nil) then
					
										if (spgg.builtFOBS[i].name == _soPrevName) then
						
							
											if spgg.findValue(ctld.builtFOBS, _soNewName) then
							
											else
							
												if (spgg.showEnvinfo == true) then
													env.info("-- SPGG :  Load Blue Static Object type in to ctld.builtFOBS : " .. _soType .. " - Category: " .. _soCategory .. " - Index : " .. spwnSoIdx .. " - GroupID : " .. _groupId .. " - unitID : " .. _unitId)
												end
												table.insert(ctld.builtFOBS, _soNewName)
								
											end -- end of: if spgg.findValue(ctld.builtFOBS, _soNewName) then

							
										end -- end of: if (spgg.builtFOBS[i].name == _soPrevName) then
						
									end -- end of: if (_soPrevName ~= nil) then
					
								end -- end of: for i = 1, #spgg.builtFOBS do
				
							end -- end of: if (ctld.builtFOBS ~= nil) and (spgg.builtFOBS ~= nil) then
							
							
							
							
							
						end -- end of: if (ctld.troopPickupAtFOB == true) then
		
					end -- end of: if (ctld.enabledFOBBuilding == true) then
		
				end -- end of: if (ctld.enabledFOBBuilding ~= nil) then
				
				
				
			end -- end of if (ctld ~= nil) then
			
			
	
		end  -- end of for spwnSoIdx = 1, #spgg.bluestaticobj do

	end -- of if (spgg ~= nil) and (spgg.bluestaticobj ~= nil) then
	
end -- of function spgg.spawnBlueStaticObject()







function spgg.spawnRedStaticObject()


	local _coaId = 1
	
	
		
	env.info('-- SPGG :  - Coalition RED : Spawning Static Objects')
			
		

	if (spgg ~= nil) and (spgg.redstaticobj ~= nil) then

	

		for spwnSoIdx = 1, #spgg.redstaticobj do


			local _unitId = 0
			local _groupId = 0
			
			spgg.noMistCountGrp = spgg.noMistCountGrp + 1 
			spgg.noMistCountUnit = spgg.noMistCountUnit + 1
			
			
			if (spgg.useMIST == true) and (mist ~= nil) then
				_unitId = mist.getNextGroupId()
				_groupId = mist.getNextGroupId()
			end
			

			
			local _soType		= spgg.redstaticobj[spwnSoIdx].obj[1].type or ''
			
			local _soCategory		= spgg.redstaticobj[spwnSoIdx].obj[1].category or 1
			
			local _soPrevName	= spgg.redstaticobj[spwnSoIdx].obj[1].name or ''
			local _soCoordX		= spgg.redstaticobj[spwnSoIdx].obj[1].x or 0
			local _soCoordY		= spgg.redstaticobj[spwnSoIdx].obj[1].y or 0
			local _soHdg		= spgg.redstaticobj[spwnSoIdx].obj[1].heading or 0
			local _uCountry		= spgg.redstaticobj[spwnSoIdx].obj[1].country or 81
			local _uWeight		= spgg.redstaticobj[spwnSoIdx].obj[1].mass or 0
	
	
			local _data = {
				
				["category"] = _soCategory,
				["type"] = _soType,
				--["unitId"] = _unitId,
				["y"] = _soCoordY,
				["x"] = _soCoordX,
				["canCargo"] = false,
				["heading"] = _soHdg,
				--["groupId"] = _groupId,
				
			}

			if (spgg.useMIST == true) and (mist ~= nil) then
		
				--_data["groupId"] = _groupId
				_data["unitId"] = _unitId
				--_data.units[1]["unitId"] = _unitId
				
		
			end
			
			if (ctld ~= nil) then
				if ctld.slingLoad then
					_data["canCargo"] = true
				end
			end
			
			if (spgg.ReuseID == true) and (spgg.redstaticobj[spwnSoIdx].obj[1].unitid ~= nil) then 
		
				--data["groupId"] = spgg.bluestaticobj[spwnSoIdx].obj[1].unitid
				_data["unitId"] = spgg.redstaticobj[spwnSoIdx].obj[1].unitid
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  redstaticobj unitId with ReuseID : ' .. _data.unitId)
				end
			end

			if (spgg.ReuseUnitNames == true) then
					_soNewName = _soPrevName
			else
				
					if (spgg.useMIST == true) and (mist ~= nil) then
						_soNewName = "Static Object #" .._unitId.. " Red"
					else

						_soNewName = "Static Object NM #" .. spgg.noMistCountUnit .. " Red"
						
					end -- of if (spgg.useMIST == true) and (mist ~= nil) then
					
			end -- of if (spgg.ReuseUnitNames == true) then

		
			
			_data["country"] = _uCountry
			_data["name"] = _soNewName
			
			--_soNewName = "Static Object #" .._unitId.. " Red"
			--_data.units[1]["name"] = _soNewName .. '-1-1'
			--_data.units[1]["type"] = _soType
			--_data.units[1]["heading"] = _soHdg
			--_data.units[1]["category"] = _soCategory
			
			
			coalition.addStaticObject(_uCountry, _data)	
			--mist.dynAddStatic(_data)
		
		
			if (ctld ~= nil) then
			
				if spgg.saveCtldCrates == true then
			
					if (ctld.slingLoad == true) and (ctld.enableCrates == true) then
						
						_data["canCargo"] = true
						
						if (_soType == ctld.spawnableCratesModel_sling.type) then
							env.error('ctld.spawnableCratesModel_sling.type : ' .. ctld.spawnableCratesModel_sling.shape_name)
							_data["shape_name"] = ctld.spawnableCratesModel_sling.shape_name
							
							local _crateType = ctld.crateLookupTable[tostring(_uWeight)]
							-- local _coaId = 2
							if _coaId == 1 then
								ctld.spawnedCratesRED[_soNewName] = {}
								ctld.spawnedCratesRED[_soNewName] =_crateType
								env.info('-- Readded : ' .._soNewName.. ' - to  ctld.spawnedCratesRED!')
							else
								ctld.spawnedCratesBLUE[_soNewName] = {}
								ctld.spawnedCratesBLUE[_soNewName] = _crateType
								env.info('-- Readded : ' .._soNewName.. ' - to  ctld.spawnedCratesBLUE!')
							end
							
						end
						
					elseif (ctld.slingLoad == false) and (ctld.enableCrates == true) then
					
						if (_soType == ctld.spawnableCratesModel_load.type) then
							env.error('ctld.spawnableCratesModel_load.type : ' .. ctld.spawnableCratesModel_load.shape_name)
							_data["shape_name"] = ctld.spawnableCratesModel_load.shape_name
							
							local _crateType = ctld.crateLookupTable[tostring(_uWeight)]
							-- local _coaId = 2
							if _coaId == 1 then
								ctld.spawnedCratesRED[_soNewName] = {}
								ctld.spawnedCratesRED[_soNewName] =_crateType
								 env.info('-- Readded : ' .._soNewName.. ' - to  ctld.spawnedCratesRED!')
							else
								ctld.spawnedCratesBLUE[_soNewName] = {}
								ctld.spawnedCratesBLUE[_soNewName] = _crateType
								env.info('-- Readded : ' .._soNewName.. ' - to  ctld.spawnedCratesBLUE!')
							end
							
						end
					end
			
				end -- of if spgg.saveCtldCrates == true then
				
			end -- of if (ctld ~= nil) then
		
			if (spgg.showEnvinfo == true) then
				env.info("-- SPGG :  Load Red Static Object type : " .. _soType .. " - Category: " .. _soCategory .. " - Index : " .. spwnSoIdx .. " - GroupID : " .. _groupId .. " - unitID : " .. _unitId .. " - New Name : " .. _soNewName)
			end
		
		
			if (ctld ~= nil) then
			
				-- Check if CTLD has base building Enabled
				if (ctld.enabledFOBBuilding ~= nil) then
		
					if (ctld.enabledFOBBuilding == true) then
		
						--table.insert(ctld.logisticUnits, _soNewName)



						if (ctld.logisticUnits ~= nil) and (spgg.logisticUnits ~= nil) then
			
							for i = 1, #spgg.logisticUnits do
				
								if (_soPrevName ~= nil) then
					
									if (spgg.logisticUnits[i].name == _soPrevName) then
						
							
										if spgg.findValue(ctld.logisticUnits, _soNewName) then
							
										else
											
											if (spgg.showEnvinfo == true) then
												env.info("-- SPGG :  Load Red Static Object type in to ctld.logisticUnits : " .. _soType .. " - Category: " .. _soCategory .. " - Index : " .. spwnSoIdx .. " - GroupID : " .. _groupId .. " - unitID : " .. _unitId)
											end
											table.insert(ctld.logisticUnits, _soNewName)
								
										end -- end of: if spgg.findValue(ctld.logisticUnits, _soNewName) then

							
									end -- end of: if (spgg.logisticUnits[i].name == _soPrevName) then
						
								end -- end of: if (_soPrevName ~= nil) then
					
							end -- end of: for i = 1, #spgg.logisticUnits do
				
						end -- end of: if (ctld.logisticUnits ~= nil) and (spgg.logisticUnits ~= nil) then

						
						
						
						
						if (ctld.troopPickupAtFOB == true) then
							--table.insert(ctld.builtFOBS, _soNewName)
							
							
							
							if (ctld.builtFOBS ~= nil) and (spgg.builtFOBS ~= nil) then
			
								for i = 1, #spgg.builtFOBS do
				
									if (_soPrevName ~= nil) then
					
										if (spgg.builtFOBS[i].name == _soPrevName) then
						
							
											if spgg.findValue(ctld.builtFOBS, _soNewName) then
							
											else
							
												if (spgg.showEnvinfo == true) then
													env.info("-- SPGG :  Load Red Static Object type in to ctld.builtFOBS : " .. _soType .. " - Category: " .. _soCategory .. " - Index : " .. spwnSoIdx .. " - GroupID : " .. _groupId .. " - unitID : " .. _unitId)
												end
												table.insert(ctld.builtFOBS, _soNewName)
								
											end -- end of: if spgg.findValue(ctld.builtFOBS, _soNewName) then

							
										end -- end of: if (spgg.builtFOBS[i].name == _soPrevName) then
						
									end -- end of: if (_soPrevName ~= nil) then
					
								end -- end of: for i = 1, #spgg.builtFOBS do
				
							end -- end of: if (ctld.builtFOBS ~= nil) and (spgg.builtFOBS ~= nil) then
							
							
							
							
							
						end -- end of: if (ctld.troopPickupAtFOB == true) then
		
					end -- end of: if (ctld.enabledFOBBuilding == true) then
		
				end -- end of: if (ctld.enabledFOBBuilding ~= nil) then
				
				
				
			end -- end of if (ctld ~= nil) then
			
			
	
		end  -- end of for spwnSoIdx = 1, #spgg.redstaticobj do

	end -- end of if (spgg ~= nil) and (spgg.redstaticobj ~= nil) then
	
end -- of function spgg.spawnRedStaticObject()








function spgg.spawnNeutralStaticObject()


	local _coaId = 0
	
	
		
	env.info('-- SPGG :  - Coalition NEUTRAL : Spawning Static Objects')
			
		

	if (spgg ~= nil) and (spgg.neutralstaticobj ~= nil) then

	

		for spwnSoIdx = 1, #spgg.neutralstaticobj do


			local _unitId = 0
			local _groupId = 0
			
			spgg.noMistCountGrp = spgg.noMistCountGrp + 1 
			spgg.noMistCountUnit = spgg.noMistCountUnit + 1
			
			
			if (spgg.useMIST == true) and (mist ~= nil) then
				_unitId = mist.getNextGroupId()
				_groupId = mist.getNextGroupId()
			end
			

			
			local _soType		= spgg.neutralstaticobj[spwnSoIdx].obj[1].type or ''
			
			local _soCategory		= spgg.neutralstaticobj[spwnSoIdx].obj[1].category or 1
			
			local _soPrevName	= spgg.neutralstaticobj[spwnSoIdx].obj[1].name or ''
			local _soCoordX		= spgg.neutralstaticobj[spwnSoIdx].obj[1].x or 0
			local _soCoordY		= spgg.neutralstaticobj[spwnSoIdx].obj[1].y or 0
			local _soHdg		= spgg.neutralstaticobj[spwnSoIdx].obj[1].heading or 0
			local _uCountry		= spgg.neutralstaticobj[spwnSoIdx].obj[1].country or 81
			local _uWeight		= spgg.neutralstaticobj[spwnSoIdx].obj[1].mass or 0
	
	
			local _data = {
				
				["category"] = _soCategory,
				["type"] = _soType,
				--["unitId"] = _unitId,
				["y"] = _soCoordY,
				["x"] = _soCoordX,
				["canCargo"] = false,
				["heading"] = _soHdg,
				--["groupId"] = _groupId,
				
			}

			if (spgg.useMIST == true) and (mist ~= nil) then
		
				--_data["groupId"] = _groupId
				_data["unitId"] = _unitId
				--_data.units[1]["unitId"] = _unitId
				
		
			end
			
			if (spgg.ReuseID == true) and (spgg.neutralstaticobj[spwnSoIdx].obj[1].unitid ~= nil) then 
		
				--data["groupId"] = spgg.bluestaticobj[spwnSoIdx].obj[1].unitid
				_data["unitId"] = spgg.neutralstaticobj[spwnSoIdx].obj[1].unitid
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  neutralstaticobj unitId with ReuseID : ' .. _data.unitId)
				end
			end

			if (spgg.ReuseUnitNames == true) then
					_soNewName = _soPrevName
			else
				
					if (spgg.useMIST == true) and (mist ~= nil) then
						_soNewName = "Static Object #" .._unitId.. " Neutral"
					else

						_soNewName = "Static Object NM #" .. spgg.noMistCountUnit .. " Neutral"
						
					end -- of if (spgg.useMIST == true) and (mist ~= nil) then
					
			end -- of if (spgg.ReuseUnitNames == true) then

		
			
			_data["country"] = _uCountry
			_data["name"] = _soNewName
			
			--_soNewName = "Static Object #" .._unitId.. " Neutral"
			--_data.units[1]["name"] = _soNewName .. '-1-1'
			--_data.units[1]["type"] = _soType
			--_data.units[1]["heading"] = _soHdg
			--_data.units[1]["category"] = _soCategory
			
			
			coalition.addStaticObject(_uCountry, _data)	
			--mist.dynAddStatic(_data)
		
	
		
		
		
			if (spgg.showEnvinfo == true) then
				env.info("-- SPGG :  Load Neutral Static Object type : " .. _soType .. " - Category: " .. _soCategory .. " - Index : " .. spwnSoIdx .. " - GroupID : " .. _groupId .. " - unitID : " .. _unitId .. " - New Name : " .. _soNewName)
			end
		
		
			if (ctld ~= nil) then
			
				-- Check if CTLD has base building Enabled
				if (ctld.enabledFOBBuilding ~= nil) then
		
					if (ctld.enabledFOBBuilding == true) then
		
						--table.insert(ctld.logisticUnits, _soNewName)



						if (ctld.logisticUnits ~= nil) and (spgg.logisticUnits ~= nil) then
			
							for i = 1, #spgg.logisticUnits do
				
								if (_soPrevName ~= nil) then
					
									if (spgg.logisticUnits[i].name == _soPrevName) then
						
							
										if spgg.findValue(ctld.logisticUnits, _soNewName) then
							
										else
											
											if (spgg.showEnvinfo == true) then
												env.info("-- SPGG :  Load Neutral Static Object type in to ctld.logisticUnits : " .. _soType .. " - Category: " .. _soCategory .. " - Index : " .. spwnSoIdx .. " - GroupID : " .. _groupId .. " - unitID : " .. _unitId)
											end
											table.insert(ctld.logisticUnits, _soNewName)
								
										end -- end of: if spgg.findValue(ctld.logisticUnits, _soNewName) then

							
									end -- end of: if (spgg.logisticUnits[i].name == _soPrevName) then
						
								end -- end of: if (_soPrevName ~= nil) then
					
							end -- end of: for i = 1, #spgg.logisticUnits do
				
						end -- end of: if (ctld.logisticUnits ~= nil) and (spgg.logisticUnits ~= nil) then

						
						
						
						
						if (ctld.troopPickupAtFOB == true) then
							--table.insert(ctld.builtFOBS, _soNewName)
							
							
							
							if (ctld.builtFOBS ~= nil) and (spgg.builtFOBS ~= nil) then
			
								for i = 1, #spgg.builtFOBS do
				
									if (_soPrevName ~= nil) then
					
										if (spgg.builtFOBS[i].name == _soPrevName) then
						
							
											if spgg.findValue(ctld.builtFOBS, _soNewName) then
							
											else
							
												if (spgg.showEnvinfo == true) then
													env.info("-- SPGG :  Load Neutral Static Object type in to ctld.builtFOBS : " .. _soType .. " - Category: " .. _soCategory .. " - Index : " .. spwnSoIdx .. " - GroupID : " .. _groupId .. " - unitID : " .. _unitId)
												end
												table.insert(ctld.builtFOBS, _soNewName)
								
											end -- end of: if spgg.findValue(ctld.builtFOBS, _soNewName) then

							
										end -- end of: if (spgg.builtFOBS[i].name == _soPrevName) then
						
									end -- end of: if (_soPrevName ~= nil) then
					
								end -- end of: for i = 1, #spgg.builtFOBS do
				
							end -- end of: if (ctld.builtFOBS ~= nil) and (spgg.builtFOBS ~= nil) then
							
							
							
							
							
						end -- end of: if (ctld.troopPickupAtFOB == true) then
		
					end -- end of: if (ctld.enabledFOBBuilding == true) then
		
				end -- end of: if (ctld.enabledFOBBuilding ~= nil) then
				
				
				
			end -- end of if (ctld ~= nil) then
			
			
	
		end  -- end of for spwnSoIdx = 1, #spgg.neutralstaticobj do

	end -- end of if (spgg ~= nil) and (spgg.neutralstaticobj ~= nil) then
	
end -- of function spgg.spawnNeutralStaticObject()













-- gpUnitSize , _unitType, _unitCoord.x, _unitCoord.z, _unitHdg, _uCountry
function spgg.spawnBlueSeaGroup()


	--env.info("-- Running SpawnBlueGroundGroup!")
	
	--local _coaId = 2
	env.info('-- SPGG :  - Coalition BLUE : Spawning Sea Forces')
	


	
if (spgg ~= nil) and (spgg.blueseagroups ~= nil) then	

	for spwnGpIdx = 1, #spgg.blueseagroups do


		local _unitId = 0
		local _groupId = 0
			
		spgg.noMistCountGrp = spgg.noMistCountGrp + 1 

		if (spgg.useMIST == true) and (mist ~= nil) then
			_groupId = mist.getNextGroupId()
		end

		local _isJtacAdd = false
		local _ctldjtacGroupName = ""
		local _ctldjtacUnit = ""

		
		local _prevGroupName = spgg.blueseagroups[spwnGpIdx].groupname or nil
		local _loadGrpName = ""
	
	
		if (spgg.ReuseUnitNames == true) then
					_loadGrpName = _prevGroupName
				else
				
					if (spgg.useMIST == true) and (mist ~= nil) then
						_loadGrpName = "BlueAiSeaGroup".. _groupId
					else
						_loadGrpName = "BlueAiSeaGroupNM".. spgg.noMistCountGrp
					end -- of if (spgg.useMIST == true) and (mist ~= nil) then
					
		end -- of if (spgg.ReuseUnitNames == true) then
	

		local _data = {

								["visible"] = false,
                                ["tasks"] = 
                                {
                                }, -- end of ["tasks"]
                                ["uncontrollable"] = false,
                                 
								["route"] =
								{
								
								},
								
                                --["groupId"] = _groupId,
                                ["hidden"] = false,
                                ["units"] = 
                                {
                                   								
							
								}, -- end of ["units"]
                            --["y"] = _uCoordZ1,
                            --["x"] = _uCoordX1,
                            ["name"] = _loadGrpName,
                            --["start_time"] = 0,
		} -- end of data

		
		if (spgg.useMIST == true) and (mist ~= nil) then 
		
			_data["groupId"] = _groupId
			--env.info('-- groupId with MIST: ' .. data.groupId)
		
		end
			
		if (spgg.ReuseID == true) and (spgg.blueseagroups[spwnGpIdx].groupid ~= nil) then 
		
			_data["groupId"] = spgg.blueseagroups[spwnGpIdx].groupid
			if (spgg.showEnvinfo == true) then
				env.info('-- SPGG :  blueseagroups groupId with ReuseID : ' .. _data.groupId)
			end
		end
		
		
		
			if (spgg.spawnGroupsAsSavedLateActivatedState == true) then
				
				if (spgg.blueseagroups[spwnGpIdx].lateActivation ~= nil) then 
					
					local _lateActivation = spgg.blueseagroups[spwnGpIdx].lateActivation
					
					if (_lateActivation == 1) then
						_data["lateActivation"] = true
						
						if (spgg.spawnVisibleInactive == true) then
							_data["visible"] = true
						end
						
					else
						
						_data["lateActivation"] = false
					end -- if (_lateActivation == 1) then
					
				end -- of if (spgg.blueseagroups[spwnGpIdx].lateActivation ~= nil) then
				
			end -- if (spgg.spawnGroupsAsSavedLateActivatedState == true) then
			
			
			
			-- Overrides spgg.spawnGroupsAsSavedLateActivatedState
			if (spgg.spawnAllGroupsAsInactive == true) then
				
				_data["lateActivation"] = true
				
				if (spgg.spawnVisibleInactive == true) then
					_data["visible"] = true
				end
				
			end

		
					
		for spwnUnitIdx = 1, #spgg.blueseagroups[spwnGpIdx].units do
                       

			spgg.noMistCountUnit = spgg.noMistCountUnit + 1

			if (spgg.useMIST == true) and (mist ~= nil) then
				_unitId = mist.getNextGroupId()
			end
			
			if (spgg.ReuseID == true) and (spgg.blueseagroups[spwnGpIdx].units[spwnUnitIdx].unitid ~= nil) then
				 
				_unitId 		= spgg.blueseagroups[spwnGpIdx].units[spwnUnitIdx].unitid
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  blueseagroups unitId with ReuseID : ' .. spgg.blueseagroups[spwnGpIdx].units[spwnUnitIdx].unitid)
				end
			end
			
			local _uType		= spgg.blueseagroups[spwnGpIdx].units[spwnUnitIdx].type or ''
			local _uName		= spgg.blueseagroups[spwnGpIdx].units[spwnUnitIdx].name or ''
			local _uskill		= spgg.blueseagroups[spwnGpIdx].units[spwnUnitIdx].skill or ''
			local _uCoordX		= spgg.blueseagroups[spwnGpIdx].units[spwnUnitIdx].x or 0
			local _uCoordY		= spgg.blueseagroups[spwnGpIdx].units[spwnUnitIdx].y or 0
			local _uHdg			= spgg.blueseagroups[spwnGpIdx].units[spwnUnitIdx].heading or 0
			_uCountry			= spgg.blueseagroups[spwnGpIdx].units[spwnUnitIdx].country or 80
			
			
			_data.route = {
			
				["spans"] = 
				{
				}, -- end of ["spans"]
				["points"] = 
				{
					[1] = 
					{
						["alt"] = 59,
						["type"] = "Turning Point",
						["ETA"] = 0,
						["alt_type"] = "BARO",
						["formation_template"] = "",
						["y"] = _uCoordY,
						["x"] = _uCoordX,
						["ETA_locked"] = true,
						["speed"] = 0,
						["action"] = "Turning Point",
						["task"] = 
                        {
                            ["id"] = "ComboTask",
                            ["params"] = 
                            {
                                ["tasks"] = 
                                    {
                                    }, -- end of ["tasks"]
                            }, -- end of ["params"]
                        }, -- end of ["task"]
						["speed_locked"] = true,
					}, -- end of [1]
				}, -- end of ["points"]
	
			}


			if (spgg.ReuseUnitNames == true) then
					newUnitName = _uName
				else
				
					if (spgg.useMIST == true) and (mist ~= nil) then
						newUnitName = "BlueAiSeaUnit".. _unitId
					else
						newUnitName = "BlueAiSeaUnitNM".. spgg.noMistCountUnit
						--env.info("-- Red Unit Name:  " .. newUnitName)
					end -- of if (spgg.useMIST == true) and (mist ~= nil) then
					
			end -- of if (spgg.ReuseUnitNames == true) then


			_data.units[spwnUnitIdx] = {
			
					["type"] = _uType,
					--["unitId"] = _unitId,
					["skill"] = _uskill,
					["y"] = _uCoordY,
					["x"] = _uCoordX,
					["name"] = newUnitName,
					["heading"] = _uHdg,
			
			}
			
			
			_data["name"] = _loadGrpName

			if (spgg.useMIST == true) and (mist ~= nil) then
				_data.units[spwnUnitIdx]["unitId"] = _unitId
			end -- of if (spgg.useMIST == true) and (mist ~= nil) then

			if (spgg.ReuseID == true) and (spgg.blueseagroups[spwnGpIdx].units[spwnUnitIdx].unitid ~= nil) then
				 
				_data.units[spwnUnitIdx]["unitId"] = _unitId
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  blueseagroups unitid with ReuseID : ' .. _unitId)
				end
			end

			
			if (spgg.showEnvinfo == true) then
				env.info("-- SPGG :  Load Blue Sea unit type : " .. _uType .. " - Index : " .. spwnGpIdx .. " - GroupID : " .. _groupId .. " - unitID : " .. _unitId)
			end
					   
		
				
		end -- end of for spwnUnitIdx = 1, #spgg.blueseagroups[spwnGpIdx].units do
		
		
			coalition.addGroup(_uCountry, Group.Category.SHIP, _data)	

			
					
			
			
		--env.info('-- Spawning Group')
			
	end
									
				
				


	end -- end of if (spgg ~= nil) and (spgg.blueseagroups ~= nil) then	

end -- of function spgg.spawnBlueSeaGroup()







-- gpUnitSize , _unitType, _unitCoord.x, _unitCoord.z, _unitHdg, _uCountry
function spgg.spawnRedSeaGroup()


	--env.info("-- Running SpawnRedGroundGroup!")
	
	--local _coaId = 2
	env.info('-- SPGG :  - Coalition RED : Spawning Sea Forces')
	


	
if (spgg ~= nil) and (spgg.redseagroups ~= nil) then	

	for spwnGpIdx = 1, #spgg.redseagroups do


		local _unitId = 0
		local _groupId = 0
			
		spgg.noMistCountGrp = spgg.noMistCountGrp + 1 

		if (spgg.useMIST == true) and (mist ~= nil) then
			_groupId = mist.getNextGroupId()
		end

		local _isJtacAdd = false
		local _ctldjtacGroupName = ""
		local _ctldjtacUnit = ""

		
		local _prevGroupName = spgg.redseagroups[spwnGpIdx].groupname or nil
		local _loadGrpName = ""
	
	
		if (spgg.ReuseUnitNames == true) then
					_loadGrpName = _prevGroupName
				else
				
					if (spgg.useMIST == true) and (mist ~= nil) then
						_loadGrpName = "RedAiSeaGroup".. _groupId
					else
						_loadGrpName = "RedAiSeaGroupNM".. spgg.noMistCountGrp
					end -- of if (spgg.useMIST == true) and (mist ~= nil) then
					
		end -- of if (spgg.ReuseUnitNames == true) then
	

		local _data = {

								["visible"] = false,
                                ["tasks"] = 
                                {
                                }, -- end of ["tasks"]
                                ["uncontrollable"] = false,
                                 
								["route"] =
								{
								
								},
								
                                --["groupId"] = _groupId,
                                ["hidden"] = false,
                                ["units"] = 
                                {
                                   								
							
								}, -- end of ["units"]
                            --["y"] = _uCoordZ1,
                            --["x"] = _uCoordX1,
                            ["name"] = _loadGrpName,
                            --["start_time"] = 0,
		} -- end of data

		if (spgg.useMIST == true) and (mist ~= nil) then 
		
			_data["groupId"] = _groupId
			--env.info('-- groupId with MIST: ' .. data.groupId)
		
		end
			
		if (spgg.ReuseID == true) and (spgg.redseagroups[spwnGpIdx].groupid ~= nil) then 
		
			_data["groupId"] = spgg.redseagroups[spwnGpIdx].groupid
			if (spgg.showEnvinfo == true) then
				env.info('-- SPGG :  redseagroups groupId with ReuseID : ' .. _data.groupId)
			end
		end
		
		
		
			if (spgg.spawnGroupsAsSavedLateActivatedState == true) then
				
				if (spgg.redseagroups[spwnGpIdx].lateActivation ~= nil) then 
					
					local _lateActivation = spgg.redseagroups[spwnGpIdx].lateActivation
					
					if (_lateActivation == 1) then
						_data["lateActivation"] = true
						
						if (spgg.spawnVisibleInactive == true) then
							_data["visible"] = true
						end
						
					else
						
						_data["lateActivation"] = false
					end -- if (_lateActivation == 1) then
					
				end -- of if (spgg.redseagroups[spwnGpIdx].lateActivation ~= nil) then
				
			end -- if (spgg.spawnGroupsAsSavedLateActivatedState == true) then
			
			
			
			-- Overrides spgg.spawnGroupsAsSavedLateActivatedState
			if (spgg.spawnAllGroupsAsInactive == true) then
				
				_data["lateActivation"] = true
				
				if (spgg.spawnVisibleInactive == true) then
					_data["visible"] = true
				end
				
			end

		
		
		
		for spwnUnitIdx = 1, #spgg.redseagroups[spwnGpIdx].units do
                       

			spgg.noMistCountUnit = spgg.noMistCountUnit + 1

			if (spgg.useMIST == true) and (mist ~= nil) then
				_unitId = mist.getNextGroupId()
			end
			
			if (spgg.ReuseID == true) and (spgg.redseagroups[spwnGpIdx].units[spwnUnitIdx].unitid ~= nil) then
				 
				_unitId 		= spgg.redseagroups[spwnGpIdx].units[spwnUnitIdx].unitid
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  redseagroups unitId with ReuseID : ' .. spgg.redseagroups[spwnGpIdx].units[spwnUnitIdx].unitid)
				end
			end
			
			local _uType		= spgg.redseagroups[spwnGpIdx].units[spwnUnitIdx].type or ''
			local _uName		= spgg.redseagroups[spwnGpIdx].units[spwnUnitIdx].name or ''
			local _uskill		= spgg.redseagroups[spwnGpIdx].units[spwnUnitIdx].skill or ''
			local _uCoordX		= spgg.redseagroups[spwnGpIdx].units[spwnUnitIdx].x or 0
			local _uCoordY		= spgg.redseagroups[spwnGpIdx].units[spwnUnitIdx].y or 0
			local _uHdg			= spgg.redseagroups[spwnGpIdx].units[spwnUnitIdx].heading or 0
			_uCountry			= spgg.redseagroups[spwnGpIdx].units[spwnUnitIdx].country or 81
			
			
			_data.route = {
			
				["spans"] = 
				{
				}, -- end of ["spans"]
				["points"] = 
				{
					[1] = 
					{
						["alt"] = 59,
						["type"] = "Turning Point",
						["ETA"] = 0,
						["alt_type"] = "BARO",
						["formation_template"] = "",
						["y"] = _uCoordY,
						["x"] = _uCoordX,
						["ETA_locked"] = true,
						["speed"] = 0,
						["action"] = "Turning Point",
						["task"] = 
                        {
                            ["id"] = "ComboTask",
                            ["params"] = 
                            {
                                ["tasks"] = 
                                    {
                                    }, -- end of ["tasks"]
                            }, -- end of ["params"]
                        }, -- end of ["task"]
						["speed_locked"] = true,
					}, -- end of [1]
				}, -- end of ["points"]
	
			}


			if (spgg.ReuseUnitNames == true) then
					newUnitName = _uName
				else
				
					if (spgg.useMIST == true) and (mist ~= nil) then
						newUnitName = "RedAiSeaUnit".. _unitId
					else
						newUnitName = "RedAiSeaUnitNM".. spgg.noMistCountUnit
						--env.info("-- Red Unit Name:  " .. newUnitName)
					end -- of if (spgg.useMIST == true) and (mist ~= nil) then
					
			end -- of if (spgg.ReuseUnitNames == true) then


			_data.units[spwnUnitIdx] = {
			
					["type"] = _uType,
					--["unitId"] = _unitId,
					["skill"] = _uskill,
					["y"] = _uCoordY,
					["x"] = _uCoordX,
					["name"] = newUnitName,
					["heading"] = _uHdg,
			
			}
			
			
			_data["name"] = _loadGrpName

			if (spgg.useMIST == true) and (mist ~= nil) then
				_data.units[spwnUnitIdx]["unitId"] = _unitId
			end -- of if (spgg.useMIST == true) and (mist ~= nil) then

			if (spgg.ReuseID == true) and (spgg.redseagroups[spwnGpIdx].units[spwnUnitIdx].unitid ~= nil) then
				 
				_data.units[spwnUnitIdx]["unitId"] = _unitId
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  redseagroups unitid with ReuseID : ' .. _unitId)
				end
			end

			
			if (spgg.showEnvinfo == true) then
				env.info("-- SPGG :  Load Red Sea unit type : " .. _uType .. " - Index : " .. spwnGpIdx .. " - GroupID : " .. _groupId .. " - unitID : " .. _unitId)
			end
					   
		
				
		end -- end of for spwnUnitIdx = 1, #spgg.redseagroups[spwnGpIdx].units do
		
		
			coalition.addGroup(_uCountry, Group.Category.SHIP, _data)	

			
					
			
			
		--env.info('-- Spawning Group')
			
	end
									
				
				


	end -- end of if (spgg ~= nil) and (spgg.redseagroups ~= nil) then	

end -- of function spgg.spawnRedSeaGroup()







-- gpUnitSize , _unitType, _unitCoord.x, _unitCoord.z, _unitHdg, _uCountry
function spgg.spawnNeutralSeaGroup()


	--env.info("-- Running SpawnNeutralGroundGroup!")
	
	--local _coaId = 2
	env.info('-- SPGG :  - Coalition NEUTRAL : Spawning Sea Forces')
	


	
if (spgg ~= nil) and (spgg.neutralseagroups ~= nil) then	

	for spwnGpIdx = 1, #spgg.neutralseagroups do


		local _unitId = 0
		local _groupId = 0
			
		spgg.noMistCountGrp = spgg.noMistCountGrp + 1 

		if (spgg.useMIST == true) and (mist ~= nil) then
			_groupId = mist.getNextGroupId()
		end

		local _isJtacAdd = false
		local _ctldjtacGroupName = ""
		local _ctldjtacUnit = ""

		
		local _prevGroupName = spgg.neutralseagroups[spwnGpIdx].groupname or nil
		local _loadGrpName = ""
	
	
		if (spgg.ReuseUnitNames == true) then
					_loadGrpName = _prevGroupName
				else
				
					if (spgg.useMIST == true) and (mist ~= nil) then
						_loadGrpName = "NeutralAiSeaGroup".. _groupId
					else
						_loadGrpName = "NeutralAiSeaGroupNM".. spgg.noMistCountGrp
					end -- of if (spgg.useMIST == true) and (mist ~= nil) then
					
		end -- of if (spgg.ReuseUnitNames == true) then
	

		local _data = {

								["visible"] = false,
                                ["tasks"] = 
                                {
                                }, -- end of ["tasks"]
                                ["uncontrollable"] = false,
                                 
								["route"] =
								{
								
								},
								
                                --["groupId"] = _groupId,
                                ["hidden"] = false,
                                ["units"] = 
                                {
                                   								
							
								}, -- end of ["units"]
                            --["y"] = _uCoordZ1,
                            --["x"] = _uCoordX1,
                            ["name"] = _loadGrpName,
                            --["start_time"] = 0,
		} -- end of data

		if (spgg.useMIST == true) and (mist ~= nil) then 
		
			_data["groupId"] = _groupId
			--env.info('-- groupId with MIST: ' .. data.groupId)
		
		end
			
		if (spgg.ReuseID == true) and (spgg.neutralseagroups[spwnGpIdx].groupid ~= nil) then 
		
			_data["groupId"] = spgg.neutralseagroups[spwnGpIdx].groupid
			if (spgg.showEnvinfo == true) then
				env.info('-- SPGG :  neutralseagroups groupId with ReuseID : ' .. _data.groupId)
			end
		end
		
		
		if (spgg.spawnGroupsAsSavedLateActivatedState == true) then
				
				if (spgg.neutralseagroups[spwnGpIdx].lateActivation ~= nil) then 
					
					local _lateActivation = spgg.neutralseagroups[spwnGpIdx].lateActivation
					
					if (_lateActivation == 1) then
						_data["lateActivation"] = true
						
						if (spgg.spawnVisibleInactive == true) then
							_data["visible"] = true
						end
						
					else
						
						_data["lateActivation"] = false
					end -- if (_lateActivation == 1) then
					
				end -- of if (spgg.neutralseagroups[spwnGpIdx].lateActivation ~= nil) then
				
			end -- if (spgg.spawnGroupsAsSavedLateActivatedState == true) then
			
			
			
			-- Overrides spgg.spawnGroupsAsSavedLateActivatedState
			if (spgg.spawnAllGroupsAsInactive == true) then
				
				_data["lateActivation"] = true
				
				if (spgg.spawnVisibleInactive == true) then
					_data["visible"] = true
				end
				
			end
		
					
		for spwnUnitIdx = 1, #spgg.neutralseagroups[spwnGpIdx].units do
                       

			spgg.noMistCountUnit = spgg.noMistCountUnit + 1

			if (spgg.useMIST == true) and (mist ~= nil) then
				_unitId = mist.getNextGroupId()
			end
			
			if (spgg.ReuseID == true) and (spgg.neutralseagroups[spwnGpIdx].units[spwnUnitIdx].unitid ~= nil) then
				 
				_unitId 		= spgg.neutralseagroups[spwnGpIdx].units[spwnUnitIdx].unitid
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  neutralseagroups unitId with ReuseID : ' .. spgg.neutralseagroups[spwnGpIdx].units[spwnUnitIdx].unitid)
				end
			end
			
			local _uType		= spgg.neutralseagroups[spwnGpIdx].units[spwnUnitIdx].type or ''
			local _uName		= spgg.neutralseagroups[spwnGpIdx].units[spwnUnitIdx].name or ''
			local _uskill		= spgg.neutralseagroups[spwnGpIdx].units[spwnUnitIdx].skill or ''
			local _uCoordX		= spgg.neutralseagroups[spwnGpIdx].units[spwnUnitIdx].x or 0
			local _uCoordY		= spgg.neutralseagroups[spwnGpIdx].units[spwnUnitIdx].y or 0
			local _uHdg			= spgg.neutralseagroups[spwnGpIdx].units[spwnUnitIdx].heading or 0
			_uCountry			= spgg.neutralseagroups[spwnGpIdx].units[spwnUnitIdx].country or 81
			
			
			_data.route = {
			
				["spans"] = 
				{
				}, -- end of ["spans"]
				["points"] = 
				{
					[1] = 
					{
						["alt"] = 59,
						["type"] = "Turning Point",
						["ETA"] = 0,
						["alt_type"] = "BARO",
						["formation_template"] = "",
						["y"] = _uCoordY,
						["x"] = _uCoordX,
						["ETA_locked"] = true,
						["speed"] = 0,
						["action"] = "Turning Point",
						["task"] = 
                        {
                            ["id"] = "ComboTask",
                            ["params"] = 
                            {
                                ["tasks"] = 
                                    {
                                    }, -- end of ["tasks"]
                            }, -- end of ["params"]
                        }, -- end of ["task"]
						["speed_locked"] = true,
					}, -- end of [1]
				}, -- end of ["points"]
	
			}


			if (spgg.ReuseUnitNames == true) then
					newUnitName = _uName
				else
				
					if (spgg.useMIST == true) and (mist ~= nil) then
						newUnitName = "NeutralAiSeaUnit".. _unitId
					else
						newUnitName = "NeutralAiSeaUnitNM".. spgg.noMistCountUnit
						--env.info("-- Neutral Unit Name:  " .. newUnitName)
					end -- of if (spgg.useMIST == true) and (mist ~= nil) then
					
			end -- of if (spgg.ReuseUnitNames == true) then


			_data.units[spwnUnitIdx] = {
			
					["type"] = _uType,
					--["unitId"] = _unitId,
					["skill"] = _uskill,
					["y"] = _uCoordY,
					["x"] = _uCoordX,
					["name"] = newUnitName,
					["heading"] = _uHdg,
			
			}
			
			
			_data["name"] = _loadGrpName

			if (spgg.useMIST == true) and (mist ~= nil) then
				_data.units[spwnUnitIdx]["unitId"] = _unitId
			end -- of if (spgg.useMIST == true) and (mist ~= nil) then

			if (spgg.ReuseID == true) and (spgg.neutralseagroups[spwnGpIdx].units[spwnUnitIdx].unitid ~= nil) then
				 
				_data.units[spwnUnitIdx]["unitId"] = _unitId
				if (spgg.showEnvinfo == true) then
				env.info('-- SPGG :  neutralseagroups unitid with ReuseID : ' .. _unitId)
				end
			end

			
			if (spgg.showEnvinfo == true) then
				env.info("-- SPGG :  Load Neutral Sea unit type : " .. _uType .. " - Index : " .. spwnGpIdx .. " - GroupID : " .. _groupId .. " - unitID : " .. _unitId)
			end
					   
		
				
		end -- end of for spwnUnitIdx = 1, #spgg.neutralseagroups[spwnGpIdx].units do
		
		
			coalition.addGroup(_uCountry, Group.Category.SHIP, _data)	

			
					
			
			
		--env.info('-- Spawning Group')
			
	end
									
				
				


	end -- end of if (spgg ~= nil) and (spgg.redseagroups ~= nil) then	

end -- of function spgg.spawnNeutralSeaGroup()










function spgg.findAndAddSamSystems()

env.info('-- SPGG : Running spgg.findAndAddSamSystems')

-- spgg.tblPrevSamSystems[i] = { ["oldSamGroupName"] = _prevGroupName, ["newSamGroupName"] = _grpName, ["systemName"] = _systemName }

	if (spgg.tblPrevSamSystems ~= nil)  then
			
				
				
				
				for _groupName, _hawkDetails in pairs(spgg.tblPrevSamSystems) do
				

					for i = 1, #_hawkDetails do
				
						if (_groupName ~= nil) and (_hawkDetails ~= nil) then
						
						local _oldGrpName = _hawkDetails[i].oldSamGroupName
						local _newGrpName = _hawkDetails[i].newSamGroupName
						
							
							if spgg.findValue(ctld.completeAASystems, _newGrpName) then
							
								env.info('-- SPGG :  ctld.completeAASystems - Found : '.. _newGrpName)
							
							else
								
								env.info('-- SPGG :  ctld.completeAASystems - Did not find, adding to ctld.completeAASystems : '.. _newGrpName)

								ctld.completeAASystems[_newGrpName] = spgg.LoadAASystemDetails(_oldGrpName)
									
								
							end
								
							
						
						
						
						end -- end of if (_prevGroupName ~= nil) then
					
					end
					
					
				end -- end of for i = 1, #spgg.bluetroops do
				
				
				
				
				
			end -- end of if (ctld.droppedTroopsBLUE ~= nil) and (spgg.bluetroops ~= nil) then





end




function spgg.LoadAASystemDetails(_oldSAMGrpName)

	local _SAMDetails = {}

	if (spgg.tblPrevSamSystems ~= nil)  then
			
				for _groupName, _hawkDetails in pairs(spgg.tblPrevSamSystems) do
				
					if (_groupName ~= nil) then
			
						for i = 1, #_hawkDetails do
		

						
						
							if (_oldSAMGrpName == _groupName) then
								

								local _type = _hawkDetails[i].Type
								local _name = _hawkDetails[i].newUnitName
								local _system = _hawkDetails[i].systemName
						

								
								local _point = {

									["x"] = _hawkDetails[i].pointX,
									["y"] = _hawkDetails[i].pointY,
									["z"] = _hawkDetails[i].pointZ,
								}
								
								if (spgg.showEnvinfo == true) then
									env.info('-- SPGG :  tblPrevSamSystems Adding Hawk name : '.. _hawkDetails[i].newUnitName)
								end
								--table.insert(_SAMDetails, { point = _point, unit = _type, name = _name, system = _system})
								
								--table.insert(_SAMDetails, { point = _point, unit = _type, name = _name, system = ctld.AASystemTemplate.name[_system]})
								
								for i = 1, #ctld.AASystemTemplate do
							
									if ctld.AASystemTemplate[i].name == _system then
									
										if (spgg.showEnvinfo == true) then
											env.info('-- SPGG :  CTLD completeAASystems Temp TEST : '.. ctld.AASystemTemplate[i].name)
										end
										--table.insert(_SAMTestTable, { tname = _groupName, system = ctld.AASystemTemplate.name[_hDetails]})
										--table.insert(_SAMTestTable, { tname = _groupName, system = ctld.AASystemTemplate[i] })
										table.insert(_SAMDetails, { point = _point, unit = _type, name = _name, system = ctld.AASystemTemplate[i] })
									end
								end 
								
								
						
							end
							
							
							
						end
				
					end

						
				end
					
	end
	
	
	return _SAMDetails
	
end




function spgg.loadCtldCrates()

	env.info('-- SPGG : Running spgg.loadCtldCrates')


	if (spgg.spawnedCratesBLUE ~= nil)  then
		ctld.spawnedCratesBLUE = spgg.spawnedCratesBLUE
	end
	
	if (spgg.spawnedCratesRED ~= nil)  then
		ctld.spawnedCratesRED = spgg.spawnedCratesRED
	end

	if (spgg.droppedFOBCratesBLUE ~= nil)  then
		ctld.droppedFOBCratesBLUE = spgg.droppedFOBCratesBLUE
	end
	
	if (spgg.droppedFOBCratesRED ~= nil)  then
		ctld.droppedFOBCratesRED = spgg.droppedFOBCratesRED
	end



end





env.info('-- SPGG :  - Loaded Function for Loading Groups!')






-----------------------------------
-- SAVE FUNCTIONS --
-----------------------------------




env.info('-- SPGG :  - Loading Function for Save!')





function spgg.findIfValueInArray(whichArray, itemName)
		for currentIndex = 1, #whichArray do
			if string.match(itemName, '^' .. whichArray[currentIndex] .. '.*$') then
				
						--env.info('-- Found in '.. whichArray[currentIndex] ..' : ' .. itemName)
				
								--Sends true back if value exist
				return true
			end
		end
end

function spgg.findValue(whichArray, itemName)
		for currentIndex = 1, #whichArray do
			if whichArray[currentIndex] == itemName then
								--Sends true back if value exist
				return true
			end
		end
end




function spgg.save_time(time)
  local days = math.floor(time/86400)
  local hours = math.floor(math.mod(time, 86400)/3600)
  local minutes = math.floor(math.mod(time,3600)/60)
  local seconds = math.floor(math.mod(time,60))
  return string.format("%d_%02d_%02d_%02d",days,hours,minutes,seconds)
end










function spgg.save()

	env.info('-- ')
	env.info('-- SPGG :  - Running spgg.save()')

	spgg.grpBlueCount = 0
	spgg.grpRedCount = 0
	spgg.soBlueCount = 0
	spgg.soRedCount = 0
	spgg.grpBlueSeaCount = 0
	spgg.grpRedSeaCount = 0
	
	spgg.grpNeutralCount = 0
	spgg.soNeutralCount = 0
	spgg.grpNeutralSeaCount = 0
	


	wFile = io.open(spgg.saveFilePath, 'w')
	


	wFile:write('spgg = spgg or {}' .. '\n')
	
	wFile:write('spgg.initalstart = false\n')
	
	wFile:write('spgg.bluegroups = spgg.bluegroups or {}' .. '\n')
	wFile:write('spgg.redgroups = spgg.redgroups or {}' .. '\n')
	
	wFile:write('spgg.bluestaticobj = spgg.bluestaticobj or {}' .. '\n')
	wFile:write('spgg.redstaticobj = spgg.redstaticobj or {}' .. '\n')
	
	wFile:write('spgg.blueseagroups = spgg.blueseagroups or {}' .. '\n')
	wFile:write('spgg.redseagroups = spgg.redseagroups or {}' .. '\n')
	
	wFile:write('spgg.neutralgroups = spgg.neutralgroups or {}' .. '\n')
	wFile:write('spgg.neutralgroups = spgg.neutralgroups or {}' .. '\n')
	
	wFile:write('spgg.neutralstaticobj = spgg.neutralstaticobj or {}' .. '\n')
	wFile:write('spgg.neutralstaticobj = spgg.neutralstaticobj or {}' .. '\n')
	
	wFile:write('spgg.neutralseagroups = spgg.neutralseagroups or {}' .. '\n')
	wFile:write('spgg.neutralseagroups = spgg.neutralseagroups or {}' .. '\n')
	
	
	
	
	if (spgg.enableBackupSaves == true) then
	
		--Backup save file
		local _timesave = timer.getTime()
		local _dhmsTimeleft = spgg.save_time(_timesave)
		wBackupFile = io.open(spgg.backupPath .. spgg.saveFilename .. "_inGameTime_" .. _dhmsTimeleft .. '.lua', 'w')
		
		wBackupFile:write('spgg = spgg or {}' .. '\n')
		wBackupFile:write('spgg.initalstart = false\n')
		wBackupFile:write('spgg.bluegroups = spgg.bluegroups or {}' .. '\n')
		wBackupFile:write('spgg.redgroups = spgg.redgroups or {}' .. '\n')
		wBackupFile:write('spgg.bluestaticobj = spgg.bluestaticobj or {}' .. '\n')
		wBackupFile:write('spgg.redstaticobj = spgg.redstaticobj or {}' .. '\n')
		wBackupFile:write('spgg.blueseagroups = spgg.blueseagroups or {}' .. '\n')
		wBackupFile:write('spgg.redseagroups = spgg.redseagroups or {}' .. '\n')
		
		wBackupFile:write('spgg.neutralgroups = spgg.neutralgroups or {}' .. '\n')
		wBackupFile:write('spgg.neutralgroups = spgg.neutralgroups or {}' .. '\n')
	
		wBackupFile:write('spgg.neutralstaticobj = spgg.neutralstaticobj or {}' .. '\n')
		wBackupFile:write('spgg.neutralstaticobj = spgg.neutralstaticobj or {}' .. '\n')
	
		wBackupFile:write('spgg.neutralseagroups = spgg.neutralseagroups or {}' .. '\n')
		wBackupFile:write('spgg.neutralseagroups = spgg.neutralseagroups or {}' .. '\n')

	end -- if (spgg.enableBackupSaves == true) then

	-----------------------------------
	-- Get Blue Coalition Forces	-------------------
	-----------------------------------
	for i, gp in pairs(coalition.getGroups(2, 2)) do

		local _GpName = Group.getName(gp)
		
		-- Only Save Activated Groups
		if (spgg.saveOnlyActiveGroups == true) then
			if (Group.getByName(_GpName):getUnit(1):isActive() == false) then
			
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  - OnlyActiveGroups - Excluded Blue Group : ' .. _GpName)
				end
				
				_GpName = nil
			end
		end
		
		if _GpName ~= nil then
		
				if (Group.getByName(_GpName) and Group.getByName(_GpName):getSize() > 0) and (Group.isExist(gp) == true) then
		
					
					if spgg.findIfValueInArray(spgg.excludeGroupNameTbl, _GpName) then
					
						-- Do nothing if it is excluded!
						
						if (spgg.showEnvinfo == true) then
							env.info('-- SPGG :  - Excluded Blue Group: ' .. _GpName)
						end
						
					else
						
						local _gpUnitSize = Group.getByName(_GpName):getSize()
						
						getGroupAndSave(2, _GpName, _gpUnitSize)
						
					
					end -- if (spgg.findValue(spgg.excludeGroupNameTbl, _GpName) ~= nil) then
		
		
				end
		
		
		end -- if _GpName =~ nil then
		
		
	end -- for i, gp in pairs(coalition.getGroups(2,2)) do







	-----------------------------------
	-- Get Red Coalition Forces	-------------------
	-----------------------------------
	for i, gp in pairs(coalition.getGroups(1, 2)) do

		local _GpName = Group.getName(gp)
		
		-- Only Save Activated Groups
		if (spgg.saveOnlyActiveGroups == true) then
			if (Group.getByName(_GpName):getUnit(1):isActive() == false) then
				
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  - OnlyActiveGroups - Excluded Red Group : ' .. _GpName)
				end
				
				_GpName = nil
			end
		end
		
		
		if _GpName ~= nil then
		
				if (Group.getByName(_GpName) and Group.getByName(_GpName):getSize() > 0) and (Group.isExist(gp) == true) then
		
		
		
					if spgg.findIfValueInArray(spgg.excludeGroupNameTbl, _GpName) then
					
						-- Do nothing if it is excluded!
						if (spgg.showEnvinfo == true) then
							env.info('-- SPGG :  - Excluded Red Group: ' .. _GpName)
						end
						
					else
						
						local _gpUnitSize = Group.getByName(_GpName):getSize()
						
						getGroupAndSave(1, _GpName, _gpUnitSize)
						
					
					end -- if (spgg.findValue(spgg.excludeGroupNameTbl, _GpName) ~= nil) then
		
		
				end
		
		
		end -- if _GpName =~ nil then
		
		
	end -- for i, gp in pairs(coalition.getGroups(2,2)) do




	-----------------------------------
	-- Get neutral Coalition Forces	-------------------
	-----------------------------------
	for i, gp in pairs(coalition.getGroups(0, 2)) do

		local _GpName = Group.getName(gp)
		
		-- Only Save Activated Groups
		if (spgg.saveOnlyActiveGroups == true) then
			if (Group.getByName(_GpName):getUnit(1):isActive() == false) then
				
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  - OnlyActiveGroups - Excluded neutral Group : ' .. _GpName)
				end
				
				_GpName = nil
			end
		end
		
		
		if _GpName ~= nil then
		
				if (Group.getByName(_GpName) and Group.getByName(_GpName):getSize() > 0) and (Group.isExist(gp) == true) then
		
		
		
					if spgg.findIfValueInArray(spgg.excludeGroupNameTbl, _GpName) then
					
						-- Do nothing if it is excluded!
						if (spgg.showEnvinfo == true) then
							env.info('-- SPGG :  - Excluded neutral Group: ' .. _GpName)
						end
						
					else
						
						local _gpUnitSize = Group.getByName(_GpName):getSize()
						
						getGroupAndSave(0, _GpName, _gpUnitSize)
						
					
					end -- if (spgg.findValue(spgg.excludeGroupNameTbl, _GpName) ~= nil) then
		
		
				end
		
		
		end -- if _GpName =~ nil then
		
		
	end -- for i, gp in pairs(coalition.getGroups(0,2)) do






	-----------------------------------
	-- Static Blue Objects	-----------
	-----------------------------------

	

	for i, so in pairs(coalition.getStaticObjects(2)) do

		
		local _SoName = StaticObject.getName(so)
		local _SoType = so:getTypeName()
 
 
		if _SoName ~= nil then
		
 
		
			if (StaticObject.getByName(_SoName)) and (StaticObject.isExist(so)) then
	 
				--trigger.action.outText("Exsist : " .._SoName , 10)
			
				if ( spgg.findValue(spgg.includeStaticObjectTypeTbl, _SoType)) then
			
					if (spgg.showEnvinfo == true) then
						env.info('-- SPGG :  - Found Blue Static Object : '.. _SoName.. ' - Type : ' .. _SoType)
					end
					
			
					if ( spgg.findIfValueInArray(spgg.excludeGroupNameTbl, _SoName)) then
					
						if (spgg.showEnvinfo == true) then
							env.info('-- SPGG :  - Excluded Blue Static Object - On Excluded Name List: ' .. _SoName.. ' - Type : ' .. _SoType)
						end
						
					else --if (_SoName == string.match(_SoName, '^Deployed FOB.*$')) then
					
						if (spgg.showEnvinfo == true) then
							env.info('-- SPGG :  - Saving Blue Static Object: '.. _SoName .. ' - Type : ' .. _SoType)
						end
						
							
						getObjectAndSave(2, _SoName)
						
						
						
					end
				end
			
			
			else
				env.error('-- SPGG :  Static Blue Object not saved, could not get group info! : ' .. _SoName)
			end

		end -- if _SoName ~= nil then

	end -- for i, so in pairs(coalition.getStaticObjects(1)) do



	-----------------------------------
	-- Static Red Objects	-------------------
	-----------------------------------

	
	for i, so in pairs(coalition.getStaticObjects(1)) do


		local _SoName = StaticObject.getName(so)
		local _SoType = so:getTypeName()

 
		if _SoName ~= nil then 
 
		
			if (StaticObject.getByName(_SoName)) and (StaticObject.isExist(so)) then
	 
				
				if ( spgg.findValue(spgg.includeStaticObjectTypeTbl, _SoType)) then
			
					if (spgg.showEnvinfo == true) then
						env.info('-- SPGG :  - Found Red Static Object : '.. _SoName.. ' - Type : ' .. _SoType)
					end
					
			
					if ( spgg.findIfValueInArray(spgg.excludeGroupNameTbl, _SoName)) then
					
						if (spgg.showEnvinfo == true) then
							env.info('-- SPGG :  - Excluded Red Static Object - On Excluded Name List: ' .. _SoName.. ' - Type : ' .. _SoType)
						end
						

					else
					
						if (spgg.showEnvinfo == true) then
							env.info('-- SPGG :  - Saving Red Static Object: '.. _SoName .. ' - Type : ' .. _SoType)
						end
									
								
						getObjectAndSave(1, _SoName)
						
						
						
					end
				end
			
			else
				env.error('-- SPGG :  Static Red Object not saved, could not get group info! : ' .. _SoName)
			end

		end -- if _SoName ~= nil then 

	end -- for i, so in pairs(coalition.getStaticObjects(1)) do
	
	
	
	
	-----------------------------------
	-- Static neutral Objects	-------------------
	-----------------------------------


	for i, so in pairs(coalition.getStaticObjects(0)) do


		local _SoName = StaticObject.getName(so)
		local _SoType = so:getTypeName()

 
		if _SoName ~= nil then 
 
		
			if (StaticObject.getByName(_SoName)) and (StaticObject.isExist(so)) then
	 

				
				if ( spgg.findValue(spgg.includeStaticObjectTypeTbl, _SoType)) then
			
					if (spgg.showEnvinfo == true) then
						env.info('-- SPGG :  - Found neutral Static Object : '.. _SoName.. ' - Type : ' .. _SoType)
					end
					
			
					if ( spgg.findIfValueInArray(spgg.excludeGroupNameTbl, _SoName)) then
					
						if (spgg.showEnvinfo == true) then
							env.info('-- SPGG :  - Excluded neutral Static Object - On Excluded Name List: ' .. _SoName.. ' - Type : ' .. _SoType)
						end
						

					else
					
						if (spgg.showEnvinfo == true) then
							env.info('-- SPGG :  - Saving neutral Static Object: '.. _SoName .. ' - Type : ' .. _SoType)
						end
									
								
						getObjectAndSave(0, _SoName)
						
						
						
					end
				
				
				end
			
			else
				env.error('-- SPGG :  Static neutral Object not saved, could not get group info! : ' .. _SoName)	
			
			end

		end -- if _SoName ~= nil then 

	end -- for i, so in pairs(coalition.getStaticObjects(0)) do





	-----------------------------------
	-- Sea Blue Groups	---------------
	-----------------------------------
	for i, gp in pairs(coalition.getGroups(2, 3)) do

		local _GpName = Group.getName(gp)
		
		-- Only Save Activated Groups
		if (spgg.saveOnlyActiveGroups == true) then
			if (Group.getByName(_GpName):getUnit(1):isActive() == false) then
			
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  - OnlyActiveGroups - Excluded Sea Blue Group : ' .. _GpName)
				end
				
				_GpName = nil
			end
		end
		
		
		if _GpName ~= nil then
		
				if (Group.getByName(_GpName) and Group.getByName(_GpName):getSize() > 0) and (Group.isExist(gp) == true) then
		
					
					if spgg.findIfValueInArray(spgg.excludeGroupNameTbl, _GpName) then
					
						-- Do nothing if it is excluded!
						
						if (spgg.showEnvinfo == true) then
							env.info('-- SPGG :  - Excluded Blue Sea Group: ' .. _GpName)
						end
						
					else
						
						local _gpUnitSize = Group.getByName(_GpName):getSize()
						
						getSeaGroupAndSave(2, _GpName, _gpUnitSize)
						
					
					end -- if (spgg.findValue(spgg.excludeGroupNameTbl, _GpName) ~= nil) then
		
				else
					env.error('-- SPGG :  Sea Blue Groups not saved, could not get group info! : ' .. _GpName)
				end
		
		
		end -- if _GpName =~ nil then
		
		
	end -- for i, gp in pairs(coalition.getGroups(2,2)) do







	-----------------------------------
	-- Sea Red Groups	---------------
	-----------------------------------
	for i, gp in pairs(coalition.getGroups(1, 3)) do

		local _GpName = Group.getName(gp)

		-- Only Save Activated Groups
		if (spgg.saveOnlyActiveGroups == true) then
			if (Group.getByName(_GpName):getUnit(1):isActive() == false) then
			
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  OnlyActiveGroups - Excluded Sea Red Group : ' .. _GpName)
				end
				
				_GpName = nil
			end
		end
		
		if _GpName ~= nil then
		
				if (Group.getByName(_GpName) and Group.getByName(_GpName):getSize() > 0) and (Group.isExist(gp) == true) then
		
		
		
					if spgg.findIfValueInArray(spgg.excludeGroupNameTbl, _GpName) then
					
						-- Do nothing if it is excluded!
						if (spgg.showEnvinfo == true) then
							env.info('-- SPGG :  Excluded Red Sea Group: ' .. _GpName)
						end
						
					else
						
						local _gpUnitSize = Group.getByName(_GpName):getSize()
						
						getSeaGroupAndSave(1, _GpName, _gpUnitSize)
						
					
					end -- if (spgg.findValue(spgg.excludeGroupNameTbl, _GpName) ~= nil) then
		
				else
					env.error('-- SPGG :  Sea Red Groups not saved, could not get group info! : ' .. _GpName)
				end
		
		
		end -- if _GpName =~ nil then
		
		
	end -- for i, gp in pairs(coalition.getGroups(2,2)) do
	



	-----------------------------------
	-- Sea neutral Groups	---------------
	-----------------------------------
	for i, gp in pairs(coalition.getGroups(0, 3)) do

		local _GpName = Group.getName(gp)

		-- Only Save Activated Groups
		if (spgg.saveOnlyActiveGroups == true) then
			if (Group.getByName(_GpName):getUnit(1):isActive() == false) then
			
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  OnlyActiveGroups - Excluded neutral Red Group : ' .. _GpName)
				end
				
				_GpName = nil
			end
		end
		
		if _GpName ~= nil then
		
				if (Group.getByName(_GpName) and Group.getByName(_GpName):getSize() > 0) and (Group.isExist(gp) == true) then
		
		
		
					if spgg.findIfValueInArray(spgg.excludeGroupNameTbl, _GpName) then
					
						-- Do nothing if it is excluded!
						if (spgg.showEnvinfo == true) then
							env.info('-- SPGG :  Excluded neutral Sea Group: ' .. _GpName)
						end
						
					else
						
						local _gpUnitSize = Group.getByName(_GpName):getSize()
						
						getSeaGroupAndSave(0, _GpName, _gpUnitSize)
						
					
					end -- if (spgg.findValue(spgg.excludeGroupNameTbl, _GpName) ~= nil) then
		
				else
					env.error('-- SPGG :  Sea neutral Groups not saved, could not get group info! : ' .. _GpName)
				end -- of if (Group.getByName(_GpName) and Group.getByName(_GpName):getSize() > 0) and (Group.isExist(gp) == true) then
		
		
		end -- if _GpName =~ nil then
		
		
	end -- for i, gp in pairs(coalition.getGroups(2,2)) do








	if (ctld ~= nil) then
		saveCtldTables()
	end

	

	wFile:close()
	wFile = nil
	
	
	if (spgg.enableBackupSaves == true) then
		wBackupFile:close()
		wBackupFile  = nil
	end -- if (spgg.enableBackupSaves == true) then
	

end -- end of function SPGGSave(coalitionId)




function getObjectAndSave(coalitionId, soName)

	
		
	if coalitionId ~= nil then
		
				
		local _sObject = StaticObject.getByName(soName)
		local _sObjectId = _sObject:getID()
		
		local _soType = _sObject:getTypeName()
		
		local _soDataTable = StaticObject.getDescByName(soName) 
		
		local _soCategory =  _soDataTable.category
		
		local _soWeight =  StaticObject.getCargoWeight(_sObject)
		
		--env.info('-- SPGG :  Type: ' .. _soType .. ' - Category: ' .. _soDataTable.category)
		
		local _soCoord = _sObject:getPoint()
			
		local _sCoalition = _sObject:getCoalition()
		
		_soPoss = _sObject:getPosition()
		local _soHdg = math.atan2(_soPoss.x.z, _soPoss.x.x)
		
		local _country = _sObject:getCountry()
		
		local _writeStringTbl
		local _writeStringGrp
		local _writeStringObj
		local _gCount
		
		if coalitionId == 1 then
		
			spgg.soRedCount = spgg.soRedCount +1
			_gCount = spgg.soRedCount
		
			_writeStringTbl = 'spgg.redstaticobj'
			
			--wFile:write('spgg.redstaticobj['..spgg.soRedCount..'] = { ["obj"] = {} }' .. '\n')
	
			--wFile:write('spgg.redstaticobj['..spgg.soRedCount..'].obj[1] = { ["type"] = "' .. _soType .. '", ["category"] = "' .. _soCategory .. '", ["name"] = "' .. soName .. '", ["unitid"] = "' .._sObjectId.. '" , ["x"] = ' .. _soCoord.x .. ', ["y"] = ' .. _soCoord.z .. ', ["heading"] = ' .. _soHdg .. ', ["country"]= '.. _country ..', }' .. '\n')
		
			if (spgg.showEnvinfo == true) then
				env.info('-- SPGG :  Saving Red Object: '.. _unitName .. ' - Type: ' .. _unitType .. ' - Coordinates X: ' .. _unitCoord.x .. ' - Y: ' .. _unitCoord.y .. ' - Z: ' .. _unitCoord.z .. ' - Heading: ' .. _unitHdg .. ' - Country: '.. _country .. ' - UnitId: ' .. _sObjectId .. " - Weight: " .. _soWeight)
			end
		
			
		
		elseif coalitionId == 2 then
		
			spgg.soBlueCount = spgg.soBlueCount +1
			_gCount = spgg.soBlueCount
		
			_writeStringTbl = 'spgg.bluestaticobj'
			
			--wFile:write('spgg.bluestaticobj['..spgg.soBlueCount..'] = { ["obj"] = {} }' .. '\n')
			
			--wFile:write('spgg.bluestaticobj['..spgg.soBlueCount..'].obj[1] = { ["type"] = "' .. _soType .. '", ["category"] = "' .. _soCategory .. '", ["name"] = "' .. soName .. '", ["unitid"] = "' .._sObjectId.. '" , ["x"] = ' .. _soCoord.x .. ', ["y"] = ' .. _soCoord.z .. ', ["heading"] = ' .. _soHdg .. ', ["country"]= '.. _country ..', }' .. '\n')

			if (spgg.showEnvinfo == true) then
				env.info('-- SPGG :  Saving Blue Object: '.. _unitName .. ' - Type: ' .. _unitType .. ' - Coordinates X: ' .. _unitCoord.x .. ' - Y: ' .. _unitCoord.y .. ' - Z: ' .. _unitCoord.z .. ' - Heading: ' .. _unitHdg .. ' - Country: '.. _country .. ' - UnitId: ' .. _sObjectId .. " - Weight: " .. _soWeight)
			end


		elseif coalitionId == 0 then

			spgg.soNeutralCount = spgg.soNeutralCount +1
			_gCount = spgg.soNeutralCount
		
			_writeStringTbl = 'spgg.neutralstaticobj'
		
		else
		
			env.error('-- SPGG :  getGroupAndSave - Failed to get Group Coalition! : Unit: ' .. _unitName)
		
		end
	
		_writeStringGrp = _writeStringTbl.. '['.._gCount..'] = { ["obj"] = {} }'
		_writeStringObj = _writeStringTbl.. '['.._gCount..'].obj[1] = { ["type"] = "' .. _soType .. '", ["category"] = "' .. _soCategory .. '", ["name"] = "' .. soName .. '", ["unitid"] = "' .._sObjectId.. '" , ["x"] = ' .. _soCoord.x .. ', ["y"] = ' .. _soCoord.z .. ', ["heading"] = ' .. _soHdg .. ', ["country"]= '.. _country .. ', ["mass"]= '.. _soWeight ..', }'
		
		wFile:write(_writeStringGrp .. '\n')
		wFile:write(_writeStringObj .. '\n')
		
		--Backup
		if (spgg.enableBackupSaves == true) then
				
				wBackupFile:write(_writeStringGrp .. '\n')
				wBackupFile:write(_writeStringObj .. '\n')
			
		end -- if (spgg.enableBackupSaves == true) then
	
	end


end








function getGroupAndSave(coalitionId, gpName, gpUnitSize)


	if coalitionId ~= nil then
	
		local _gp = Group.getByName(gpName)
		local _grpId = _gp:getID()
		
		local _writeStringTbl
		local _writeStringGrpEnd
		local _writeStringGrp
		local _writeStringUnt
		local _gCount
		local uCount
		
		if coalitionId == 1 then
			
			spgg.grpRedCount = spgg.grpRedCount +1 
			_gCount = spgg.grpRedCount
			
			_writeStringTbl = 'spgg.redgroups'
			
						
		elseif coalitionId == 2 then
			
			spgg.grpBlueCount = spgg.grpBlueCount +1 
			_gCount = spgg.grpBlueCount
		
			_writeStringTbl = 'spgg.bluegroups'
			
					
		elseif coalitionId == 0 then
		
			spgg.grpNeutralCount = spgg.grpNeutralCount +1 
			_gCount = spgg.grpNeutralCount
		
			_writeStringTbl = 'spgg.neutralgroups'
		
		end -- if coalitionId == 2 then
		
		
		if (Group.getByName(gpName):getUnit(1):isActive() == true) then
			_writeStringGrpEnd = '", ["lateActivation"] = 0, ["units"] = {} }\n'
		elseif (Group.getByName(gpName):getUnit(1):isActive() == false) then
			_writeStringGrpEnd = '", ["lateActivation"] = 1, ["units"] = {} }\n'
		else
			_writeStringGrpEnd = '", ["lateActivation"] = 0, ["units"] = {} }\n'
		end
		

		_writeStringGrp = _writeStringTbl.. '['.._gCount..'] = { ["groupname"] = "' ..gpName.. '", ["groupid"] = "' .._grpId.. _writeStringGrpEnd
		wFile:write(_writeStringGrp)
		
		--Backup
		if (spgg.enableBackupSaves == true) then
				
				wBackupFile:write(_writeStringGrp .. '\n')
			
		end -- if (spgg.enableBackupSaves == true) then
		

		for uIndex = 1, gpUnitSize do
			
		
		
		
			local _Group = Group.getByName(gpName)
		
			
			local _unitName = _Group:getUnit(uIndex):getName()
			local _unitId = _Group:getUnit(uIndex):getID()
			
			local _unit = Unit.getByName(_unitName)
			local _unitType = _unit:getTypeName()
			
			local _unitCoord = _unit:getPoint()
			
			local _coalition = _Group:getCoalition()
				
					
			_unitPoss = _unit:getPosition()
			local _unitHdg = math.atan2(_unitPoss.x.z, _unitPoss.x.x)
			
			
			local _country = _unit:getCountry()
			
		
			if coalitionId == 1 then
		
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  Saving Red unit: '.. _unitName .. ' - Type: ' .. _unitType .. ' - Coordinates X: ' .. _unitCoord.x .. ' - Y: ' .. _unitCoord.y .. ' - Z: ' .. _unitCoord.z .. ' - Heading: ' .. _unitHdg .. ' - Country: '.. _country .. ' - GrpId: ' .. _grpId .. ' - UntId: ' .. _unitId )
				end
		
				_writeStringTbl = 'spgg.redgroups'
							
			elseif coalitionId == 2 then
		
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  Saving Blue unit: '.. _unitName .. ' - Type: ' .. _unitType .. ' - Coordinates X: ' .. _unitCoord.x .. ' - Y: ' .. _unitCoord.y .. ' - Z: ' .. _unitCoord.z .. ' - Heading: ' .. _unitHdg .. ' - Country: '.. _country .. ' - GrpId: ' .. _grpId .. ' - UntId: ' .. _unitId )
				end
				
				_writeStringTbl = 'spgg.bluegroups'
				
			elseif coalitionId == 0 then
		
		
				_writeStringTbl = 'spgg.neutralgroups'
				
			else
		
				if (spgg.showEnvinfo == true) then
				env.error('-- SPGG :  getGroupAndSave - Failed to get Group Coalition! : '.. gpName .. '- Unit: ' .. _unitName)
					-- No Neutral units
				end
				
		
			end
			
			
		
			_writeStringUnt = _writeStringTbl.. '['.._gCount..'].units['..uIndex..'] = { ["type"] = "' .. _unitType .. '", ["name"] = "' .. _unitName .. '", ["unitid"] = "' .._unitId.. '", ["skill"] = "Excellent", ["x"] = ' .. _unitCoord.x .. ', ["y"] = ' .. _unitCoord.z .. ', ["heading"] = ' .. _unitHdg .. ', ["playerCanDrive"] = true, ["country"]= '.. _country ..', }'
			wFile:write(_writeStringUnt .. '\n')
			
			--Backup
			if (spgg.enableBackupSaves == true) then
				
				wBackupFile:write(_writeStringUnt .. '\n')
			
			end -- if (spgg.enableBackupSaves == true) then
			
		
		end -- for uIndex = 1, gpUnitSize do

		

	end -- end of if coalitionId ~= nil then




	

end -- function getGroupAndSave(gpName, gpUnitSize)






function getSeaGroupAndSave(coalitionId, gpName, gpUnitSize)


	if coalitionId ~= nil then
	
	
		local _gp = Group.getByName(gpName)
		local _grpId = _gp:getID()
		local _writeStringGrpEnd
		local _writeStringTbl
		local _writeStringGrp
		local _writeStringUnt
		local _gCount
	
		if coalitionId == 1 then
			
			spgg.grpRedSeaCount = spgg.grpRedSeaCount +1 
			_gCount = spgg.grpRedSeaCount
			
			_writeStringTbl = 'spgg.redseagroups'
			
			

		elseif coalitionId == 2 then
			
			spgg.grpBlueSeaCount = spgg.grpBlueSeaCount +1 
			_gCount = spgg.grpBlueSeaCount
			
			_writeStringTbl = 'spgg.blueseagroups'
			
			
		elseif coalitionId == 0 then
		
			spgg.grpNeutralSeaCount = spgg.grpNeutralSeaCount +1 
			_gCount = spgg.grpNeutralSeaCount
			
			_writeStringTbl = 'spgg.neutralseagroups'
		
		else
			env.error('-- SPGG :  getSeaGroupAndSave - Failed to get Group Coalition! : '.. gpName)
		
		end


		
		if (Group.getByName(gpName):getUnit(1):isActive() == true) then
			_writeStringGrpEnd = '", ["lateActivation"] = 0, ["units"] = {} }\n'
		elseif (Group.getByName(gpName):getUnit(1):isActive() == false) then
			_writeStringGrpEnd = '", ["lateActivation"] = 1, ["units"] = {} }\n'
		else
			_writeStringGrpEnd = '", ["lateActivation"] = 0, ["units"] = {} }\n'
		end
		

		_writeStringGrp = _writeStringTbl.. '['.._gCount..'] = { ["groupname"] = "' ..gpName.. '", ["groupid"] = "' .._grpId.. _writeStringGrpEnd
		wFile:write(_writeStringGrp)
		
		--Backup
		if (spgg.enableBackupSaves == true) then
				
			wBackupFile:write(_writeStringGrp .. '\n')
			
		end -- if (spgg.enableBackupSaves == true) then


		for uIndex = 1, gpUnitSize do
			
		
		
		
			local _Group = Group.getByName(gpName)
		
			
			local _unitName = _Group:getUnit(uIndex):getName()
			local _unitId = _Group:getUnit(uIndex):getID()
			local _unit = Unit.getByName(_unitName)
			local _unitType = _unit:getTypeName()
			
			local _unitCoord = _unit:getPoint()
			
			local _coalition = _Group:getCoalition()
				
					
			_unitPoss = _unit:getPosition()
			local _unitHdg = math.atan2(_unitPoss.x.z, _unitPoss.x.x)
			
			
			local _country = _unit:getCountry()
			
		
			if coalitionId == 1 then
		
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  Saving Red Sea unit: '.. _unitName .. ' - Type: ' .. _unitType .. ' - Coordinates X: ' .. _unitCoord.x .. ' - Y: ' .. _unitCoord.y .. ' - Z: ' .. _unitCoord.z .. ' - Heading: ' .. _unitHdg .. ' - Country: '.. _country .. ' - GrpId: ' .. _grpId .. ' - UntId: ' .. _unitId )
				end
		
				_writeStringTbl = 'spgg.redseagroups'
			
			elseif coalitionId == 2 then
		
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  Saving Blue Sea unit: '.. _unitName .. ' - Type: ' .. _unitType .. ' - Coordinates X: ' .. _unitCoord.x .. ' - Y: ' .. _unitCoord.y .. ' - Z: ' .. _unitCoord.z .. ' - Heading: ' .. _unitHdg .. ' - Country: '.. _country .. ' - GrpId: ' .. _grpId .. ' - UntId: ' .. _unitId )
				end
				
				_writeStringTbl = 'spgg.blueseagroups'
				
			elseif coalitionId == 0 then
			
				_writeStringTbl = 'spgg.neutralseagroups'
			
			else
		
				if (spgg.showEnvinfo == true) then
					env.error('-- SPGG :  getSeaGroupAndSave - Failed to get Group Coalition! : '.. gpName .. '- Unit: ' .. _unitName)
					-- No Neutral units
				end
		
			end
			
			_writeStringUnt = _writeStringTbl.. '['.._gCount..'].units['..uIndex..'] = { ["type"] = "' .. _unitType .. '", ["name"] = "' .. _unitName .. '", ["unitid"] = "' .._unitId.. '", ["skill"] = "Excellent", ["x"] = ' .. _unitCoord.x .. ', ["y"] = ' .. _unitCoord.z .. ', ["heading"] = ' .. _unitHdg .. ', ["playerCanDrive"] = true, ["country"]= '.. _country ..', }'
			wFile:write(_writeStringUnt .. '\n')
			
			--Backup
			if (spgg.enableBackupSaves == true) then
				
				wBackupFile:write(_writeStringUnt .. '\n')
			
			end -- if (spgg.enableBackupSaves == true) then
			
		
		end -- for uIndex = 1, gpUnitSize do

		

	end -- end of if coalitionId ~= nil then




	

end -- function getGroupAndSave(gpName, gpUnitSize)






-- Transfere FOB table to next session
function saveCtldTables()

	if (spgg.showEnvinfo == true) then
		nv.info('-- SPGG :  Runnig saveCtldTables')
	end


	if (ctld ~= nil) then


		if (ctld.JTAC_dropEnabled ~= nil) then

			if (ctld.JTAC_dropEnabled == true) then
		
			
				-- ctld.JTAC_LIMIT_RED
				-- ctld.JTAC_LIMIT_BLUE
			
				-- ctld.droppedTroopsRED
				-- ctld.droppedTroopsBLUE
			
			
			
				if (spgg.showEnvinfo == true) then
					env.info('-- SPGG :  Saving JTAC limit parameters - RED :'.. ctld.JTAC_LIMIT_RED .. ' - BLUE: ' .. ctld.JTAC_LIMIT_BLUE)
				end
			
				if (ctld.JTAC_LIMIT_RED ~= nil) and (ctld.JTAC_LIMIT_BLUE ~= nil) then
					wFile:write('ctld.JTAC_LIMIT_RED = '.. ctld.JTAC_LIMIT_RED .. '\n')
					wFile:write('ctld.JTAC_LIMIT_BLUE = '.. ctld.JTAC_LIMIT_BLUE .. '\n')
				
					--backup
					if (spgg.enableBackupSaves == true) then
						wBackupFile:write('ctld.JTAC_LIMIT_RED = '.. ctld.JTAC_LIMIT_RED .. '\n')
						wBackupFile:write('ctld.JTAC_LIMIT_BLUE = '.. ctld.JTAC_LIMIT_BLUE .. '\n')
					end -- if (spgg.enableBackupSaves == true) then
					
				end
				
			
			
			end	 -- end of if (ctld.JTAC_dropEnabled == true) then
		
		end	-- end of if (ctld.JTAC_dropEnabled ~= nil) then
	
	
		if (ctld.droppedTroopsRED ~= nil) and (ctld.droppedTroopsBLUE ~= nil) then

	
			wFile:write('spgg.redtroops = spgg.redtroops or {}' .. '\n')
			wFile:write('spgg.bluetroops = spgg.bluetroops or {}' .. '\n')
		
			--backup
			if (spgg.enableBackupSaves == true) then
				wBackupFile:write('spgg.redtroops = spgg.redtroops or {}' .. '\n')
				wBackupFile:write('spgg.bluetroops = spgg.bluetroops or {}' .. '\n')
			end -- if (spgg.enableBackupSaves == true) then
	
	
			for i = 1, #ctld.droppedTroopsRED do
		
		
				
				wFile:write('spgg.redtroops['..i..'] = { ["name"] = "' .. ctld.droppedTroopsRED[i]..'" }' .. '\n')
			
				--backup
				if (spgg.enableBackupSaves == true) then
					wBackupFile:write('spgg.redtroops['..i..'] = { ["name"] = "' .. ctld.droppedTroopsRED[i]..'" }' .. '\n')
				end -- if (spgg.enableBackupSaves == true) then
				
			end
		
			for i = 1, #ctld.droppedTroopsBLUE do
		
		
				wFile:write('spgg.bluetroops['..i..'] = { ["name"] = "' .. ctld.droppedTroopsBLUE[i]..'" }' .. '\n')
			
				--backup
				if (spgg.enableBackupSaves == true) then
					wBackupFile:write('spgg.bluetroops['..i..'] = { ["name"] = "' .. ctld.droppedTroopsBLUE[i]..'" }' .. '\n')
				end -- if (spgg.enableBackupSaves == true) then
				
			end
	
	
	
		end -- end of if (ctld.droppedTroopsRED ~= nil) and (ctld.droppedTroopsBLUE ~= nil) then
		
		

		
		if (ctld.completeAASystems ~= nil) then
		
			spgg.SaveAASystemDetails()
		
		end -- end of if (ctld.completeAASystems ~= nil) then
		
	
	
		-- Save CTLD Logistic tables
		if (ctld.enabledFOBBuilding == true) then
		
		
			if (ctld.builtFOBS ~= nil) then
			
				wFile:write('spgg.builtFOBS = spgg.builtFOBS or {}' .. '\n')
				
				if (spgg.enableBackupSaves == true) then
					wBackupFile:write('spgg.builtFOBS = spgg.builtFOBS or {}' .. '\n')
				end -- if (spgg.enableBackupSaves == true) then
			
				
				for i = 1, #ctld.builtFOBS do
		
					wFile:write('spgg.builtFOBS['..i..'] = { ["name"] = "' .. ctld.builtFOBS[i]..'" }' .. '\n')
				
					--backup
					if (spgg.enableBackupSaves == true) then
						wBackupFile:write('spgg.builtFOBS['..i..'] = { ["name"] = "' .. ctld.builtFOBS[i]..'" }' .. '\n')
					end -- if (spgg.enableBackupSaves == true) then
					
				end -- end of: for i = 1, #ctld.builtFOBS do
			
			end -- end of: if (ctld.builtFOBS ~= nil) then
			
			
			
			if (ctld.logisticUnits ~= nil) then
			
				wFile:write('spgg.logisticUnits = spgg.logisticUnits or {}' .. '\n')
				
				if (spgg.enableBackupSaves == true) then
					wBackupFile:write('spgg.logisticUnits = spgg.logisticUnits or {}' .. '\n')
				end -- if (spgg.enableBackupSaves == true) then
				
				for i = 1, #ctld.logisticUnits do
		
					wFile:write('spgg.logisticUnits['..i..'] = { ["name"] = "' .. ctld.logisticUnits[i]..'" }' .. '\n')
				
					--backup
					if (spgg.enableBackupSaves == true) then
						wBackupFile:write('spgg.logisticUnits['..i..'] = { ["name"] = "' .. ctld.logisticUnits[i]..'" }' .. '\n')
					end -- if (spgg.enableBackupSaves == true) then
					
				end -- end of: for i = 1, #ctld.logisticUnits do
			
			end -- end of: if (ctld.logisticUnits ~= nil) then
			
			
		
			
		end -- end of: if (ctld.enabledFOBBuilding == true) then

		
		-- Save CTLD Crates tables
		if (spgg.saveCtldCrates == true) then
		
			
			-- _writeStringGrp = _writeStringTbl.. '['.._gCount..'] = { ["obj"] = {} }'
			-- _writeStringObj = _writeStringTbl.. '['.._gCount..'].obj[1] = { ["type"] = "' .. _soType .. '", ["category"] = "' .. _soCategory .. '", ["name"] = "' .. soName .. '", ["unitid"] = "' .._sObjectId.. '" , ["x"] = ' .. _soCoord.x .. ', ["y"] = ' .. _soCoord.z .. ', ["heading"] = ' .. _soHdg .. ', ["country"]= '.. _country .. ', ["mass"]= '.. _soWeight ..', }'
		
			-- wFile:write(_writeStringGrp .. '\n')
			-- wFile:write(_writeStringObj .. '\n')
			-- wFile:write('spgg.spawnedCratesBLUE = spgg.spawnedCratesBLUE or {}' .. '\n')
				
				
			-- if (spgg.enableBackupSaves == true) then
					-- wBackupFile:write('spgg.spawnedCratesBLUE = spgg.spawnedCratesBLUE or {}' .. '\n')
			-- end
			local _crates = ctld.spawnedCratesBLUE
			local _writeStringTbl = 'spgg.spawnedCratesBLUE'
			wFile:write(_writeStringTbl .. " = " .. _writeStringTbl .. ' or {}' .. '\n')
			
			for _crateName, _details in pairs(_crates) do
				
				wFile:write(_writeStringTbl .. '["'.._crateName..'"] = ' .. spgg.dumpTbl(_details) .. '\n')
				-- env.info('Name: ' .. _crateName)
				-- -- env.info('Details: ' .. _details["mass
				-- env.info('Details: ' .. spgg.dumpTbl(_details))
	 
			end
			_crates = ctld.spawnedCratesRED
			_writeStringTbl = 'spgg.spawnedCratesRED'
			wFile:write(_writeStringTbl .. " = " .. _writeStringTbl .. ' or {}' .. '\n')
			
			for _crateName, _details in pairs(_crates) do
				
				wFile:write(_writeStringTbl .. '["'.._crateName..'"] = ' .. spgg.dumpTbl(_details) .. '\n')
				-- env.info('Name: ' .. _crateName)
				-- -- env.info('Details: ' .. _details["mass
				-- env.info('Details: ' .. spgg.dumpTbl(_details))
	 
			end
			
			_crates = ctld.droppedFOBCratesBLUE
			_writeStringTbl = 'spgg.droppedFOBCratesBLUE'
			wFile:write(_writeStringTbl .. " = " .. _writeStringTbl .. ' or {}' .. '\n')
			
			for _crateName, _details in pairs(_crates) do
				
				wFile:write(_writeStringTbl .. '["'.._crateName..'"] = ' .. spgg.dumpTbl(_details) .. '\n')
				-- env.info('Name: ' .. _crateName)
				-- -- env.info('Details: ' .. _details["mass
				-- env.info('Details: ' .. spgg.dumpTbl(_details))
	 
			end
			
			_crates = ctld.droppedFOBCratesRED
			_writeStringTbl = 'spgg.droppedFOBCratesRED'
			wFile:write(_writeStringTbl .. " = " .. _writeStringTbl .. ' or {}' .. '\n')
			
			for _crateName, _details in pairs(_crates) do
				
				wFile:write(_writeStringTbl .. '["'.._crateName..'"] = ' .. spgg.dumpTbl(_details) .. '\n')
				-- env.info('Name: ' .. _crateName)
				-- -- env.info('Details: ' .. _details["mass
				-- env.info('Details: ' .. spgg.dumpTbl(_details))
	 
			end
			
			
			
			
			-- for i = 1, #ctld.spawnedCratesBLUE do
		
					-- wFile:write('spgg.spawnedCratesBLUE['..i..'] = { ["name"] = "' .. ctld.spawnedCratesBLUE[i]..'" }' .. '\n')
				
					-- --backup
					-- if (spgg.enableBackupSaves == true) then
						-- wBackupFile:write('spgg.spawnedCratesBLUE['..i..'] = { ["name"] = "' .. ctld.spawnedCratesBLUE[i]..'" }' .. '\n')
					-- end -- if (spgg.enableBackupSaves == true) then
					
			-- end -- end of: for i = 1, #ctld.logisticUnits do
			
			-- ctld.spawnedCratesRED[_name] =_crateType
			-- ctld.spawnedCratesBLUE[_name] = _crateType
		end

	end -- end of if (ctld ~= nil) then


end



function spgg.SaveAASystemDetails()

	
	wFile:write('spgg.completeAASystems = {} \n')
	if (spgg.enableBackupSaves == true) then
		wBackupFile:write('spgg.completeAASystems = {} \n')
	end

	for _groupName, _hawkDetails in pairs(ctld.completeAASystems) do

		if (_hawkDetails ~= nil) then


			
			wFile:write('spgg.completeAASystems["' .. _groupName .. '"] = {} \n')
			
			if (spgg.enableBackupSaves == true) then
				wBackupFile:write('spgg.completeAASystems["' .. _groupName .. '"] = {} \n')
			end -- if (spgg.enableBackupSaves == true) then
			
			--spgg.completeAASystems[_groupName] = {}
			
			for i = 1, #_hawkDetails do
		
				wFile:write('table.insert(spgg.completeAASystems["'.. _groupName ..'"], {unit= "'.. _hawkDetails[i].unit ..'", name= "'.. _hawkDetails[i].name .. '", pointX= "'.. _hawkDetails[i].point.x .. '", pointY= "'.. _hawkDetails[i].point.y .. '", pointZ= "'.. _hawkDetails[i].point.z .. '", system= "'.. _hawkDetails[i].system.name ..  '" }) \n')
					
				
				if (spgg.enableBackupSaves == true) then
					wBackupFile:write('table.insert(spgg.completeAASystems["'.. _groupName ..'"], {unit= "'.. _hawkDetails[i].unit ..'", name= "'.. _hawkDetails[i].name .. '", pointX= "'.. _hawkDetails[i].point.x .. '", pointY= "'.. _hawkDetails[i].point.y .. '", pointZ= "'.. _hawkDetails[i].point.z .. '", system= "'.. _hawkDetails[i].system.name ..  '" }) \n')
				end -- if (spgg.enableBackupSaves == true) then
			
			end

			

		end

	end


end









-- Loop saving

spgg.loopSaveActive = "1"

function CheckSaveStatus(ourArgument, time)
 -- Do things to check, use ourArgument (which is the scheduleFunction's second argument)
 if ourArgument == 9999 and spgg.loopSaveActive == "1" then

	-- Text saving
	--trigger.action.outText("Timed: Saving Ground Forces" , 10)
	env.info('-- SPGG :  Timed: Saving Ground Forces - Start')	
	
	-- Save Ground Forces

	spgg.save()
	
	env.info('-- SPGG :  Timed: Saving Ground Forces - End')
	
	-- Keep going
   return time + spgg.Savetime
 else
 
 	-- Text saving
	--trigger.action.outText("Timed Last: Saving Ground Forces" , 10)
	 
	env.info('-- SPGG :  Timed: Saving schedule has been canceled')
	 
	-- Save Ground Forces

	--spgg.save()
	
	--env.info('-- SPGG :  Timed: Saving Ground Forces - End - Timer Schedual ended')
	
	-- That's it we're done looping
   return nil
 end
end


-- Remove content of save file and stop scheduleFunction save. Used to reset your Mission to initial state before dcs server restart.
function spgg.clearSavefile()

	spgg.loopSaveActive = "0"
	
	
	env.info('-- SPGG : clear savefile : Reset file -' .. spgg.loadDir .. spgg.saveFilename)

	-- Reset SPGG Persistent save file
	spgg.clearwFile = io.open(spgg.loadDir .. spgg.saveFilename, 'w')


	spgg.clearwFile:write('')


	spgg.clearwFile:close()
	spgg.clearwFile = nil
	
	env.info('-- SPGG : clear savefile: Save file cleard!')

end


function spgg.dumpTbl(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. '"' ..spgg.dumpTbl(v) .. '"' .. ','
      end
      return s .. '} \n'
   else
      return tostring(o)
   end
end



spgg.Savetime = 60 * spgg.Savetime

timer.scheduleFunction(CheckSaveStatus, 9999, timer.getTime() + spgg.Savetime)




env.info('-- SPGG :  Loaded Function for Save!')
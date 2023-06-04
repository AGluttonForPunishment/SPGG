# SPGG
Simple Persistent Ground Groups
<br>
<br>
Save Ground and Naval groups in DCS and load them after restart or next time you play a mission. No repacking of .miz files.
<br>
<br>






<br>
<br>
<br>

**** Changelog ****
<br>
<br>
<br>

Update v023 - Hotfix 1:
- Fixed: SPGG.lua"]:3492: attempt to index field 'wFile' (a nil value)



Update v023:
- Added spawning with selected type of livery's for ground units

<br>
<br>
<br>

Update v022:

- Added saving of Group and Unit Id of units. You can now spawn them back with the same ID. (See: spgg.ReuseID)
(WARNING : Do not turn on if you have a old save file. Start the mission first with "false", let spgg save. Then change this to "true")
- Included the Natural groups in saving process. See readme for commands.
- Changes to save function to use less code.

<br>
<br>
<br>

Update v021:

- Changed the script from 3 files to 1 file. (**Installation is changed, please see the installation part in the readme!**)
- Updated example mission files with drawings and briefing text.
- Made Backup saving optional. (Default off)
- Added check if save file is present or not. You can now just delete the save file if you want to reset the save file.

<br>
<br>
<br>

Update v020:

- Added FLAG (spgginitalstart) and global script variable (spgg.initalstart) to detect if mission has loaded a save file. *1
(See last trigger in Example .miz files)
- Added detection if MIST is used to avoid "spgg.useMIST = true" forcing the use of MIST if not loaded.
- Updated example mission files!
- Refurbished the readme file! Now contains troubleshooting section (95% of errors users get).
- Changed back to the old folder name. "SPGG" for easy understanding of the folder to use. (Added examples how the folder path work in SPGG.lua)
- Updated spelling errors in titles of the Readme. (hotfix)
- Updated the Install section with examples. (hotfix)

*1: Can be used by mission makes to avoid spawning units that should only spawn at initial mission start and not just after a restart of the server/mission.
If upgrading from a previous version with a save file in use and populated, please add "spgg.initalstart = false" to your save file (SPGG_savefile.lua)

<br>
<br>
<br>
Update v019 - Hotfix1:

- Fixed schedule function for saving not reading the parameter "spgg.Savetime" in SPGG.lua


<br>
<br>
<br>
Update v019:<br>

- Added parameter to not use MIST: spgg.useMIST (DATA link (EPLRS) is not added to groups if this is false)
- Change: Static objects also uses "spgg.ReuseGroupNames" and "spgg.ReuseUnitNames" if "true"
- Fix: Some env.info message was not filterd if "spgg.showEnvinfo = false"

<br>
<br>
<br>
Update v018:<br>

- Added parameter to exclude deactivated groups: spgg.saveOnlyActiveGroups
- Change: Renamed the parameter "_ShowEnvinfo" to "spgg.showEnvinfo"

<br>
<br>
<br>
Update v017:<br>

- Added: Saving of CTLD FOB and logistic table to support saving of any FOB type that you have selected in CTLD. <br>
- Added: New function to clear/empty the save file<br>
See readme how to add function: spgg.clearSavefile()<br>
- Change: Now support any type of static object by type name. (Before every static object whould become a FOB)<br>
- Change: Changed name of save function and spawn functions (see readme)<br>

Old save files will not create FOB's for CTLD. (See example save file to see format of logistic/FOB saving table) 

<br>
<br>
<br>
Update v016:<br>

- Added: Saving of CTLD Samsite table to support repair of samsites after mission/server restart. <br>
See readme how to add function: spgg.findAndAddSamSystems()
- FIX: Difference in code for blue and red spawn.



<br>
<br>
Update v015:<br>

- Added: Reuse of Unit names for Land and Sea units.
- Added: Saving of category for Static Objects.


<br>
<br>
Update v014:<br>
- Added: Save Sea/Naval units<br>
- Added : Now you can reuse group names<br>
- Added : Better logging of spawning units<br>

<br>
<br>

Hotfix on v013:
- Fixed reuse of unitid's on static objects.

<br>

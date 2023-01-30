# SPGG
Simple Persistent Ground Groups
<br>
<br>
Save Ground and Naval groups in DCS and load them after restart or next time you play a mission. No repacking of .miz files.
<br>
<br>



[Readme SPGG.pdf](https://github.com/AGluttonForPunishment/SPGG/files/10529452/Readme.SPGG.pdf)




<br>
<br>
<br>

**** Changelog ****

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

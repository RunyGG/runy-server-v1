-- FILE: mapEditorScriptingExtension_c.lua
-- PURPOSE: Prevent the map editor feature set being limited by what MTA can load from a map file by adding a script file to maps
-- VERSION: RemoveWorldObjects (v1) AutoLOD (v2) BreakableObjects (v1)

function setLODsClient(lodTbl)
	for model in pairs(lodTbl) do
		engineSetModelLODDistance(model, 300)
	end
end
addEvent("setLODsClient", true)
addEventHandler("setLODsClient", resourceRoot, setLODsClient)


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- CFG
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

cfg = {}

cfg.arenas =
{
	{"files/arenas/AIM.col", "files/arenas/AIM.dff", "files/arenas/AIM.txd", 1861},
	{"", "", "files/arenas/AIM.txd", 1598},
	
	{"files/arenas/NPC.col", "files/arenas/NPC.dff", "files/arenas/NPC.txd", 1862},

}

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- DOWNLOAD - OBJETOS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function startdownloadobj()
	for _,data in ipairs(cfg.objetos) do
		if not fileExists(string.gsub(data[1], ".dff", "")..".fx") and not fileExists(string.gsub(data[2], ".txd", "").."2.fx") then
			downloadFile(data[1])
			downloadFile(data[2])
		else
			engineImportTXD(engineLoadTXD(string.gsub(data[2], ".txd", "")..".fx"), data[3])
			engineReplaceModel(engineLoadDFF(string.gsub(data[1], ".dff", "").."2.fx", 0), data[3])
			engineSetModelLODDistance(data[3], 300)
		end
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), startdownloadobj)

-------------------------------------------

function downloadcompobj(file)
	for _,data in ipairs(cfg.objetos) do
		if file == data[1] or file == data[2] then
			if data[1] then
				fileRename(data[1], string.gsub(data[1], ".dff", "").."2.fx")
				fileRename(data[2], string.gsub(data[2], ".txd", "")..".fx")
				engineImportTXD(engineLoadTXD(string.gsub(data[2], ".txd", "")..".fx"), data[3])
				engineReplaceModel(engineLoadDFF(string.gsub(data[1], ".dff", "").."2.fx", 0), data[3])
				engineSetModelLODDistance(data[3], 300)
			end
		end
	end
end
addEventHandler("onClientFileDownloadComplete", getResourceRootElement(getThisResource()), downloadcompobj)

-----------------------------------------------

function startdownloadarena()
	for _,data in ipairs(cfg.arenas) do
		engineImportTXD(engineLoadTXD(data[3]), data[4]) 

		engineReplaceCOL(engineLoadCOL(data[1]), data[4]) 

		engineReplaceModel(engineLoadDFF(data[2], data[4]), data[4]) 
		engineSetModelLODDistance(data[4], 300)
	
		if fileExists(data[1]) then fileDelete(data[1]) end 
		if fileExists(data[2]) then fileDelete(data[2]) end 
	end
end
addEventHandler('onClientResourceStart', resourceRoot, startdownloadarena)
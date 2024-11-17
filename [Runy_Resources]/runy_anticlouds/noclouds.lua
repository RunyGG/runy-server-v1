--////////////////////////////[[The following is On Join]]\\\\\\\\\\\\\\\\\\\\\\\\\\\--

function disableClouds ()
    setCloudsEnabled ( false )
end

addEventHandler ( "onPlayerJoin", getRootElement(), disableClouds )

--//////////////[[The following is On Resource Start (This Resource)]]\\\\\\\\\\\\\\\--
 
function scriptStart()
    setCloudsEnabled ( false )
end

addEventHandler ("onResourceStart",getResourceRootElement(getThisResource()),scriptStart)

--//////////////[[The following is On Resource Start (EVERY resource)]]\\\\\\\\\\\\\\--
--//////////////[[The following is the 1.0 Upate.]]\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--

function scriptRestart()
	setTimer ( scriptStart, 4000, 1 )
end

addEventHandler("onResourceStart",getRootElement(),scriptRestart)

---------------------------------------------------------------------------------------
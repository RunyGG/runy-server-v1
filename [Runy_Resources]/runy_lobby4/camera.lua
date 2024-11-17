cameraPosition = {
	{2181.6395019531, 385.24499511719, 64.162902832031, 2181.8552246094, 384.25244140625, 64.125213623047, 2204, 240, 60, 0, 0, 50, 1000000000000000},
	{2181.6395019531, 385.24499511719, 64.923301696777, 2177.4829101562, 361.60260009766, 64.96, 2204, 240, 60, 0, -760, 50, 2500}
}
activeCamera = 1
cameraTick = 0

function renderCamera()
	local renderCameraTick = getTickCount()
	local cameraProgress = renderCameraTick - cameraTick
	local cX, cY, cZ = interpolateBetween ( 
	cameraPosition[activeCamera][1], cameraPosition[activeCamera][2], cameraPosition[activeCamera][3],
	cameraPosition[activeCamera][4], cameraPosition[activeCamera][5], cameraPosition[activeCamera][6],
	cameraProgress/cameraPosition[activeCamera][13], "Linear"
)

local rX, rY, rZ = interpolateBetween ( 
	cameraPosition[activeCamera][7], cameraPosition[activeCamera][8], cameraPosition[activeCamera][9],
	cameraPosition[activeCamera][10], cameraPosition[activeCamera][11], cameraPosition[activeCamera][12],
	cameraProgress/cameraPosition[activeCamera][13], "Linear"
)
setCameraMatrix(cX, cY, cZ, rX, rY, rZ)
end
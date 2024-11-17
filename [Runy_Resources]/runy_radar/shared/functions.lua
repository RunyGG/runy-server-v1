-- https://wiki.multitheftauto.com/wiki/ReMap
function reMap(value, low1, high1, low2, high2)
	return low2 + (value - low1) * (high2 - low2) / (high1 - low1);
end

-- https://wiki.multitheftauto.com/wiki/FindRotation
function findRotation(x1, y1, x2, y2) 
	local t = -math.deg(math.atan2(x2 - x1, y2 - y1))
	return t < 0 and t + 360 or t
end

function getPointAway(x, y, angle, dist)
	local a = - math.rad(angle);

	dist = dist / 57.295779513082;

	return x + (dist * math.deg(math.sin(a))), y + (dist * math.deg(math.cos(a)));
end

function getRadarFromWorldPosition(bx, by, x, y, w, h, scaledMapSize)
	local RadarX, RadarY = x + w / 2, y + h / 2;
	local RadarD = getDistanceBetweenPoints2D(RadarX, RadarY, x, y);
	local px, py = getElementPosition(localPlayer);
	local _, _, crz = getElementRotation(getCamera());
	local dist = getDistanceBetweenPoints2D(px, py, bx, by);

	--[[ if (dist > RadarD * 6000 / scaledMapSize) then
		dist = RadarD * 6000 / scaledMapSize;
	end ]]
	local rot = 180 - findRotation(px, py, bx, by) + crz;
	local ax, ay = getPointAway(RadarX, RadarY, rot, dist * scaledMapSize / 6000);

	return ax, ay;
end
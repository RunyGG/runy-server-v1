config = {  
    markerColor = {26, 225, 29, 90};

    notify = function(player, text, type)
        return exports['fr_dxmessages']:addBox(player, text, type)
    end;

    teleports = {
        weapon = 31;
        positions = {
            {122.334, -306.899, 1.578};
            {178.689, -311.023, 1.572};
            {151.181, -230.724, 1.572};
            {92.362, -301.617, 1.572};
            {19.185, -306.445, 2.52};
            {27.019, -229.821, 2.52};
            {62.047, -244.413, 2.52};
            {135.435, -279.626, 1.578};
            {45.093, -285.673, 1.876};
            {99.729, -248.204, 1.578};
            {19.791, -276.254, 2.505};
            {89.189, -241.885, 5.039};
        };
    };

    maxPlayersPerDimension = 50;
    mataMataTime = 5 * 60; -- 25 Minutos bahveinho

    DIMENSION_START = 10000;
    DIMENSION_END = 11000;
};

r, g, b, a = 30, 130, 231, 90
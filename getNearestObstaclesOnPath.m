function obst = getNearestObstaclesOnPath(S, F, obstacles)
    obst = -1;
    minDist = 0;
    infinity = 1000000;
    for k = 1: size(obstacles, 1)
        intersects = SegmentCircleIntersect(S(1), S(2), F(1), F(2), obstacles(k, 1), obstacles(k, 2), obstacles(k, 3));
        if numel(intersects) > 0
            curDist = infinity;
            for j = 1: size(intersects, 1)
                curDist = min(curDist, r_dist_points([intersects(j, 1), intersects(j, 2)], S));
            end
            if (obst == -1 || curDist < minDist)
                minDist = curDist;
                obst = k;
            end
        end
    end
end
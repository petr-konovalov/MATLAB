function path = fastBuildPath(S, F, obstacles, step, recDepth)
    import java.util.LinkedList;
    maxRecDepth = 20;

    obst = getNearestObstaclesOnPath(S, F, obstacles);
    if (obst ~= -1 && recDepth <= maxRecDepth)
        C = breakLine(S, F, obst, obstacles, step);
        path = fastBuildPath(S, C, obstacles, step, recDepth + 1);
        path.removeLast();
        path.addAll(fastBuildPath(C, F, obstacles, step, recDepth + 1));
    else
        path = LinkedList();
        path.add(S);
        path.add(F);
    end
end
function pnt = getNextPointOnPath(path, obstacles)
    start = path.pop();
    pnt = path.pop();
    
    while ~path.isEmpty()
        cur = path.pop();
        if (checkSeg(start, cur, obstacles))
            pnt = cur;
        end
    end
end

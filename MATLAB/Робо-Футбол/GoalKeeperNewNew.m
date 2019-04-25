%доехать в точку А, развернуться к мячу
%agent - робот, В - мяч, G - центр ворот
%RP.Blue(1).rul = GoalKeeperNew(agent, B, G);

function rul = GoalKeeperNewNew(agent, B, G)
    v = 300; % окрестность ворот, их ширина, радиус окружности

    persistent tmp;
    if (isempty(tmp))
        tmp = [B.x B.y];
    end 
    %если мяч подвинулся
    if tmp ~= [B.x, B.y]
        %находим координаты точки, лежащей на прямой и ближайшей к центру окружности
        %центр координат смещен к центру ворот
        a = -tmp(2) + B.y;
        b = tmp(1) - B.x;
        c = (B.x - G(1))*(tmp(2) - G(2)) - (tmp(1) - G(1))*(B.y - G(2));
        d = a^2+b^2;
        point = [-a*c/d + G(1) -b*c/d + G(2)];
        %координаты точки уже в обычных координатах

        %если она внутри круга, т.е. предпологаемая траектория пересекла
        %окружнось, и надо двигаться
        if sqrt(point(1)^2 + point(2)^2) <= v
            r_to_point = sqrt((G(1) - point(1))^2 + (G(2) - point(2))^2);

            %длина вектора, который надо прибавить к point, чтобы получить
            %точку пересечения
            length = sqrt(v^2 - r_to_point^2);
            % угол наклона вектора
            angle = atan(tmp(1) - B.x, tmp(2) - B.y);
            X = point(1) + length * cos(angle);
            Y = point(2) + length * sin(angle);
            final_point = [X, Y];

            %вставить новый move to point!
            rul = MoveToPointPD(agent, final_point);
        end
        tmp = [B.x, B.y];
    end    

function rul = MoveToPointPD(agent, G) 
    angFinal = atan2((G(2) - agent.y), (G(1) - agent.x));
    dif = angFinal - agent.ang;
    pcoef = 1 / 750; %linear velocity coefficient
    dcoef = 0; %derivative velocity coefficient
    angVelocity = 15;      %angular velocity coefficient
    dist = sqrt((agent.x - G(1)) ^ 2 + (agent.y - G(2)) ^ 2);
    persistent oldDist;
    if (isempty(oldDist))
        oldDist = dist;
    end
    deltaDist = oldDist - dist;
    oldDist = dist;
    Speed = 15 + 60 * (pcoef * dist + dcoef * deltaDist);
    direction = pi / 2 + dif;
    SpeedX = Speed * cos(direction); 
    SpeedY = Speed * sin(direction);
    r = 100;    %radius of the robot
    err = 75;   %radius of the vicinity of G
    vicinity = r + err;
     if (dist > vicinity)
         rul = Crul(SpeedX, SpeedY, 0, 0, 0);
    else
        rul = Crul(0, 0, 0, dif * angVelocity, 0);
    end
 
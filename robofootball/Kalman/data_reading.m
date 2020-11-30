dataSize = 20000;
RData1 = dlmread('RData1.txt');
RData2 = dlmread('RData2.txt');
RData3 = dlmread('RData3.txt');
RData4 = dlmread('RData4.txt');
RData1 = RData1(1:dataSize, :);
RData2 = RData2(1:dataSize, :);
RData3 = RData3(1:dataSize, :);
RData4 = RData4(1:dataSize, :);
RData = zeros(4, dataSize, 8); 
RData(1, :, :) = RData1;
RData(2, :, :) = RData2;
RData(3, :, :) = RData3;
RData(4, :, :) = RData4;

for j = 1:4 %Помечаем кадры на которых что-то распозналось
    RData(j, 1, 2) = true;
    for k = 2: dataSize
        RData(j, k, 2) = RData(j, k, 3) ~= RData(j, k-1, 3) || ...
                         RData(j, k, 4) ~= RData(j, k-1, 4) || ...
                         RData(j, k, 5) ~= RData(j, k-1, 5);
    end
end

RData1 = RData(1, find(RData(1, :, 2), dataSize), :); %Удаляем кадры на которых ничего не распозналось
sz = size(RData1);
RData1 = reshape(RData1, sz(2), sz(3));
RData1 = RData1(find(remOutliers(RData1(:, 3), 1000), numel(RData1)/8), :);
RData1 = RData1(find(remOutliers(RData1(:, 4), 1000), numel(RData1)/8), :);
%RData1(:, 5) = glueAngle(RData1(:, 5));
% R = 500;
% for k = 2:sz(2)
%     %med = median(RData1(k-win:k, 3));
%     if abs(RData1(k-1, 3)-RData1(k, 3)) > R
%         RData1(k, 3) = RData1(k-1, 3);
%     end
% end
%outliers = find((RData1(:, 3) < -3500), 200);
%RData1(:, 3) = filloutliers(RData1(:, 3), 'previous', 'movmedian', 50); %Удаление выбросов
tm = RData1(:,1)-RData1(1,1);
ang = RData1(:, 5);
RData1(:, 5) = glueAngle(RData1(:, 5));
angl = numel(ang);
% plot(tm(1:angl-1), ang(2:angl)-ang(1:angl-1));
% figure();
plot(tm, ang);
figure();
plot(tm, glueAngle(ang));
figure();
plot(tm, ang-glueAngle(ang));

FID = fopen('./robofootball/Kalman/RData1filtered.txt', 'w');
fprintf(FID, '%f %f %f %f %f %f %f %f\n', RData1');
fclose(FID);


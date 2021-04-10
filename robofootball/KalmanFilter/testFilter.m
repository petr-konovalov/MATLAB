%fileID = fopen('BPosHX.txt', 'r');
BPosHX = readtable('movingBallHist.txt', 'ReadVariableNames', false);
BPosHY = readtable('BPosHY.txt', 'ReadVariableNames', false);
ballHistTimestamps = readtable('ballHistTimestamps.txt', 'ReadVariableNames', false);

ballHist = [ballHistTimestamps.Var1, BPosHX.Var1*0.001, BPosHY.Var1*0.001];
histLen = length(ballHist);
ball_init_covariance = 100;
ball_observation_noise = 2;
ball_process_noise = 0.1;

P = makeKalmanFilterInitialState(ball_init_covariance);
state = [ballHist(1, 2); 0; ballHist(1, 3); 0];
filt = zeros(histLen, 4);
filt(1, :) = state';
for k = 2:histLen 
    measure = ballHist(k, 2:3)';
    dt = ballHist(k, 1)-ballHist(k-1, 1);
    [new_state, new_P] = getKalmanFilterPredictWithUpdate(dt, state, P, measure, ball_process_noise, ball_observation_noise);
    filt(k, :) = new_state';
    state = new_state;
    P = new_P;
end

hold on;
plot(ballHist(:, 1), ballHist(:, 2));
plot(ballHist(:, 1), filt(:, 1), 'r');
hold off;
function [new_state, new_P] = getKalmanFilterPredictWithUpdate(dt, old_state, old_P, state_measure, ball_process_noise, ball_observation_noise)
    F = [ 1  dt 0  0 ;... 
          0  1  0  0 ;... 
          0  0  1 dt ;... 
          0  0  0  1];
    H = [1 0 0 0; 0 0 1 0];
    I = eye(4);
    [Q, R] = updateKalmanFilterNoise(dt, ball_process_noise, ball_observation_noise);
    state_predict = F  * old_state;
    P_predict = F * old_P * F' + Q;
    observation_deviance = state_measure - H * state_predict;
    S = R + H * P_predict * H';
    K = P_predict * H' / S;
    new_state = state_predict + K * observation_deviance;
    new_P = (I - K * H) * P_predict * (I - K * H)' + K * R * K';
end


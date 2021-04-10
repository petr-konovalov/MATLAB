function [Q, R] = updateKalmanFilterNoise(dt, ball_process_noise, ball_observation_noise)
    sigma2 = 3.0 * ball_process_noise / (dt^3);
    dt3 = dt^3*sigma2/3;
    dt2 = dt^2*sigma2/2;
    dt1 = dt*sigma2;
    Q = [dt3 dt2 0 0; dt2 dt1 0 0; 0 0 dt3 dt2; 0 0 dt2 dt1];
    R = [ball_observation_noise 0; 0 ball_observation_noise];
end


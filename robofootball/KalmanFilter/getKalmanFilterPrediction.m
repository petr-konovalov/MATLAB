function [new_state, P] = getKalmanFilterPrediction(dt, old_state, old_P, ball_process_noise)
    F = [ 1  dt 0  0 ;... 
          0  1  0  0 ;... 
          0  0  1 dt ;... 
          0  0  0  1];
    sigma2 = 3.0 * ball_process_noise / (dt^3);
    dt3 = dt^3*sigma2/3;
    dt2 = dt^2*sigma2/2;
    dt1 = dt*sigma2;
    Q = [dt3 dt2 0 0; dt2 dt1 0 0; 0 0 dt3 dt2; 0 0 dt2 dt1];
    new_state = F * old_state;
    P = F * old_P * F' + Q;
end


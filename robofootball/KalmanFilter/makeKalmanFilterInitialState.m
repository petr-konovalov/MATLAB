%ball_init_covariance is usually extremely high to converge to the true
%solution
%
function P = makeKalmanFilterInitialState(ball_init_covariance)
    P = [ ball_init_covariance  0  0  0 ;... 
          0  ball_init_covariance  0  0 ;... 
          0  0  ball_init_covariance  0 ;... 
          0  0  0  ball_init_covariance];
end


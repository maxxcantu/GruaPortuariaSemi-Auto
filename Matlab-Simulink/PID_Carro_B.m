function [ksat,ksiat,bat] = PID_Carro_B(M_eq_t, b_eq_t, i_t, r_td, factor_w, n_t)

% Ht = tf([i_t/r_td],[M_eq_t b_eq_t 0]);
p1_t = -b_eq_t/M_eq_t;                  % Polos de funcion transferencia de carro
omega_t = -factor_w*p1_t;
% n_t = 2.5;                              % Corresponde a z=0.75

ksat = M_eq_t*n_t*(omega_t^2);          % Kp_t
ksiat = M_eq_t*n_t*(omega_t^3);         % Ki_t
bat = M_eq_t*n_t*omega_t;               % Kd_t
end
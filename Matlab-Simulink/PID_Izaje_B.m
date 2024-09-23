function [ksah,ksiah,bah] = PID_Izaje_B (M_eq_h, b_eq_h, i_h, r_hd, factor_w, n_h)

% Hh = tf([i_h/r_hd],[M_eq_h b_eq_h 0]);
p1_h = -b_eq_h/M_eq_h;                  % Polos de funcion transferencia de carro
omega_h = -factor_w*p1_h;
% n_h = 2.5;                              % Corresponde a z=0.75 (factor de amortiguamiento)

ksah = M_eq_h*n_h*(omega_h^2);          % Kp_h
ksiah = M_eq_h*n_h*(omega_h^3);         % Ki_h
bah = M_eq_h*n_h*omega_h;               % Kd_h
end


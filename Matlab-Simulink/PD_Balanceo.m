function [Kp_bal,Kd_bal] = PD_Balanceo(M_s, M_cMax, M_t, g)
ML = M_s:100:M_s+M_cMax;
L = 1:0.1:60;
Kd_bal = zeros(length(ML),length(L));
Kp_bal = Kd_bal;

for i=1:length(L)
    for n=1:length(ML)
        H_b = tf([-(M_t+ML(n)), 0],[(M_t+ML(n))*L(i), 0, M_t*g]);
        p = pole(H_b);
        w_n = sqrt(abs(p(1)));
        Kd_bal(n,i) = L(i)-((M_t*g)/(M_t+ML(n))*(w_n^2));
        Kp_bal(n,i) = 2*w_n*(L(i)-Kd_bal(n,i));

    end
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                     Proyecto Global Integrador                      %%%  
%%%                    Autómatas y Control Discreto                     %%%  
%%%          Cantú Tsallis, Maximiliano  -   Lage Tejo, Joaquín         %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc, clear all vars, close all

%% Condiciones Iniciales
CI_t = -16.25;
CI_h = 5;
d_t = 1e-3;

%% Límites de Operación (pág. 4 de Guía)
%%% Posiciones
% Traslación de Carro (x=0m en borde de muelle)
lim_xIzq = -30;     %[m]-Limite normal de operacion (sobre muelle)
lim_xIzq_ult = -31; %[m]-Límite último (sobre muelle)
lim_xDer = 50;      %[m]-Límite de Operación (sobre barco)
lim_xDer_ult = 51;  %[m]-Límite último (sobre barco)

% Izaje de Carga (y=0m en nivel del muelle)
lim_yInf = -20;     %[m]-Límite de Operación (dentro de barco) SE CALCULA "Yt0-lh"
lim_yInf_ult = -21; %[m]-Límite último (dentro de barco)
lim_ySup = 40;      %[m]-Límite de Operación (sobre barco/muelle)
lim_ySup_ult = 41;  %[m]-Límite último (sobre barco/muelle)
Y_t0 = 45;          %[m]-Altura (fija) de poleas de suspensión de Izaje en el Carro(desde el nivel de muelle)
Y_sb = 15;          %[m]-Altura viga testera o "sill beam"

%%% Velocidades y Aceleraciones
% Traslación de Carro
v_tMax = 4;     %[m/s]-Velocidad Maxima (cargado o sin carga)
a_tMax = 0.8;   %[m/s^2]-Aceleracion Maxima (cargado o sin carga)

% Izaje de carga
v_hMax_l = 1.5; %[m/s]-Velocidad Maxima (cargado con carga nominal)
v_hMax_0 = 3;   %[m/s]-Velocidad Maxima (sin carga)
a_hMax = 0.75;  %[m/s^2]-Aceleracion Maxima (cargado o sin carga)

%% Parámetros del Sistema Físico (pág. 8 a 10 de Guía)
%(REPETIDO) Y_t0 = 45;          %[m]-Altura (fija) de poleas de suspensión de Izaje en el Carro(desde el nivel de muelle)
H_c = 2.5;              %[m]-Alto y ancho de Container Estándar
M_s = 15000;            %[kg]-Masa de Spreader+Headblock(sin container)
M_cMax = 50000;         %[kg]-Masa nominal de Container/s a izar (máxima totalmente cargado)
M_cMin = 2000;          %[kg]-Masa de Container Estándar vacío (mínima, sin carga interna)
g = 9.80665;            %[m/s2]-Aceleracion gravitatoria
M_l_nom = 65000;        %[kg]-Masa nominal para Potencia nominal
M_l_min = 17000;        %[kg]-Masa mínima para Potencia nominal
M_l_max = 32500;        %[kg]-Masa máxima para Potencia nominal

% Carga apoyada, parámetros de contacto carga-apoyo (esfuerzo de compresión)
k_cy = 1.8e9;   %[N/m]-Rigidez de compresión por contacto vertical (carga comprime apoyo)
b_cy = 1e7;     %[N/(m/s)]-Fricción interna o amortiguamiento de compresión por contacto vertical
b_cx = 1e6;     %[N/(m/s)]-Fricción de arrastre horizontal por contacto vertical

%% IZAJE (pag.9)
% Cable de acero(wirerope) de izaje (parámetros unitarios POR METRO DE CABLE DESPLEGADO)
k_wu = 2.36e8;      %[(N/m)m]-Rigidez unitaria a tracción (tensión por peso de carga)
b_wu = 150;         %[(N/(m/s))/m]-Fricción interna o amortiguamiento unitario a tracción (rozamiento interno)

% Accionamiento del Sistema de Izaje
r_hd = 0.75;        %[m]-Radio primitivo de tambor (enrollado helicoidal, 1 sola corrida de cable)
J_hd_hEb = 3800;    %[kg.m2]-Momento de inercia equivalente del eje lento(tambor, disco de freno de emergencia y etapa de salida de caja reductora)
b_hd = 8;           %[(Nm)/(rad/s)]-Coeficiente de Fricción mecánica viscosa equivalente del eje lento
b_hEb = 2.2e9;      %[Nm/(rad/s)]-Coeficiente de Fricción viscosa equivalente del Freno de emergencia
T_hEbMax = 1.1e6;   %[Nm]-Torque máximo de frenado del Freno de emergencia
i_h = 22;           %Relación de transmisión total de caja reductora de engranajes
J_hm_hb = 30;       %[kg.m2]-Momento de inercia equivalente del eje rápido(motor, disco de freno de operación y etapa de entrada de caja reductora)
b_hm = 18;          %[(Nm)/(rad/s)]-Coeficiente de Fricción mecánica viscosa equivalente del eje rápido
b_hb = 1e8;         %[(Nm)/(rad/s)]-Coeficiente de Fricción viscosa equivalente del Freno de operación
T_hbMax = 5e4;      %[Nm]-Torque máximo de frenado del Freno de operación
tau_hm = 1e-3;      %[ms]-Constante de tiempo de Modulador de Torque en motor-drive de izaje
T_hmMax = 2e4;      %[Nm]-Torque máximo de motorización/frenado regenerativo del motor

% Parámetros Equivalentes
M_eq_h = (J_hd_hEb+J_hm_hb*i_h^2)*2/r_hd^2; 
b_eq_h = ((b_hd + b_hm*(i_h^2))*2/(r_hd^2));

%% CARRO (pág. 9 y 10)
% Carro y cable de acero (wirerope) de carro equivalente:
M_t = 30000;    %[kg]-Masa equivalente de Carro, ruedas, etc
b_t = 90;       %[N/(m/s)]-Coeficiente de Fricción mecánica viscosa equivalente del Carro
k_tw = 4.8e5;   %[N/m]-Rigidez equivalente total a tracción de cable tensado de Carro
b_tw = 3e3;     %[N/(m/s)]-Fricción interna o amortiguamiento total de cable tensado de Carro

% Accionamiento de Traslación del Carro:
r_td = 0.5;     %[m]-Radio primitivo de tambor (enrollado helicoidal, 1 sola corrida de cable
J_td = 1200;    %[kg.m2]-Momento de inercia equivalente del eje lento (tambor y etapa de salida de caja reductora)
b_td = 1.8;     %[Nm/(rad/s)]-Coeficiente de Fricción mecánica viscosa equivalente del eje lento
i_t = 30;       %Relacion de transmision total de caja reductora de engranajes
J_tm_tb = 7;    %[kh.m2]-Momento de inercia equivalente del eje rápido(motor, disco de freno de operación y etapa de entrada de caja reductora)
b_tm = 6;       %[Nm/(rad/s)]-Coeficiente de Friccion mecanica viscosa equivalente del eje rapido
b_tb = 5e6;     %[Nm/(rad/s)]-Coeficiente de Fricción viscosa equivalente del Freno de operación
T_tbMax = 5e3;  %[Nm]-Torque maximo de frenado del Freno de operacion
tau_tm = 1e-3;  %[s]-Constante de tiempo de Modulador de Torque en motor-drive de carro (1ms)
T_tmMax = 3e3;  %[Nm]-Torque maximo de moyotizacion/frenado regenerativo del motor

% Parámetros Equivalentes
M_eq_t = ((J_td + J_tm_tb*(i_t^2))/(r_td^2));
b_eq_t = ((b_td + b_tm*(i_t^2))/(r_td^2));

%% Sistema de Control y Protección (pág.11) - TENTATIVOS, PUEDEN VARIAR SEGÚN REQUERIMIENTO
Ts2 = 5e-3;     %[s]- Tiempo de muestreo del Nivel 2 (Control Regulatorio)
Ts1 = 20e-3;    %[s]- Tiempo de muestreo del Nivel 1 (Control Supervisor)
Ts0 = 20e-3;    %[s]- Tiempo de muestreo del Nivel 2 (Control Regulatorio)

%% Control Automático de Oscilación (pág. 11)
the_maxAc = 20; %[rad]-Ángulo máximo durante aceleración/desaceleración
the_maxVC = 5;  %[rad]-Ángulo máximo durante trayectoria a velocidad constante
the_maxRe = 1;  %[rad]-Ángulo máximo residual al completar movimiento
z_osc = 1;      % Factor de Amortiguamiento Relativo de la Oscilación (CRÍTICO)

%% Velocidad Máxima de Izaje (ver Fig.5 de Hipérbola en pág. 13)
P_h_nom = 956.15e3;     % [W]

%% Perfil de Carga
[xc, yc] = Perfil_Carga();

%% Pruebas
% M_cX = rand(1)*M_cMax + M_cMin
% M_cX = randi(M_cMax - M_cMin)+ M_cMin
% 
% if ((M_cX > M_cMin) && (M_cX < M_cMax))
%     valor = 'true'
% else
%     valor = 'false'
% end

%% PID Nivel 2 - Carro, Izaje y Balanceo
cambiar_PID = 0;
% cambiar_bal = 0;
if cambiar_PID
    n_t = 2.5;  factor_wt = 5;
    n_h = 2.5;  factor_wh = 5;
    % GUARDAR - Creo un archivo .mat que guarda las Constantes
    [ksat, ksiat, bat] = PID_Carro_B(M_eq_t, b_eq_t, i_t, r_td, factor_wt, n_t);
    [ksah, ksiah, bah] = PID_Izaje_B(M_eq_h, b_eq_h, i_h, r_hd, factor_wh, n_h);
    save PID_calculado.mat
else
    % CARGAR - Carga las constantes desde un .mat
    load PID_calculado.mat
end

cambiar_bal = 1
if cambiar_bal
    % GUARDAR - Creo un archivo .mat que guarda las "matrices" de Constantes
%     [Kp_bal, Kd_bal] = PD_Balanceo(M_s, M_cMax, M_t, g);
    [Kp_bal, Kd_bal] = PD_Balanceo_v2(M_s, M_cMax, M_t, g, 1);
%     [Kp_bal, Kd_bal] = PD_Balanceo2(M_s, M_cMax, M_t, g);
    save Kp_Kd_balanceo.mat Kp_bal Kd_bal
else
    % CARGAR - Carga las matrices de constantes desde un .mat
    load Kp_Kd_balanceo.mat
end


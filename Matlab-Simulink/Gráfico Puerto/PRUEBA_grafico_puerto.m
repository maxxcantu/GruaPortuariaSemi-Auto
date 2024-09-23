%%% Programa para probar la función "grafico_puerto" que se usa en Simulink
clc, clear all

[Xc, Yc] = Perfil_Carga();
clock = 10.2536;
SYS_ON = 1;
SYS_FAULT = 1;
BTN_EMERGENCIA = 0;
CTRL_MAN = 1;
CCL_DB = 1;
OW = 0;
Tension_hw = 1;
O_SPEED = 1;
Balanceo = 1;
MAN_AUTO = 1;
ML = 25000;
flag_plot = 1;
x_l = 30;
y_l = 25;
X_carro = 27;

grafico_puerto(clock, SYS_ON, BTN_EMERGENCIA, CTRL_MAN, CCL_DB, OW, Tension_hw, O_SPEED, Balanceo, MAN_AUTO, ML, Xc, Yc, flag_plot, x_l, y_l, X_carro)
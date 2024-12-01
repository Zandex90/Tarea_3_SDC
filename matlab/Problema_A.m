matrices;

%% Ganancias del sistema
k_st = 180/pi; k_a = 100; k_c = 10e-3;

%% Sistema
cnt = k_c; % Controlador proporcional
sys = ss(A, B, C, 0);
Ls = cnt * k_a * sys * k_st; % Lazo Directo

%% Calulo MG y MF
[mg, mf, wg, wp] = margin(Ls);
disp('Margen de Ganancia (MG):');
disp(mg); % En absoluto
disp('Margen de Fase (MF):');
disp(mf); % En grados

%% Ganancia y retardo critico
k_cr = mg * k_c; t_cr = deg2rad(mf) / wp;
disp('Ganancia critica: ')
disp(k_cr)
disp('Retardo critico: ')
disp(t_cr)
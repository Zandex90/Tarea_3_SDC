matrices;

%% Ganancias del sistema
k_st = 180/pi; k_a = 100; k_c = 10e-3;

%% Sistema
cnt = k_c; % Controlador proporcional
sys = ss(A, B, C, 0);
Ls = cnt * k_a * sys * k_st; % Lazo Directo

%% Calulo MG y MF
[MG,MF] = margin(Ls);
disp('Margen de Ganancia (MG):');
disp(MG); % En veces, si lo queremos en dB: 20*log10(GM)
disp('Margen de Fase (MF):');
disp(MF); % En grados
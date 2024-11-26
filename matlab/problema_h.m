matrices;

%% Ganancias del sistema
k_st = 180/pi; k_a = 100; k_c = 4e-3;
T = 200e-3;

%% Sistema
z = tf('z', T);
cnt = k_c / (z-1); % Controlador proporcional
sys_c = ss(A, B, C, 0);
sys = c2d(sys_c, T);
Ls = cnt * k_a * sys * k_st; % Lazo Directo

%% Margen de fase y ganancia
[mg, mf, wg, wp] = margin(Ls);
disp('Margen de ganancia kc=4m: ')
disp(mg)
disp('Margen de fase kc=4m: ')
disp(mf)

%% Diagrama de Nyquist con MG y MF
f1 = figure(1);
np = nyquistplot(Ls);
np.Characteristics.MinimumStabilityMargins.Visible = "on";
np.YLimits = [-5, 5];

%% Diagrama de Bode con MG y MF
f2 = figure(2);
bp = bodeplot(Ls, {0, pi/T});
bp.Characteristics.MinimumStabilityMargins.Visible = "on";

%% Ganancia y retardo critico
k_cr = mg * k_c; N_cr = round(deg2rad(mf) / (wp*T));
disp('Ganancia critica: ')
disp(k_cr)
disp('Retardo critico: ')
disp(N_cr)

%% Nyquist y bode ganancia critica
cnt1 = cnt * mg;
sys_c = ss(A, B, C, 0);
sys = c2d(sys_c, T);
Ls1 = cnt1 * k_a * sys * k_st; % Lazo Directo

[~, mf1] = margin(Ls1);
disp('Margen de fase ganancia critica: ')
disp(mf1)

f3 = figure(3);
np1 = nyquistplot(Ls1);
np1.Characteristics.MinimumStabilityMargins.Visible = "on";
np1.YLimits = [-5, 5];

f4 = figure(4);
bp1 = bodeplot(Ls1, {0, pi/T});
bp1.Characteristics.MinimumStabilityMargins.Visible = "on";

%% Nyquist y bode retardo critico
sys2 = sys;
sys2.InputDelay = N_cr;
Ls2 = cnt * k_a * sys2 * k_st; % Lazo Directo

[mg2, ~] = margin(Ls2);
disp('Margen de ganancia retardo critico: ')
disp(mg2)

f5 = figure(5);
np2 = nyquistplot(Ls2);
np2.Characteristics.MinimumStabilityMargins.Visible = "on";
np2.YLimits = [-5, 5];

f6 = figure(6);
bp2 = bodeplot(Ls2, {0, pi/T});
bp2.Characteristics.MinimumStabilityMargins.Visible = "on";

%% Exportar graficos
if ~exist('exportar', 'var')
  exportar = false;
end

if exportar
  matlab2tikz('figurehandle', f1, 'width', '10cm', 'height', '6cm', ...
    'interpretTickLabelsAsTex', true, 'parseStrings', false, ...
    'externalData', true, 'dataPath', './data', ...
    'extraAxisOptions', 'restrict y to domain=-20:20', ...
    'relativeDataPath', 'Diagramas/data', 'nyquist_h1.tex');

  matlab2tikz('figurehandle', f2, 'width', '10cm', 'height', '6cm', ...
    'interpretTickLabelsAsTex', true, 'parseStrings', false, ...
    'externalData', true, 'dataPath',  './data', ...
    'relativeDataPath', 'Diagramas/data', 'bode_h1.tex');
  
  matlab2tikz('figurehandle', f3, 'width', '10cm', 'height', '6cm', ...
    'interpretTickLabelsAsTex', true, 'parseStrings', false, ...
    'extraAxisOptions', 'restrict y to domain=-20:20', ...
    'externalData', true, 'dataPath', './data', ...
    'relativeDataPath', 'Diagramas/data', 'nyquist_h2.tex');

  matlab2tikz('figurehandle', f4, 'width', '10cm', 'height', '6cm', ...
    'interpretTickLabelsAsTex', true, 'parseStrings', false, ...
    'externalData', true, 'dataPath',  './data', ...
    'relativeDataPath', 'Diagramas/data', 'bode_h2.tex');

  matlab2tikz('figurehandle', f5, 'width', '10cm', 'height', '6cm', ...
    'interpretTickLabelsAsTex', true, 'parseStrings', false, ...
    'extraAxisOptions', 'restrict y to domain=-20:20', ...
    'externalData', true, 'dataPath', './data', ...
    'relativeDataPath', 'Diagramas/data', 'nyquist_h3.tex');

  matlab2tikz('figurehandle', f6, 'width', '10cm', 'height', '6cm', ...
    'interpretTickLabelsAsTex', true, 'parseStrings', false, ...
    'externalData', true, 'dataPath',  './data', ...
    'relativeDataPath', 'Diagramas/data', 'bode_h3.tex');
end

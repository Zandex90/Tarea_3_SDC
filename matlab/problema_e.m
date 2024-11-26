matrices;

%% Ganancias del sistema
k_st = 180/pi; k_a = 100; k_c = 10e-3;
t_cr = 16.75e-3;

%% Sistema
cnt = k_c; % Controlador proporcional
sys = ss(A, B, C, 0, 'InputDelay', t_cr);
Ls = cnt * k_a * sys * k_st; % Lazo Directo

%% Diagrama de Nyquist con MG y MF
f1 = figure(1);
np = nyquistplot(Ls);
np.Characteristics.MinimumStabilityMargins.Visible = "on";

%% Diagrama de Bode con MG y MF
f2 = figure(2);
bp = bodeplot(Ls, {1e-1, 1e2});
bp.Characteristics.MinimumStabilityMargins.Visible = "on";

%% Margen de ganancia
[mg, mf] = margin(Ls);
disp('Margen de ganancia: ')
disp(mg)

%% Exportar graficos
if ~exist('exportar', 'var')
  exportar = false;
end

if exportar
  matlab2tikz('figurehandle', f1, 'width', '10cm', 'height', '6cm', ...
    'interpretTickLabelsAsTex', true, 'parseStrings', false, ...
    'externalData', true, 'dataPath', './data', ...
    'relativeDataPath', 'Diagramas/data', 'nyquist_e.tex');

  matlab2tikz('figurehandle', f2, 'width', '10cm', 'height', '6cm', ...
    'interpretTickLabelsAsTex', true, 'parseStrings', false, ...
    'externalData', true, 'dataPath',  './data', ...
    'relativeDataPath', 'Diagramas/data', 'bode_e.tex');
end

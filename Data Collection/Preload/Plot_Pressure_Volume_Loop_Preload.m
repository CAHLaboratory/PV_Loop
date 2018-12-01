%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  By Jacob King
%  Date: 8/24/2018
%
%  Preload Only
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Input Variables
%ESPVR
a1 = Variable_ESPVR_A1(1,1);
a0 = Variable_ESPVR_A0;

%EDPVR
b3 = Variable_EDPVR_B3;
b2 = Variable_EDPVR_B2;
b1 = Variable_EDPVR_B1;
b0 = Variable_EDPVR_B0;

%Ea
c1 = Variable_Ea_C1(1,1);
c0 = Variable_Ea_C0(1,1);
%%
Initial_LVesv = (c0-a0)/(a1-c1);
Initial_LVesp = a1*((c0-a0)/(a1-c1)) + a0;
Initial_LVedv = (-c0/c1);
Initial_LVedp = b3*(-c0/c1)^3 + b2*(-c0/c1)^2 + b1*(-c0/c1) + b0;
Initial_LVeirv = Initial_LVesv;
Initial_LVeirp = b3*((c0-a0)/(a1-c1))^3 + b2*((c0-a0)/(a1-c1))^2 + b1*((c0-a0)/(a1-c1)) + b0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Heart Rate
%M = mean(PhaseChange_HeartBeatCount_HeartRate.signals.values(2403:end,end));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot figure
% close all
n = 1;
figure(n)  
%%
V = 0:0.1:250;

% Plot ESPVR
Pa = a1*V + a0;
plot(V,Pa,'LineWidth',2,...
    'Color',[0.800000011920929 0.800000011920929 0.800000011920929])
hold on

% Plot EDPVR
Pb = b3*V.^3 + b2*V.^2 + b1*V + b0;
plot(V,Pb,'LineWidth',2,...
    'Color',[0.831372559070587 0.815686285495758 0.7843137383461]);
hold on

% Plot Ea
Pc = c1*V + c0;
plot(V,Pc,'LineWidth',2,...
    'Color',[0.501960813999176 0.501960813999176 0.501960813999176])
hold on

% 'Color',[0.313725501298904 0.313725501298904 0.313725501298904]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For final changes to preload
c1_final = Variable_Ea_C1(1,1);
c0_final = Variable_Ea_C0(1,end);

Pc_final = c1_final*V + c0_final;
plot(V,Pc_final,'LineWidth',2,...
	'Color',[0.313725501298904 0.313725501298904 0.313725501298904])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Plot PV Loop
plot(Measured_LVV.signals.values, Measured_LVP.signals.values, 'black','Linewidth',2)

hold on
plot(Initial_LVesv, Initial_LVesp,'Marker','*','LineWidth',10,'LineStyle','none','Color',[0 0 0])
hold on
plot(Initial_LVedv, Initial_LVedp,'Marker','*','LineWidth',10,'LineStyle','none','Color',[0 0 0])
hold on
plot(Initial_LVeirv, Initial_LVeirp,'Marker','*','LineWidth',10,'LineStyle','none','Color',[0 0 0])

hold on
LVes_Line_1 = 0:1:200;
plot(LVes_Line_1, ones(size(LVes_Line_1))*Initial_LVesp, '-- k')
hold on
LVes_Line_2 = 0:1:200;
plot(ones(size(LVes_Line_2))*Initial_LVesv, LVes_Line_2, '-- k')
hold on
LVed_Line_2 = 0:1:200;
plot(ones(size(LVed_Line_2))*Initial_LVedv, LVed_Line_2, '-- k')

xlim([0 200])
ylim([0 200])

legend('ESPVR', 'EDPVR', 'Ea: Initial', 'Ea: Final', 'Pressure-Volume Loop')
title('Left Ventricular Pressure-Volume Loop - Preload Change Only');
xlabel('Volume [mL]','FontWeight','bold','FontName','Arial');
ylabel('Pressure [mmHg]','FontWeight','bold','FontName','Arial');

set(findall(gcf,'type','axes'),'fontsize',14)
set(findall(gcf,'type','text'),'fontSize',14)
set(gca, 'FontName', 'Arial')
set(gca,'fontweight','bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot sub figures
figure(n+1)

subplot(2,2,[1,3]);

% Plot ESPVR
plot(V,Pa,'LineWidth',2,...
    'Color',[0.800000011920929 0.800000011920929 0.800000011920929])
hold on

% Plot EDPVR
plot(V,Pb,'LineWidth',2,...
    'Color',[0.831372559070587 0.815686285495758 0.7843137383461]);
hold on

% Plot Ea
plot(V,Pc,'LineWidth',2,...
    'Color',[0.501960813999176 0.501960813999176 0.501960813999176])
hold on
plot(V,Pc_final,'LineWidth',2,...
	'Color',[0.313725501298904 0.313725501298904 0.313725501298904])
hold on

% Plot PV Loop
plot(Measured_LVV.signals.values, Measured_LVP.signals.values, 'black','Linewidth',2)
hold on
plot(Initial_LVesv, Initial_LVesp,'Marker','*','LineWidth',10,'LineStyle','none','Color',[0 0 0])
hold on
plot(Initial_LVedv, Initial_LVedp,'Marker','*','LineWidth',10,'LineStyle','none','Color',[0 0 0])
hold on
plot(Initial_LVeirv, Initial_LVeirp,'Marker','*','LineWidth',10,'LineStyle','none','Color',[0 0 0])

xlim([0 200])
ylim([0 200])

legend('ESPVR', 'EDPVR', 'Ea: Initial', 'Ea: Final', 'Pressure-Volume Loop')
title('Left Ventricular Pressure-Volume Loop - Preload Change Only');
xlabel('Volume [mL]','FontWeight','bold','FontName','Arial');
ylabel('Pressure [mmHg]','FontWeight','bold','FontName','Arial');

set(findall(gcf,'type','axes'),'fontsize',14)
set(findall(gcf,'type','text'),'fontSize',14)
set(gca, 'FontName', 'Arial')
set(gca,'fontweight','bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,2);
plot(AoP.time,AoP.signals.values,'LineWidth',2,...
    'Color',[0.501960813999176 0.501960813999176 0.501960813999176])
hold on
plot(LAP.time,LAP.signals.values,'LineWidth',2,...
    'Color',[0.831372559070587 0.815686285495758 0.7843137383461]);
hold on
plot(Measured_LVP.time,Measured_LVP.signals.values, 'black','Linewidth',2)

legend('AoP [mmHg]', 'LAP [mmHg]','LVP [mmHg]')
title('LVP [mmHg], AoP [mmHg], and LAP [mmHg] versus Time [sec]');
xlabel('Time [sec]','FontWeight','bold','FontName','Arial');
ylabel('Pressure [mmHg]','FontWeight','bold','FontName','Arial');

set(findall(gcf,'type','axes'),'fontsize',14)
set(findall(gcf,'type','text'),'fontSize',14)
set(gca, 'FontName', 'Arial')
set(gca,'fontweight','bold')
set(gca,'XTick',[0:1:Sim_Time]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,4);
plot(Measured_LVV.time,Measured_LVV.signals.values, 'black','Linewidth',2)

legend('LVV [mL]')
title('LVV [mL] versus Time [sec]');
xlabel('Time [sec]','FontWeight','bold','FontName','Arial');
ylabel('Volume [mL]','FontWeight','bold','FontName','Arial');

set(findall(gcf,'type','axes'),'fontsize',14)
set(findall(gcf,'type','text'),'fontSize',14)
set(gca, 'FontName', 'Arial')
set(gca,'fontweight','bold')
set(gca,'XTick',[0:1:Sim_Time]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Creates .mat files that saves all variables not cleared

% save(['PV_Loop_Preload_Only_002.mat'])
% 
% fig1 = figure(n);
% fig2 = figure(n+1);
% 
% savefig(fig1, ['Figure_1_Preload_Only_002.fig']);
% savefig(fig2, ['Figure_2_Preload_Only_002.fig']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  By Jacob King
%  Date: 8/24/2018
%
%  Control - Westermann et al. "Role of Left Ventricular Stiffness..." 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Input Variables
% Initial
%ESPVR
a1_i = Variable_ESPVR_A1(1,1);
a0_i = Variable_ESPVR_A0;

%EDPVR
b3_i = Variable_EDPVR_B3;
b2_i = Variable_EDPVR_B2;
b1_i = Variable_EDPVR_B1;
b0_i = Variable_EDPVR_B0;

%Ea
c1_i = Variable_Ea_C1(1,1);
c0_i = Variable_Ea_C0(1,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Final
%ESPVR
a1_f = Variable_ESPVR_A1(1,end);
a0_f= Variable_ESPVR_A0;

%EDPVR
b3_f = Variable_EDPVR_B3;
b2_f = Variable_EDPVR_B2;
b1_f = Variable_EDPVR_B1;
b0_f = Variable_EDPVR_B0;

%Ea
c1_f = Variable_Ea_C1(1,end);
c0_f = Variable_Ea_C0(1,end);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Initial_LVesv = (c0_i-a0_i)/(a1_i-c1_i);
Initial_LVesp = a1_i*((c0_i-a0_i)/(a1_i-c1_i)) + a0_i;
Initial_LVedv = (-c0_i/c1_i);
Initial_LVedp = b3_i*(-c0_i/c1_i)^3 + b2_i*(-c0_i/c1_i)^2 + b1_i*(-c0_i/c1_i) + b0_i;
Initial_LVeirv = Initial_LVesv;
Initial_LVeirp = b3_i*((c0_i-a0_i)/(a1_i-c1_i))^3 + b2_i*((c0_i-a0_i)/(a1_i-c1_i))^2 + b1_i*((c0_i-a0_i)/(a1_i-c1_i)) + b0_i;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Final_LVesv = (c0_f-a0_f)/(a1_f-c1_f);
Final_LVesp = a1_f*((c0_f-a0_f)/(a1_f-c1_f)) + a0_f;
Final_LVedv = (-c0_f/c1_f);
Final_LVedp = b3_f*(-c0_f/c1_f)^3 + b2_f*(-c0_f/c1_f)^2 + b1_f*(-c0_f/c1_f) + b0_f;
Final_LVeirv = Final_LVesv;
Final_LVeirp = b3_f*((c0_f-a0_f)/(a1_f-c1_f))^3 + b2_f*((c0_f-a0_f)/(a1_f-c1_f))^2 + b1_f*((c0_f-a0_f)/(a1_f-c1_f)) + b0_f;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot figure
% close all
n = 5;
figure(n)  
%%
V = 0:0.1:250;

% Plot ESPVR
Pa = a1_i*V + a0_i;
plot(V,Pa,'LineWidth',2,...
    'Color',[0.800000011920929 0.800000011920929 0.800000011920929])
hold on

% Plot EDPVR
Pb = b3_i*V.^3 + b2_i*V.^2 + b1_i*V + b0_i;
plot(V,Pb,'LineWidth',2,...
    'Color',[0.831372559070587 0.815686285495758 0.7843137383461]);
hold on

% Plot Ea
Pc = c1_i*V + c0_i;
plot(V,Pc,'LineWidth',2,...
    'Color',[0.501960813999176 0.501960813999176 0.501960813999176])
hold on

% 'Color',[0.313725501298904 0.313725501298904 0.313725501298904]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For final changes to Control
c1_final = Variable_Ea_C1(1,end);
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
plot(Final_LVesv, Final_LVesp,'Marker','*','LineWidth',10,'LineStyle','none','Color',[0 0 0])
hold on
plot(Final_LVedv, Final_LVedp,'Marker','*','LineWidth',10,'LineStyle','none','Color',[0 0 0])
hold on
plot(Final_LVeirv, Final_LVeirp,'Marker','*','LineWidth',10,'LineStyle','none','Color',[0 0 0])

hold on
LVes_Line_1 = 0:1:200;
plot(LVes_Line_1, ones(size(LVes_Line_1))*Initial_LVesp, '-- k')
hold on
LVes_Line_2 = 0:1:200;
plot(ones(size(LVes_Line_2))*Initial_LVesv, LVes_Line_2, '-- k')
hold on
LVed_Line_2 = 0:1:200;
plot(ones(size(LVed_Line_2))*Initial_LVedv, LVed_Line_2, '-- k')
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot increments between Ea:Initial and Ea:Final

for i = 4:1:length(Variable_Ea_C1)-1
 
    Pc_increment = Variable_Ea_C1(1,i)*V + Variable_Ea_C0(1,i);
        
    plot(V,Pc_increment)
        
    hold on
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xlim([0 200])
ylim([0 160])

legend('ESPVR', 'EDPVR', 'Ea: Initial', 'Ea: Final', 'Pressure-Volume Loop')
title('Left Ventricular Pressure-Volume Loop - Control');
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
hold on
plot(Final_LVesv, Final_LVesp,'Marker','*','LineWidth',10,'LineStyle','none','Color',[0 0 0])
hold on
plot(Final_LVedv, Final_LVedp,'Marker','*','LineWidth',10,'LineStyle','none','Color',[0 0 0])
hold on
plot(Final_LVeirv, Final_LVeirp,'Marker','*','LineWidth',10,'LineStyle','none','Color',[0 0 0])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot increments between Ea:Initial and Ea:Final

% for i = 3:1:length(Variable_Ea_C1)-1
%  
%     Pc_increment = Variable_Ea_C1(1,i)*V + Variable_Ea_C0(1,i);
%         
%     plot(V,Pc_increment)
%         
%     hold on
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xlim([0 200])
ylim([0 160])

legend('ESPVR', 'EDPVR', 'Ea: Initial', 'Ea: Final', 'Pressure-Volume Loop')
title('Left Ventricular Pressure-Volume Loop - Control');
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

% save(['PV_Loop_Westermann_Control_002.mat'])
% 
% fig1 = figure(n);
% fig2 = figure(n+1);
% 
% savefig(fig1, ['Figure_1_Westermann_Control_002.fig']);
% savefig(fig2, ['Figure_2_Westermann_Control_002.fig']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

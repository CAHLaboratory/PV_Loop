%  Created by Jacob King
%  Date: 8/23/2018
%
% Note:
%       Simulation Type
%       1 = Original datum 
%       2 = Datum with change in preload only
%       3 = Datum with change in afterload only
%       4 = Datum with change in contractility only
%       5 = Westermann 'Control'
%       6 = Westermann 'HFNEF'
%
%%
clear all
close all
%%
Simulation_Type = 1;


switch Simulation_Type
    
    case 1      % Input Variables for 'No Change'
        
        % ESPVR
        Variable_ESPVR_A1 = [2.9745 2.9745];
        Variable_ESPVR_A0 = -17.133;

        % EDPVR
        Variable_EDPVR_B3 = 2.6435E-5;
        Variable_EDPVR_B2 = -4.0598E-3;
        Variable_EDPVR_B1 = 0.16687;
        Variable_EDPVR_B0 = 8.5448;
        % 
        % Ea
        Variable_Ea_C1 = [-1.7504 -1.7504];
        Variable_Ea_C0 = [185.02 185.02];

        % Other
        Sim_Time = 10;
        Force_Rate = 225;
        Iso_Contraction_Offset = 1;
        Systolic_Ejection_Increase = 2;
        Systolic_Ejection_Offset = [7 7];
        Resistance = 0.03;
        Fluid_Chamber_Capacity = 51.715*10;
        Preload_Pressure = 0.01;
        Pressure_Full_Capacity = 10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Input Variables
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
        %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Final
        %ESPVR
        a1_f = Variable_ESPVR_A1(1,end);
        a0_f = Variable_ESPVR_A0;

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

        Volume_of_Fluid = Initial_LVesp/(Pressure_Full_Capacity/10); % LVesp but due to compliance and resistance

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 2      % Input Variables for 'Preload Only'
        % ESPVR
        Variable_ESPVR_A1 = [2.9745 2.9745];
        Variable_ESPVR_A0 = -17.133;

        % EDPVR
        Variable_EDPVR_B3 = 2.6435E-5;
        Variable_EDPVR_B2 = -4.0598E-3;
        Variable_EDPVR_B1 = 0.16687;
        Variable_EDPVR_B0 = 8.5448;

        % Ea
        Variable_Ea_C1 = [-1.7504 -1.7504];
        Variable_Ea_C0 = [185.02 185.02 190.02 195.02 200.02 205.02 210.02 215.02];

        % Other
        Sim_Time = 10;
        Force_Rate = 225;
        Iso_Contraction_Offset = 1;
        Systolic_Ejection_Increase = 2;
        Systolic_Ejection_Offset = [7 7];
        Resistance = 0.03;
        Fluid_Chamber_Capacity = 51.715*10;
        Preload_Pressure = 0.01;
        Pressure_Full_Capacity = 10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Input Variables
        % Initial
        % ESPVR
        a1_i = Variable_ESPVR_A1(1,1);
        a0_i = Variable_ESPVR_A0;

        % EDPVR
        b3_i = Variable_EDPVR_B3;
        b2_i = Variable_EDPVR_B2;
        b1_i = Variable_EDPVR_B1;
        b0_i = Variable_EDPVR_B0;

        % Ea
        c1_i = Variable_Ea_C1(1,1);
        c0_i = Variable_Ea_C0(1,1);
        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Final
        % ESPVR
        a1_f = Variable_ESPVR_A1(1,end);
        a0_f = Variable_ESPVR_A0;

        % EDPVR
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

        Volume_of_Fluid = Initial_LVesp/(Pressure_Full_Capacity/10); % LVesp but due to compliance and resistance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 3
        % Input Variables for 'Afterload Only'

        % ESPVR
        Variable_ESPVR_A1 = [2.9745 2.9745];
        Variable_ESPVR_A0 = -17.133;

        % EDPVR
        Variable_EDPVR_B3 = 2.6435E-5;
        Variable_EDPVR_B2 = -4.0598E-3;
        Variable_EDPVR_B1 = 0.16687;
        Variable_EDPVR_B0 = 8.5448;

        % Ea
        Variable_Ea_C1 = [-1.7504 -1.7504 -1.60848 -1.46656 -1.32464 -1.18272 -1.0408];
        Variable_Ea_C0 = [185.02 185.02 170.02 155.02 140.02 125.0 110.02];

        % Other
        Sim_Time = 10;
        Force_Rate = 225;
        Iso_Contraction_Offset = 1;
        Systolic_Ejection_Increase = 2;
        Systolic_Ejection_Offset = [7 7 7.5 8 8.5 9 9.5];
        Resistance = 0.03;
        Fluid_Chamber_Capacity = 51.715*10;
        Preload_Pressure = 0.01;
        Pressure_Full_Capacity = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Input Variables
        % Initial
        % ESPVR
        a1_i = Variable_ESPVR_A1(1,1);
        a0_i = Variable_ESPVR_A0;

        % EDPVR
        b3_i = Variable_EDPVR_B3;
        b2_i = Variable_EDPVR_B2;
        b1_i = Variable_EDPVR_B1;
        b0_i = Variable_EDPVR_B0;

        % Ea
        c1_i = Variable_Ea_C1(1,1);
        c0_i = Variable_Ea_C0(1,1);
        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Final
        % ESPVR
        a1_f = Variable_ESPVR_A1(1,end);
        a0_f = Variable_ESPVR_A0;

        % EDPVR
        b3_f = Variable_EDPVR_B3;
        b2_f = Variable_EDPVR_B2;
        b1_f = Variable_EDPVR_B1;
        b0_f = Variable_EDPVR_B0;

        % Ea
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

        Volume_of_Fluid = Initial_LVesp/(Pressure_Full_Capacity/10); % LVesp but due to compliance and resistance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 4
        % Input Variables for 'Contractility Only'

        % ESPVR
        Variable_ESPVR_A1 = [2.9745 2.9745 2.7245 2.4745 2.2245 1.9745 1.7245 1.4745 1.2245];
        Variable_ESPVR_A0 = -17.133;

        % EDPVR
        Variable_EDPVR_B3 = 2.6435E-5;
        Variable_EDPVR_B2 = -4.0598E-3;
        Variable_EDPVR_B1 = 0.16687;
        Variable_EDPVR_B0 = 8.5448;

        % Ea
        Variable_Ea_C1 = [-1.7504 -1.7504];
        Variable_Ea_C0 = [185.02 185.02];

        % Other
        Sim_Time = 10;
        Force_Rate = 225;
        Iso_Contraction_Offset = 1;
        Systolic_Ejection_Increase = 2;
        Systolic_Ejection_Offset = [7 7];
        Resistance = 0.03;
        Fluid_Chamber_Capacity = 51.715*10;
        Preload_Pressure = 0.01;
        Pressure_Full_Capacity = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Input Variables
        % Initial
        % ESPVR
        a1_i = Variable_ESPVR_A1(1,1);
        a0_i = Variable_ESPVR_A0;

        % EDPVR
        b3_i = Variable_EDPVR_B3;
        b2_i = Variable_EDPVR_B2;
        b1_i = Variable_EDPVR_B1;
        b0_i = Variable_EDPVR_B0;

        % Ea
        c1_i = Variable_Ea_C1(1,1);
        c0_i = Variable_Ea_C0(1,1);
        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Final
        % ESPVR
        a1_f = Variable_ESPVR_A1(1,end);
        a0_f = Variable_ESPVR_A0;

        % EDPVR
        b3_f = Variable_EDPVR_B3;
        b2_f = Variable_EDPVR_B2;
        b1_f = Variable_EDPVR_B1;
        b0_f = Variable_EDPVR_B0;

        % Ea
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

        Volume_of_Fluid = Initial_LVesp/(Pressure_Full_Capacity/10); % LVesp but due to compliance and resistance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 5
        % Input Variables for 'Control'. Westermann et al. "Role of Left Ventricular Stiffness..." Figure 1

        % ESPVR
        Variable_ESPVR_A1 = [1.2407 1.2407];
        Variable_ESPVR_A0 = 33.857;

        % EDPVR
        Variable_EDPVR_B3 = 2.6928E-7;
        Variable_EDPVR_B2 = -9.3013E-6;
        Variable_EDPVR_B1 = 0.026968;
        Variable_EDPVR_B0 = 2.9515;

        % Ea
        Variable_Ea_C1 = [-1.1365 -1.1365 -1.1365 -1.1992 -1.2619 -1.3247 -1.3874 -1.4501];
        Variable_Ea_C0 = [211.17 211.17 211.17 200.96 190.75 180.53 170.32 160.11];

        % Other
        Sim_Time = 10;
        Force_Rate = 500;
        Iso_Contraction_Offset = 1;
        Systolic_Ejection_Increase = 9;
        Systolic_Ejection_Offset = [20 20];
        Resistance = 0.05;
        Fluid_Chamber_Capacity = 51.715*10;
        Preload_Pressure = 0.01;
        Pressure_Full_Capacity = 6;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Input Variables
        % Initial
        % ESPVR
        a1_i = Variable_ESPVR_A1(1,1);
        a0_i= Variable_ESPVR_A0;

        % EDPVR
        b3_i = Variable_EDPVR_B3;
        b2_i = Variable_EDPVR_B2;
        b1_i = Variable_EDPVR_B1;
        b0_i = Variable_EDPVR_B0;

        % Ea
        c1_i = Variable_Ea_C1(1,1);
        c0_i = Variable_Ea_C0(1,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Final
        % ESPVR
        a1_f = Variable_ESPVR_A1(1,end);
        a0_f= Variable_ESPVR_A0;

        % EDPVR
        b3_f = Variable_EDPVR_B3;
        b2_f = Variable_EDPVR_B2;
        b1_f = Variable_EDPVR_B1;
        b0_f = Variable_EDPVR_B0;

        % Ea
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


        Volume_of_Fluid = Initial_LVesp/(Pressure_Full_Capacity/10); % LVesp but due to compliance and resistance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 6
        % Input Variables for 'HFNEF'. Westermann et al. "Role of Left Ventricular Stiffness..." Figure 1

        % ESPVR
        Variable_ESPVR_A1 = [0.99741 0.99741];
        Variable_ESPVR_A0 = 72.586;

        % EDPVR
        Variable_EDPVR_B3 = 1.4046E-5;
        Variable_EDPVR_B2 = -0.0025351;
        Variable_EDPVR_B1 = 0.15836;
        Variable_EDPVR_B0 = -0.010234;

        % Ea
        Variable_Ea_C1 = [-1.4054 -1.4054 -1.4054 -1.3994 -1.3934 -1.3874 -1.3814 -1.3754];
        Variable_Ea_C0 = [235.76 235.76 235.76 220.7 205.63 190.56 175.5 160.43];

        % Other
        Sim_Time = 10;
        Force_Rate = 500;
        Iso_Contraction_Offset = 1;
        Systolic_Ejection_Increase = 9;
        Systolic_Ejection_Offset = [20 20];
        Resistance = 0.045;                             
        Fluid_Chamber_Capacity = 51.715*10;
        Preload_Pressure = 0.01;
        Pressure_Full_Capacity = 6.666667;              

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Input Variables
        % Initial
        % ESPVR
        a1_i = Variable_ESPVR_A1(1,1);
        a0_i= Variable_ESPVR_A0;

        % EDPVR
        b3_i = Variable_EDPVR_B3;
        b2_i = Variable_EDPVR_B2;
        b1_i = Variable_EDPVR_B1;
        b0_i = Variable_EDPVR_B0;

        % Ea
        c1_i = Variable_Ea_C1(1,1);
        c0_i = Variable_Ea_C0(1,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Final
        % ESPVR
        a1_f = Variable_ESPVR_A1(1,end);
        a0_f= Variable_ESPVR_A0;

        % EDPVR
        b3_f = Variable_EDPVR_B3;
        b2_f = Variable_EDPVR_B2;
        b1_f = Variable_EDPVR_B1;
        b0_f = Variable_EDPVR_B0;

        % Ea
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

        Volume_of_Fluid = Initial_LVesp/(Pressure_Full_Capacity/10); % LVesp but due to compliance and resistance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    otherwise
        disp('Error. Input 1, 2, 3, 4, 5, or 6 for Simulation Type.')
        return
end
%% Simulate
sim('Left_Ventricular_PV_Loop_Control_2017b')
%% Plot
switch Simulation_Type
    case 1
        Plot_PV_Loop_DataCollection_No_Change
    case 2
        Plot_Pressure_Volume_Loop_Preload
    case 3
        Plot_Pressure_Volume_Loop_Afterload
    case 4
        Plot_Pressure_Volume_Loop_Contractility
    case 5
        Plot_Pressure_Volume_Loop_Westermann_Control
    case 6
        Plot_Pressure_Volume_Loop_Westermann_HFNEF
    otherwise
        disp('Error. Input 1, 2, 3, 4, 5, or 6 for Simulation Type.')
        return
end
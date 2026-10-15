clc;
clear;
close all;

%% =========================================================
%  EPANET WATER DISTRIBUTION NETWORK
%  Network layout and hydraulic result graphs
%  Data transcribed from the supplied EPANET screenshots
%% =========================================================

%% 1. NODE DATA
nodeNames = {'Junc 2','Junc 3','Junc 4','Junc 5', ...
             'Junc 6','Junc 7','Resvr 1', ...
             'Tank 8','Tank 9','Tank 10','Tank 11'};

demand = [2 2 2 2 2 2 -8.33 -0.93 -0.93 -1.84 -0.01];

head = [33335.87 33335.87 33335.87 33335.87 ...
        10 10 100 10 10 10 10];

pressure = [14444.43 14444.43 14444.43 14444.43 ...
            4.33 4.33 0 4.33 4.33 4.33 4.33];

%% 2. LINK DATA
linkNames = {'Pipe 2','Pipe 4','Pipe 8','Pipe 9', ...
             'Pipe 10','Pipe 11','Pipe 13','Pump 1', ...
             'Valve 3','Valve 6'};

flow = [2.16 -1.84 -0.93 -0.93 4.18 ...
        2.16 -0.01 8.33 0 0];

velocity = zeros(size(flow));

linkStatus = {'Open','Open','Open','Open','Open', ...
              'Open','Open','Open','Closed','Closed'};

%% 3. NETWORK NODE COORDINATES
% Approximate positions based on the supplied EPANET image.
% Replace these coordinates with your original node coordinates
% if you need an exact match to your EPANET network.

x = [3 5 5 5 7 7.5 1 6.2 9 6.5 9.5];
y = [5 5 7 6.5 8.5 2 5 10 10 0.5 1];

%% 4. DRAW THE NETWORK
figure('Name','EPANET Water Distribution Network', ...
       'Color','w','NumberTitle','off');

hold on;
axis equal;
axis off;

title('EPANET WATER DISTRIBUTION NETWORK', ...
      'FontSize',14,'FontWeight','bold');

% Draw pipes and devices.
% Each row: [start x, start y, end x, end y]
% This is an illustrative reconstruction of the screenshot.

connections = [
    1 5 3 5;       % Reservoir-side main
    3 5 5 5;       % Main pipe
    5 5 5 7;       % Upper riser
    5 7 7 7;       % Upper horizontal pipe
    7 7 7.5 8.5;   % Upper valve section
    7.5 8.5 6.2 10;% Upper branch
    7.5 8.5 9 10;  % Upper branch
    5 5 5 2;       % Lower main
    5 2 7.5 2;     % Lower valve section
    7.5 2 6.5 0.5; % Lower branch
    7.5 2 9.5 1    % Lower branch
];

% Pipe drawing
for k = 1:size(connections,1)
    plot([connections(k,1), connections(k,3)], ...
         [connections(k,2), connections(k,4)], ...
         'b-','LineWidth',1.8);
end

% Junctions
junctionIDs = 1:6;
plot(x(junctionIDs),y(junctionIDs),'ko', ...
     'MarkerFaceColor',[0.15 0.35 0.65], ...
     'MarkerSize',6);

% Reservoir symbol
plot(x(7),y(7),'ks','MarkerFaceColor',[0.3 0.7 0.9], ...
     'MarkerSize',12);
text(x(7)-0.1,y(7)+0.35,'Reservoir 1', ...
     'FontSize',9,'FontWeight','bold');

% Tank symbols
tankIDs = 8:11;
plot(x(tankIDs),y(tankIDs),'ks', ...
     'MarkerFaceColor',[0.25 0.65 0.85], ...
     'MarkerSize',11);

for k = tankIDs
    text(x(k),y(k)+0.3,nodeNames{k}, ...
         'HorizontalAlignment','center','FontSize',9);
end

% Label junctions
for k = 1:6
    text(x(k)+0.12,y(k)+0.15,nodeNames{k}, ...
         'FontSize',9,'Color','k');
end

% Pump symbol on the reservoir-side main
pumpX = 2;
pumpY = 5;
plot(pumpX,pumpY,'mp','MarkerFaceColor','m','MarkerSize',12);
text(pumpX,pumpY-0.4,'Pump 1', ...
     'HorizontalAlignment','center','FontSize',9);

% Valve symbols (illustrative)
plot(7.2,7.6,'kv','MarkerFaceColor','k','MarkerSize',8);
text(7.45,7.65,'Valve 3','FontSize',8);

plot(6.3,2,'k>','MarkerFaceColor','k','MarkerSize',8);
text(6.1,1.65,'Valve 6','FontSize',8);

% Legend
h1 = plot(nan,nan,'b-','LineWidth',1.8);
h2 = plot(nan,nan,'ko','MarkerFaceColor',[0.15 0.35 0.65]);
h3 = plot(nan,nan,'ks','MarkerFaceColor',[0.25 0.65 0.85]);
h4 = plot(nan,nan,'mp','MarkerFaceColor','m');

legend([h1 h2 h3 h4], ...
       {'Pipes','Junctions','Tanks / Reservoir','Pump'}, ...
       'Location','bestoutside');

xlim([0 11]);
ylim([0 11]);
hold off;

%% 5. NODE DEMAND GRAPH
figure('Name','Node Demand','Color','w');
bar(demand);
grid on;
title('Node Demand Distribution');
xlabel('Node ID');
ylabel('Demand (GPM)');
xticks(1:length(nodeNames));
xticklabels(nodeNames);
xtickangle(45);

%% 6. NODE PRESSURE GRAPH
figure('Name','Node Pressure','Color','w');
bar(pressure);
grid on;
title('Pressure at Network Nodes');
xlabel('Node ID');
ylabel('Pressure (psi)');
xticks(1:length(nodeNames));
xticklabels(nodeNames);
xtickangle(45);

%% 7. NODE HEAD GRAPH
figure('Name','Node Hydraulic Head','Color','w');
bar(head);
grid on;
title('Hydraulic Head at Network Nodes');
xlabel('Node ID');
ylabel('Head (ft)');
xticks(1:length(nodeNames));
xticklabels(nodeNames);
xtickangle(45);

%% 8. LINK FLOW GRAPH
figure('Name','Link Flow','Color','w');
bar(flow);
hold on;
yline(0,'k-');
grid on;
title('Flow Through Pipes, Pump and Valves');
xlabel('Link ID');
ylabel('Flow (GPM)');
xticks(1:length(linkNames));
xticklabels(linkNames);
xtickangle(45);
hold off;

%% 9. LINK VELOCITY GRAPH
figure('Name','Link Velocity','Color','w');
bar(velocity);
grid on;
title('Velocity in Network Links');
xlabel('Link ID');
ylabel('Velocity (ft/s)');
xticks(1:length(linkNames));
xticklabels(linkNames);
xtickangle(45);

%% 10. DISPLAY NODE RESULTS
NodeResults = table(nodeNames',demand',head',pressure', ...
    'VariableNames',{'NodeID','Demand_GPM','Head_ft','Pressure_psi'});

disp('NODE HYDRAULIC RESULTS');
disp(NodeResults);

%% 11. DISPLAY LINK RESULTS
LinkResults = table(linkNames',flow',velocity',linkStatus', ...
    'VariableNames',{'LinkID','Flow_GPM','Velocity_fps','Status'});

disp('LINK HYDRAULIC RESULTS');
disp(LinkResults);

%% 12. EXPORT RESULTS TO EXCEL
writetable(NodeResults,'EPANET_Node_Results.xlsx');
writetable(LinkResults,'EPANET_Link_Results.xlsx');

disp('Analysis complete.');
disp('Figures generated and results exported to Excel.');

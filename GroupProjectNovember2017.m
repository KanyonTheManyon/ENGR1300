%{
Kanyon Loyd    ENGR 1300-002     November 13th, 2017
Group Project

Problem Statement: Write a program to conduct a breakeven analysis in order 
to evaluate all options for the upgrade of a facility recently purchased by
new investors. Then create a plot displaying the number of widgets over the
abcissa and revenue and cost on the ordinate, as well as a plot
with time on the abcissa and profit on the ordinate.

Variables
breakeven = breakeven time [yrs]
breakeven2 = breakeven in widgets [#}
CostPlot = plot variable vector containing total cost for production of widget [$]
days = number of days facility operates per week
EnergyCost = energy cost per widget [$]
LaborCost = labor cost per widget [$]
LandfillCost = landfill cost per widget [$]
MachineProduction = number of widgets produced per day [#]
MaintenanceCost = maintenance cost per widget [$]
MaterialCost = material cost per widget [$]
Name = Name of option
Profit = Profit per year vector [$]
ProfitPlot = plot variable vector containing total profit per year [$]
PurchaseCost = Initial cost of upgrade [$]
Revenue = Revenue per year [$]
RevenuePlot = plot variable vector containing revenue times years [$]
SellingPrice = Selling price per widget [$]
Title1 = Title of first plot
Title2 = Title of second plot
TotalCost = Vector of cost times years [$]
TotalMatCost = Cost of materials per widget
TotalRevenue = Revenue vector per year [$]
TotalVarCost = Total variable cost per year [$]
VarCost = Total variable cost per widget
weeks = Number of weeks per year the facility operates
weight = weight of widget [g], then converted to [lbm]
Widgets = plot vector of number of widgets [#]
years = number of years for analysis [yrs]
YearsRun = vector containing number of years
%}

clear
clc
close all

weight=input('Please enter the weight of the widget in grams: ');
SellingPrice = input('Please enter the selling price of each widget in dollars: ');
Name = input('Please enter the name of the equipment option: ', 's');
PurchaseCost = input('Please enter the cost to purchase the new equipment in dollars: ');
EnergyCost = input('Please enter the energy cost to produce each widget in dollars: ');
LaborCost = input('Please enter the labor cost to produce each widget in dollars: ');
MaintenanceCost = input('Please enter the maintenance cost to produce each widget in dollars: ');
LandfillCost=input('Please enter the landfill cost to produce each widget in dollars: ');
MaterialCost = input('Please enter the material cost for each widget produced in dollars/lbm: ');
MachineProduction = input('Please enter the number of widgets produced each day: ');
days = input('Please enter the number of days per week that the plant will run: ');
weeks = input('Please enter the number of weeks per year that the plant will run: ');
years = input('Please enter the number of years this analysis should include: ');

%convert weight to lbm from grams
weight = weight/1000*2.205; %[lbm]

%Find total material cost
TotalMatCost = weight*MaterialCost;

%find Variable Cost per widget
VarCost = EnergyCost+LaborCost+MaintenanceCost+LandfillCost+TotalMatCost; %Variable cost per widget

%Find Total Cost per year
TotalVarCost=VarCost*MachineProduction*days*weeks;
YearsRun=[0:1:years];
TotalCost = TotalVarCost*YearsRun;

%Find Revenue for the number of years
Revenue = MachineProduction*SellingPrice*days*weeks; %revenue per year
TotalRevenue=Revenue*YearsRun;

%Determine Total Profit for the number of years
Profit=TotalRevenue-TotalCost-PurchaseCost;

%Find breakeven time
breakeven = PurchaseCost/(Revenue-TotalVarCost); % breakeven in years
breakeven2 = PurchaseCost/(SellingPrice-VarCost); % breakeven in widgets

%Output statements
fprintf('\n')
fprintf('The machine listed below will operate for %0.0f days per year \n', days*weeks);
fprintf('\n');
fprintf('Option: %s \n', Name);
fprintf('\t Producing %0.0f widgets each week will generate per year: \n', MachineProduction*days );
fprintf('\t\t Revenue:\t $%0.0f \n', Revenue );
fprintf('\t\t Cost:\t $%0.0f \n', TotalVarCost);
fprintf('\t Total number of widgets produced each year: %0.1E \n', MachineProduction*days*weeks);
fprintf('\t The breakeven time is %0.0f months, or %0.0f widgets. \n', breakeven*12, breakeven2);
fprintf('\t The total profit after %0.0f years is $%0.0f \n', years, Profit(1, years+1));

%Plot Variables
Widgets=[0, MachineProduction*days*weeks*years];
RevenuePlot=Widgets*SellingPrice;
CostPlot=Widgets*VarCost+PurchaseCost;
ProfitPlot=(Revenue-TotalVarCost)*YearsRun-PurchaseCost;
Title2 = sprintf('Projected Profits for Option %s', Name);
Title1 = sprintf('Breakeven Analysis for Option %s', Name); 

%Plot
figure('color', 'w')
plot(Widgets, RevenuePlot, '-r', Widgets, CostPlot, '--b', 'LineWidth',2)
hold on
plot(breakeven2, breakeven2*SellingPrice, 'xk', 'Markersize', 18)
xlabel('Number of Widgets [#]')
ylabel('Revenue and Cost [$]')
title(Title1)
legend('Revenue', 'Cost', 'Breakeven Point', 'Location', 'Northwest')
grid on
%Plot 2
figure('color', 'w')
plot(YearsRun, ProfitPlot, '-.g', 'LineWidth', 2)
hold on
plot(breakeven, 0, 'xk', 'MarkerSize', 18)
xlabel('Time (Years) [Yrs]')
ylabel('Profit [$]')
legend('Profits', 'Breakeven Point', 'location', 'Northwest')
title(Title2)
grid on










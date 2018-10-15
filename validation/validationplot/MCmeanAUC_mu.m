clc
clear all
close all
[num,txt,raw] = xlsread('input2.xlsx','sheet1');
plotcolor = {'r','g','b','k'};
plotsign = {'o','*'};
plotlegend = {};
mucol = strmatch('uA',txt(1,:));
rvarcol = strmatch('AR0',txt(1,:));
cvarcol = strmatch('AC0',txt(1,:));
AUCAcol = strmatch('mcMeanAUC_A',txt(1,:),'exact');
AUCBcol = strmatch('mcMeanAUC_B',txt(1,:),'exact');
AUCAminusBcol = strmatch('mcMeanAUC_AB',txt(1,:),'exact');
mulist = unique(num(:,mucol));
rvarlist = unique(num(:,rvarcol));
cvarlist = unique(num(:,cvarcol));
for i = 1: length(mulist)
    um_group = num(find(num(:,mucol)==mulist(i)),:);
    for j = 1: length(rvarlist)
       um_rvar_group = um_group(find(um_group(:,rvarcol)==rvarlist(j)),:);
       if ~isempty(um_rvar_group)
           for k = 1: length(cvarlist)
               um_rvar_cvar_group = um_rvar_group(find(um_rvar_group(:,cvarcol)==cvarlist(k)),:);
               if ~isempty(um_rvar_cvar_group)
                   figure(1)
                   plot(mulist(i)*ones(1,size(um_rvar_cvar_group,1)),um_rvar_cvar_group(:,AUCAcol(1))',strjoin([plotcolor(j),plotsign(k)],''));
                   hold on
                   figure(2)
                   plot(mulist(i)*ones(1,size(um_rvar_cvar_group,1)),um_rvar_cvar_group(:,AUCBcol(1))',strjoin([plotcolor(j),plotsign(k)],''));
                   hold on
                   figure(3)
                   plot(mulist(i)*ones(1,size(um_rvar_cvar_group,1)),um_rvar_cvar_group(:,AUCAminusBcol(1))',strjoin([plotcolor(j),plotsign(k)],''));
                   hold on
                   str =['rvar',num2str(rvarlist(j)),'cvar',num2str(cvarlist(k))];
                   if (~sum(ismember(plotlegend,['rvar',num2str(rvarlist(j)),'cvar',num2str(cvarlist(k))])))
                       plotlegend = [plotlegend,['rvar',num2str(rvarlist(j)),'cvar',num2str(cvarlist(k))] ];
                   end
               end
               a=1;
           end
       end
    end
end
figure(1)
xlabel('mu')
ylabel('AUC_A')
title('shape for different reader var, color for different case var');
legend(plotlegend);
figure(2)
xlabel('mu')
ylabel('AUC_B')
title('shape for different reader var, color for different case var');
legend(plotlegend);
figure(3)
xlabel('mu')
ylabel('AUC_A-AUC_B')
title('shape for different reader var, color for different case var');
legend(plotlegend);


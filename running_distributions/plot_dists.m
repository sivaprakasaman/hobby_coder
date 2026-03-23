%%

set(0,'DefaultFigureRenderer','painters')


%% Load/Format Sam Costa Data 
sc_data = readtable('sam_costa26_results.csv');
sc_table = sc_data(2:end,2:end);

sc_times = sc_table(:,7);
sc_times = minutes(table2array(sc_times));
sc_sex = table2array(sc_table(:,3));
sc_age = table2array(sc_table(:,9));
is_male = strcmp(sc_sex,'M');
age_group = sc_age>=30 & sc_age<35 & is_male;

sc_m_times = sc_times(is_male,:);
sc_f_times = sc_times(~is_male,:);
sc_age_group_times = sc_times(age_group,:); %males in age group

%% Load/Format Swiss Data
% Data reference: 
% A. Witthöft et al., "Running trends in Switzerland from 1999 to 2019: 
% An exploratory observational study," PLOS ONE, vol. 20, no. 1, p. e0311268, Jan. 2025, 
% doi: 10.1371/journal.pone.0311268.
sws_data = readtable('swiss_half_marathon_dataset.csv');
not_trail = sws_data(~strcmp(sws_data.ArtDesLaufes_Strassenlauf_Trail_,'Trail'),:);
sws_times = minutes(not_trail.Laufzeit_h_m_s_ms_-datetime('00:00:00'));
sws_age = not_trail.AlterL_ufer_Jahre_;
is_male = strcmp(not_trail.Geschlecht_m_w_,'m');
age_group = sws_age>=30 & sws_age<35 & is_male;

sws_m_times = sws_times(is_male,:);
sws_f_times = sws_times(~is_male,:);
sws_age_group_times = sws_times(age_group,:); %males in age group

%% Plots 
close all

clr_c = [148, 203, 236]/255;
clr_s = [42, 49, 50]/255;
clr_3 = [162, 181, 155]/255; 
clr_4 = [198, 137, 120]/255;
clr_5 = [214, 186, 134]/255;
clr_mytime = [46, 139, 87]/255;

% All 
main_fig= figure;
subplot(2,2,1)
histogram(sc_times,'Normalization','probability','binwidth',15,'FaceColor',clr_c);
xtickangle(30)
xlabel('Time (Minutes)')
ylabel('Probability')

hold on
histogram(sws_times,'Normalization','probability','binwidth',15,'FaceColor',clr_s);

xline(median(sc_times),'-.','color',clr_c,'linewidth',3)
xline(median(sws_times),'-.','color',clr_s,'linewidth',3)

%print medians
text(75,.46,'Median Times:','FontWeight','bold','HorizontalAlignment','center');
text(75,.42,char(minutes(median(sc_times)),'hh:mm:ss'),'FontWeight','Bold','color',clr_c,'HorizontalAlignment','center')
text(75,.38,char(minutes(median(sws_times)),'hh:mm:ss'),'FontWeight','Bold','color',clr_s,'HorizontalAlignment','center')

legend(strcat('Sam Costa | N = ', num2str(length(sc_times))),strcat('Swiss | N = ', num2str(length(sws_times))))
xticks(60:15:300)
xlim([50,185])
ylim([0,.5])
title('All HM Finish Times')

% Male 

subplot(2,2,2)
histogram(sc_m_times,'Normalization','probability','binwidth',15,'FaceColor',clr_3);
xtickangle(30)
xlabel('Time (Minutes)')
ylabel('Probability')

hold on
histogram(sws_m_times,'Normalization','probability','binwidth',15,'FaceColor',clr_s);

xline(median(sc_m_times),'-.','color',clr_3,'linewidth',3)
xline(median(sws_m_times),'-.','color',clr_s,'linewidth',3)

%print medians
text(75,.46,'Median Times:','FontWeight','bold','HorizontalAlignment','center');
text(75,.42,char(minutes(median(sc_m_times)),'hh:mm:ss'),'FontWeight','Bold','color',clr_3,'HorizontalAlignment','center')
text(75,.38,char(minutes(median(sws_m_times)),'hh:mm:ss'),'FontWeight','Bold','color',clr_s,'HorizontalAlignment','center')

legend(strcat('Sam Costa | N = ', num2str(length(sc_m_times))),strcat('Swiss | N = ', num2str(length(sws_m_times))),'FontSize',13)
xticks(60:15:300)
xlim([50,185])
ylim([0,.5])
title('OA Men''s Times')


% Female

subplot(2,2,3)
histogram(sc_f_times,'Normalization','probability','binwidth',15,'FaceColor',clr_4);
xtickangle(30)
xlabel('Time (Minutes)')
ylabel('Probability')

hold on
histogram(sws_f_times,'Normalization','probability','binwidth',15,'FaceColor',clr_s);

xline(median(sc_f_times),'-.','color',clr_4,'linewidth',3)
xline(median(sws_f_times),'-.','color',clr_s,'linewidth',3)

%print medians
text(75,.46,'Median Times:','FontWeight','bold','HorizontalAlignment','center');
text(75,.42,char(minutes(median(sc_f_times)),'hh:mm:ss'),'FontWeight','Bold','color',clr_4,'HorizontalAlignment','center')
text(75,.38,char(minutes(median(sws_f_times)),'hh:mm:ss'),'FontWeight','Bold','color',clr_s,'HorizontalAlignment','center')

legend(strcat('Sam Costa | N = ', num2str(length(sc_f_times))),strcat('Swiss | N = ', num2str(length(sws_f_times))))
xticks(60:15:300)
xlim([50,185])
ylim([0,.5])
title('OA Women''s Times')


% Age Group
subplot(2,2,4)
histogram(sc_age_group_times,'Normalization','probability','binwidth',15,'FaceColor',clr_5);
xtickangle(30)
xlabel('Time (Minutes)')
ylabel('Probability')

hold on
histogram(sws_age_group_times,'Normalization','probability','binwidth',15,'FaceColor',clr_s);

xline(median(sc_age_group_times),'-.','color',clr_5,'linewidth',3)
xline(median(sws_age_group_times),'-.','color',clr_s,'linewidth',3)
xline(87.5500,'color',clr_mytime,'linewidth',3)

%print medians
text(150,.3,'Median Times:','FontWeight','bold','HorizontalAlignment','center');
text(150,.26,char(minutes(median(sc_age_group_times)),'hh:mm:ss'),'FontWeight','Bold','color',clr_5,'HorizontalAlignment','center')
text(150,.22,char(minutes(median(sws_age_group_times)),'hh:mm:ss'),'FontWeight','Bold','color',clr_s,'HorizontalAlignment','center')
text(150,.16,'My Time:','FontWeight','bold','HorizontalAlignment','center');
text(150,.12,char(minutes(87.5500),'hh:mm:ss'),'FontWeight','Bold','color',clr_mytime,'HorizontalAlignment','center')

legend(strcat('Sam Costa | N = ', num2str(length(sc_age_group_times))),strcat('Swiss | N = ', num2str(length(sws_age_group_times))))
xticks(60:15:300)
xlim([50,185])
ylim([0,.5])
title('M30-34 Times')
set(findall(gcf,'-property','FontSize'),'FontSize',13)

set(main_fig,'Position',[1273 205 1373 1193])
sgtitle('Sam Costa 2026 vs Switzerland Runner Dataset (1999-2019)*','FontSize',16,'FontWeight','Bold')
% Annotation uses normalized coordinates [x y width height] from 0 to 1
annotation('textbox', [0.2, 0.001, 0.8, 0.03], ...
    'String', '*Swiss Data from Witthöft et al. (2025), PLOS ONE. doi:10.1371/journal.pone.0311268', ...
    'FontSize', 9, ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'right', ...
    'Color', [0.4 0.4 0.4]); % Muted gray color

print(main_fig,'output_figure.png','-r300','-dpng')
%% Interesting Numbers

sub_90_percentSwiss = 100*sum(sws_times<90)/length(sws_times);% 8%
sub_90_percentCosta = 100*sum(sc_times<90)/length(sc_times); % 23%
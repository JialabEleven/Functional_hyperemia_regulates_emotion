clear all;
clc;
filename = 'C:\Users\wwt\Desktop\JY_Statistics\20240606_peak_calculation\data\NFD'; %path of picture
data=xlsread(filename);
[rows,columns]=size(data);
savepath=['C:\Users\wwt\Desktop\JY_Statistics\20240606_peak_calculation\result\']
savepath_final=[savepath,'NFD_result']



for i=1:columns
    clear a;
    a=data(:,i);
    %[max_1,x_locs]=max(a); %找最大值点
    %a=smoothdata(a,'gaussian',4);
    [d_pks,d_locs]=findpeaks(a);%找峰值点
    figure(),plot(a);
    hold on
    plot(d_locs,d_pks,'.','color','R');%Fig 2%绘制极大值点
    [rows_peak,columns_peak]=size(d_locs);
    for j=1:rows_peak
        if(d_locs(j,1)<300) %30秒之前的峰值不做考虑
            continue;
        elseif(d_pks(j,1)<7 )%排除峰值小于3的小峰
            continue;
        elseif(d_pks(j,1)>a(d_locs(j,1)-10,1))&&(d_pks(j,1)>a(d_locs(j,1)+10,1))  %排除直线上升过程中的小峰
            result1(i,1)=d_locs(j,1),result1(i,2)=d_pks(j,1);
            while(d_pks(j+1,1)>d_pks(j,1))&&(d_locs(j+1,1)-d_locs(j,1)<5)  %排除未选择到最高的峰的情况
                result1(i,1)=d_locs(j+1,1),result1(i,2)=d_pks(j+1,1);
                j=j+1;
            end
            break;
        else
            continue;
        end
    end
    figure(),plot(a);
    hold on
    plot(d_locs(j,1),d_pks(j,1),'.','color','R');
    
    clear p30 averagedata;
    p30=a(300:d_locs(j,1));%输出30s到peak的y只
    p30=[p30;zeros(1000-length(p30),1)];
    p30_final(:,i)=p30;
    averagedata=a(d_locs(j,1):900);%peak到90s的平均值
    averagedata_finally(i,1)=mean(averagedata);
    [max_1(i,1),x_locs(i,1)]=max(a); %找最大值点


    
    %sheet1=1;
    %A=[{'30s-peak'}; num2cell(p30)];
    %xlswrite(savepath_final,A,sheet1);
end



sheet1=1;
sheet2=2;
output=[averagedata_finally,x_locs,max_1];
A=[num2cell(p30_final)];
B=[{'peak-90s_averagedata','max_x','max_y'}; num2cell(output)];
xlswrite(savepath_final,A,sheet1);
xlswrite(savepath_final,B,sheet2);
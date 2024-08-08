clc
clear all
filename='raw_data_experiment.xlsx'
data=xlsread(filename);
[~,~,rawdata]=xlsread(filename);
data_total=rawdata(2:end,:);
data_total1=data_total;
k=1;
for i=1:size(data_total,1)
    if isempty(data_total1{i,1})==1
        delete(k)=i;
        k=k+1;
    end
end
data_total1(delete,:)=[];
c=1;
for b=1:size(data_total1,1)
    if data_total1{b,10}<10 %删除蛋白打到次数小于10的基因，认为是误差凑巧打到的
        delete_low_number(c)=b;
        c=c+1;
    end
end
data_select_experiment=data_total1;
data_select_experiment(delete_low_number,:)=[];



filename1='raw_data_control.xlsx'
data=xlsread(filename1);
[~,~,rawdata1]=xlsread(filename1);
data_total2=rawdata1(2:end,:);
data_total3=data_total2;
g=1;
for ii=1:size(data_total2,1)
    if isempty(data_total3{ii,1})==1
        delete1(g)=ii;
        g=g+1;
    end
end
data_total3(delete1,:)=[];

cc=1;
% for bb=1:size(data_total3,1)
%     if data_total3{bb,16}<5 %删除蛋白打到次数小于3的基因，认为是误差凑巧打到的
%         delete_low_number1(cc)=bb;
%         cc=cc+1;
%     end
% end
data_select_contrast=data_total3;
% data_select_contrast(delete_low_number1,:)=[];

experiment=data_select_experiment;
contrast=data_select_contrast;


p=1;
q=1;
for j=1:size(experiment,1)
    for jj=1:size(contrast,1)
        tf=strcmp(experiment(j,4),contrast(jj,4));%以Accession为判定识别字符，实验组与对照组中Accession相同的提取出来,将实验组作为核心
        if tf==1
            m(p)=j;
            n(q)=jj;
            p=p+1;
            q=q+1;
        end
    end
end

pp=1;
qq=1;
for e=1:size(contrast,1)
    for ee=1:size(experiment,1)
        tf=strcmp(experiment(ee,4),contrast(e,4));%以Accession为判定识别字符，实验组与对照组中Accession相同的提取出来，将对照组作为核心
        if tf==1
            mm(pp)=e;
            nn(qq)=ee;
            pp=pp+1;
            qq=qq+1;
        end
    end
end


for t=1:size(m,2)
    output_experiment(t,:)=experiment(m(t),:);
    output_contrast(t,:)=contrast(n(t),:);
end

test_experiment=experiment;
x=1;
xx=1;
y=1;
for tt=1:size(test_experiment,1) %将实验组PSMs值与对照组对比，比值小于2的去除。
    for ttt=1:size(output_contrast,1)
        tf_divide=strcmp(test_experiment(tt,4),output_contrast(ttt,4));
        if tf_divide==1
%             x=experiment(tt,16);
%             y=output_contrast(ttt,16);
            x=cell2mat(test_experiment(tt,10));
            y=cell2mat(output_contrast(ttt,10));
            z=x/y;
            if z<2
                delete2(xx)=tt;
                xx=xx+1;
            end
            z1=num2cell(z);
            test_experiment(tt,9)=z1;
            test_experiment(tt,16)=z1;
        end
    end
end
test_experiment1=test_experiment;
test_experiment1(delete2,:)=[];



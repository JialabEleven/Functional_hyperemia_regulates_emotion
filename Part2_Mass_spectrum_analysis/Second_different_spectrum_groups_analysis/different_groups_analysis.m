clc
clear all
filename='Second_different_spectrum_groups_analysis\deal_block_1.xlsx'
data=xlsread(filename);
[~,~,rawdata]=xlsread(filename);
data_total=rawdata(2:end,:);
data_total1=data_total;
data_select_experiment1=data_total1;


filename1='Second_different_spectrum_groups_analysis\deal_block_2.xlsx'
data1=xlsread(filename1);
[~,~,rawdata1]=xlsread(filename1);
data_total2=rawdata1(2:end,:);
data_total3=data_total2;
data_select_experiment2=data_total3;

filename2='Second_different_spectrum_groups_analysis\deal_block_3.xlsx'
data2=xlsread(filename2);
[~,~,rawdata2]=xlsread(filename2);
data_total4=rawdata2(2:end,:);
data_total5=data_total4;
data_select_experiment3=data_total5;



experiment1=data_select_experiment1;
experiment2=data_select_experiment2;
experiment3=data_select_experiment3;


%%得到block1_block2的交集,block1_block3的交集，block2_block3的交集.
p=1;
q=1;
p1=1;
q1=1;
for j=1:size(experiment1,1)
    for jj=1:size(experiment2,1)
        tf=strcmp(experiment1(j,4),experiment2(jj,4));%以Accession为判定识别字符，实验组1与实验组2中Accession相同的提取出来,将实验组作为核心
        if tf==1
            m(p)=j;
            n(q)=jj;
            p=p+1;
            q=q+1;
        end
    end
end


for t=1:size(m,2)
    output_experiment1(t,:)=experiment1(m(t),:);
    output_contrast1(t,:)=experiment2(n(t),:);
end

pp=1;
qq=1;
for k=1:size(experiment1,1)
    for kk=1:size(experiment3,1)
        tf1=strcmp(experiment1(k,4),experiment3(kk,4));%以Accession为判定识别字符，实验组1与实验组3中Accession相同的提取出来,将实验组作为核心
        if tf1==1
            mm(pp)=k;
            nn(qq)=kk;
            pp=pp+1;
            qq=qq+1;
        end
    end
end

for tt=1:size(mm,2)
    output_experiment2(tt,:)=experiment1(mm(tt),:);
    output_contrast2(tt,:)=experiment3(nn(tt),:);
end

ppp=1;
qqq=1;
for y=1:size(experiment2,1)
    for yy=1:size(experiment3,1)
        tf2=strcmp(experiment2(y,4),experiment3(yy,4));%以Accession为判定识别字符，实验组2与实验组3中Accession相同的提取出来,将实验组作为核心
        if tf2==1
            mmm(ppp)=y;
            nnn(qqq)=yy;
            ppp=ppp+1;
            qqq=qqq+1;
        end
    end
end

for ttt=1:size(mmm,2)
    output_experiment3(ttt,:)=experiment2(mmm(ttt),:);
    output_contrast3(ttt,:)=experiment3(nnn(ttt),:);
end




% output_union_block1_1=output_experiment1(:,4);
% output_union_block1_2=output_experiment1(:,10);
% output_union_block2_1=output_contrast1(:,4);
% output_union_block2_2=output_contrast1(:,10);
compare_block1_block2=[output_experiment1(:,4) output_experiment1(:,10) output_contrast1(:,4) output_contrast1(:,10)];
compare_block1_block3=[output_experiment2(:,4) output_experiment2(:,10) output_contrast2(:,4) output_contrast2(:,10)];
compare_block2_block3=[output_experiment3(:,4) output_experiment3(:,10) output_contrast3(:,4) output_contrast3(:,10)];


%%得到三个block的交集是多少
a=1;
b=1;
for c=1:size(output_contrast1,1)
    for cc=1:size(experiment3,1)
        tf4=strcmp(output_contrast1(c,4),experiment3(cc,4));%以Accession为判定识别字符，实验组1_2相交结果与实验组3中Accession相同的提取出来,将实验组作为核心
        if tf4==1
            u(a)=c;
            v(b)=cc;
            a=a+1;
            b=b+1;
        end
    end
end

for r=1:size(u,2)
    output_experiment4(r,:)=output_contrast1(u(r),:);
    output_contrast4(r,:)=experiment3(v(r),:);
end 


aa=1;
bb=1;
for d=1:size(output_experiment1,1)
    for dd=1:size(experiment3,1)
        tf5=strcmp(output_experiment1(d,4),experiment3(dd,4));%以Accession为判定识别字符，实验组2与实验组3中Accession相同的提取出来,将实验组作为核心
        if tf5==1
            uu(aa)=d;
            vv(bb)=dd;
            aa=aa+1;
            bb=bb+1;
        end
    end
end

for rr=1:size(uu,2)
    output_experiment5(rr,:)=output_experiment1(uu(rr),:);
    output_contrast5(rr,:)=experiment3(vv(rr),:);
end 

compare_block1_block2_block3=[output_experiment5(:,4) output_experiment5(:,10) output_experiment4(:,4) output_experiment4(:,10) output_contrast4(:,4) output_contrast4(:,10)];

%%得到三者的全部并集
% union_experiment1=[data_select_experiment1(:,4) data_select_experiment1(:,10)];
% union_experiment2=[data_select_experiment2(:,4) data_select_experiment2(:,10)];
% union_experiment3=[data_select_experiment3(:,4) data_select_experiment3(:,10)];
% union_total=[union_experiment1;union_experiment2;union_experiment3];


union_experiment1=[data_select_experiment1(:,4)];
union_experiment2=[data_select_experiment2(:,4)];
union_experiment3=[data_select_experiment3(:,4)];
union_total=[union_experiment1;union_experiment2;union_experiment3];

data_union1=union(union_experiment1,union_experiment2);
data_union2=union(union_experiment1,union_experiment3);
data_union3=union(union_experiment2,union_experiment3);
data_union_total=union(data_union1,union_experiment3);


data_setdiff1=setdiff(compare_block1_block2(:,1),compare_block1_block2_block3(:,1));%补集
data_setdiff2=setdiff(compare_block1_block3(:,1),compare_block1_block2_block3(:,1));
data_setdiff3=setdiff(compare_block2_block3(:,1),compare_block1_block2_block3(:,1));
data_setdiff_block1_1=setdiff(data_select_experiment1(:,4),data_setdiff1);
data_setdiff_block1_2=setdiff(data_setdiff_block1_1,data_setdiff2);
block1_final=setdiff(data_setdiff_block1_2,compare_block1_block2_block3(:,1));%block1中与block2，3没有任何关系的蛋白

data_setdiff_block2_1=setdiff(data_select_experiment2(:,4),data_setdiff1);
data_setdiff_block2_2=setdiff(data_setdiff_block2_1,data_setdiff3);
block2_final=setdiff(data_setdiff_block2_2,compare_block1_block2_block3(:,1));%block2中与block1，3没有任何关系的蛋白

data_setdiff_block3_1=setdiff(data_select_experiment3(:,4),data_setdiff2);
data_setdiff_block3_2=setdiff(data_setdiff_block3_1,data_setdiff3);
block3_final=setdiff(data_setdiff_block3_2,compare_block1_block2_block3(:,1));%block3中与block1，2没有任何关系的蛋白

a1=1;
for w=1:size(experiment1,1)
    for ww=1:size(block1_final,1)
        tf6=strcmp(experiment1(w,4),block1_final(ww));
        if tf6==1
            x1(a1)=w;
            a1=a1+1;
        end
    end
end
for k1=1:size(x1,2)
    block1_1(k1,:)=experiment1(x1(k1),:);
end 
data_block1_1=[block1_1(:,4) block1_1(:,10)]; %block1中与block1，2没有任何关系的蛋白的PSMs值


a2=1;
for w1=1:size(experiment2,1)
    for ww1=1:size(block2_final,1)
        tf7=strcmp(experiment2(w1,4),block2_final(ww1));
        if tf7==1
            y1(a2)=w1;
            a2=a2+1;
        end
    end
end

for k2=1:size(y1,2)
    block2_1(k2,:)=experiment2(y1(k2),:);
end 

data_block2_1=[block2_1(:,4) block2_1(:,10)]; %block2中与block1，3没有任何关系的蛋白的PSMs值



a3=1;
for w2=1:size(experiment3,1)
    for ww2=1:size(block3_final,1)
        tf8=strcmp(experiment3(w2,4),block3_final(ww2));
        if tf8==1
            z1(a3)=w2;
            a3=a3+1;
        end
    end
end

for k3=1:size(z1,2)
    block3_1(k3,:)=experiment3(z1(k3),:);
end 

data_block3_1=[block3_1(:,4) block3_1(:,10)]; %block3中与block1，2没有任何关系的蛋白的PSMs值


a4=1;
b4=1;
for w3=1:size(experiment1,1)
    for ww3=1:size(data_setdiff1,1)
        tf9=strcmp(experiment1(w3,4),data_setdiff1(ww3));
        if tf9==1
            x2(a4)=w3;
            a4=a4+1;
        end
    end
end

for k4=1:size(x2,2)
    block1_2(k4,:)=experiment1(x2(k4),:);
end 


data_block1_2=[block1_2(:,4) block1_2(:,10)]; %仅block1与block2(与block3无关)蛋白的PSMs值,block1视角


a5=1;
for w4=1:size(experiment2,1)
    for ww4=1:size(data_setdiff3,1)
        tf10=strcmp(experiment2(w4,4),data_setdiff3(ww4));
        if tf10==1
            y2(a5)=w4;
            a5=a5+1;
        end
    end
end

for k5=1:size(y2,2)
    block2_2(k5,:)=experiment2(y2(k5),:);
end 

data_block2_2=[block2_2(:,4) block2_2(:,10)]; %仅block2与block3(与block1无关)蛋白的PSMs值,block2视角


a6=1;
for w5=1:size(experiment3,1)
    for ww5=1:size(data_setdiff2,1)
        tf11=strcmp(experiment3(w5,4),data_setdiff2(ww5));
        if tf11==1
            z2(a6)=w5;
            a6=a6+1;
        end
    end
end

for k6=1:size(z2,2)
    block3_2(k6,:)=experiment3(z2(k6),:);
end 

data_block3_2=[block3_2(:,4) block3_2(:,10)]; %仅block1与block3(与block2无关)蛋白的PSMs值，block3视角



a7=1;
for w6=1:size(experiment2,1)
    for ww6=1:size(data_setdiff1,1)
        tf12=strcmp(experiment2(w6,4),data_setdiff1(ww6));
        if tf12==1
            xx2(a7)=w6;
            a7=a7+1;
        end
    end
end

for k6=1:size(xx2,2)
    block1_2_1(k6,:)=experiment2(xx2(k6),:);
end 

data_block1_2_1=[block1_2_1(:,4) block1_2_1(:,10)]; %仅block1与block2(与block3无关)蛋白的PSMs值,block2视角


a8=1;
for w7=1:size(experiment1,1)
    for ww7=1:size(data_setdiff2,1)
        tf13=strcmp(experiment1(w7,4),data_setdiff2(ww7));
        if tf13==1
            zz2(a8)=w7;
            a8=a8+1;
        end
    end
end

for k7=1:size(z2,2)
    block3_2_1(k7,:)=experiment1(zz2(k7),:);
end 

data_block3_2_1=[block3_2_1(:,4) block3_2_1(:,10)]; %仅block1与block3(与block2无关)蛋白的PSMs值,block1视角


a9=1;
for w8=1:size(experiment3,1)
    for ww8=1:size(data_setdiff3,1)
        tf14=strcmp(experiment3(w8,4),data_setdiff3(ww8));
        if tf14==1
            yy2(a9)=w8;
            a9=a9+1;
        end
    end
end

for k9=1:size(yy2,2)
    block2_2_1(k9,:)=experiment3(yy2(k9),:);
end 

data_block2_2_1=[block2_2_1(:,4) block2_2_1(:,10)]; %仅block2与block3(与block1无关)蛋白的PSMs值,block3视角

test1 = sortrows(data_block1_2);
test2 =sortrows(data_block1_2_1);
test3 = sortrows(data_block2_2);
test4 =sortrows(data_block2_2_1);
test5 = sortrows(data_block3_2);
test6 =sortrows(data_block3_2_1);
compare_block1_block2_block3=sortrows(compare_block1_block2_block3);

data_block1_total=[test1 test2]; %block1与block2
data_block2_total=[test6 test5];%block1与block3
data_block3_total=[test3 test4];%block2与block3
% total_data_merge=[compare_block1_block2_block3; data_block1_total; data_block2_total; data_block3_total];


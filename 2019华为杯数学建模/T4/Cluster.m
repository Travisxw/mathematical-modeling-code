clc,clear
filename='Data';
input=xlsread(filename,1,'B2:XR642');
a=input(1:400,1:400);
X=a;
clusterNum=27;
y=pdist(a,'seuclidean');  %求a的两两行向量间的绝对值距离
yc=squareform(y)  %变换成距离方阵
z=linkage(y)  %产生等级聚类树
[h,t]=dendrogram(z) %画聚类图
T=cluster(z,'maxclust',clusterNum)  %把对象划分成3类
for i=1:clusterNum
    tm=find(T==i);  %求第i类的对象
    tm=reshape(tm,1,length(tm)); %变成行向量
    fprintf('第%d类的有%s\n',i,int2str(tm)); %显示分类结果
end

opts = statset('Display','final');
[idx,ctrs] = kmeans(X,clusterNum,'Distance','city','Replicates',27);
figure
for i=1:clusterNum
    plot(X(idx==i,1),X(idx==i,2),'.','MarkerSize',12)
    hold on
end

plot(ctrs(:,1),ctrs(:,2),'ko','MarkerSize',7,'LineWidth',1.5)
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5'...
    ,'Cluster 6','Cluster 7','Cluster 8','Cluster 9','Cluster 10'...
    ,'Cluster 11','Cluster 12','Cluster 13','Cluster 14','Cluster 15'...
    ,'Cluster 16','Cluster 17','Cluster 18','Cluster 19','Cluster 20'...
    ,'Cluster 21','Cluster 22','Cluster 23','Cluster 24','Cluster 25'...
    ,'Cluster 26','Cluster 27'...
    ,'Centroids','Location','NW')   
xlabel 'Key Words Lengths';
ylabel 'Key Words Lengths'; 
title 'Cluster Assignments and Centroids';








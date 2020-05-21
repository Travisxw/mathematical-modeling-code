clc,clear
filename='Data';
input=xlsread(filename,1,'B2:XR642');
a=input(1:400,1:400);
X=a;
clusterNum=27;
y=pdist(a,'seuclidean');  %��a��������������ľ���ֵ����
yc=squareform(y)  %�任�ɾ��뷽��
z=linkage(y)  %�����ȼ�������
[h,t]=dendrogram(z) %������ͼ
T=cluster(z,'maxclust',clusterNum)  %�Ѷ��󻮷ֳ�3��
for i=1:clusterNum
    tm=find(T==i);  %���i��Ķ���
    tm=reshape(tm,1,length(tm)); %���������
    fprintf('��%d�����%s\n',i,int2str(tm)); %��ʾ������
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








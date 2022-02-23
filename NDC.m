function [Label, W_ori,I_ori,K_array,rho,roots_idx,Flag] = NDC(data,nClass,theta,cut_method)
if nargin < 2
    error('at least two inputs are needed');
end
if nargin<3
    theta = 0.01;
end
if nargin<4
    cut_method = 3;
end

N = size(data,1);
D = squareform(pdist(data));
D_ori = D;
sigma = quantile(squareform(D),theta);

% Stage 1: construct the IT
S=exp(-D/sigma);
rho = sum(S,2); 
clear S;
P=-rho;
C=repmat(P',N,1)-repmat(P,1,N);
D(C>0)=inf;
D((C==0)&(tril(ones(N,N))))=inf;
[W,I]=min(D,[],2); clear D; clear C;
idx=find(isinf(W)); initial_root = idx;
I(idx)=idx; W(idx)=0;

% Stage 2: remove the undesired edges
Flag = ones(N,1); W_ori = W; I_ori = I;
K_array = [];
for i = 1:N
    K_array(i) = sum(D_ori(i,:)<W(i));
end

startNode_of_cutEdge = [];
switch cut_method
    case 1
        for i=1:nClass-1 
            [u,idx]=max(W); 
            I(idx)=idx; W(idx)=0; 
            Flag(idx) = 2; 
            startNode_of_cutEdge = [startNode_of_cutEdge,idx];
        end
    case 2
        W = rho.*W;
        for i=1:nClass-1 
            [u,idx]=max(W); 
            I(idx)=idx; 
            W(idx)=0; 
            Flag(idx) = 2;
            startNode_of_cutEdge = [startNode_of_cutEdge,idx];
        end
    case 3
        W = K_array;
        for i=1:nClass-1
            [u,idx]=max(W);
            I(idx)=idx;
            W(idx)=0;
            Flag(idx) = 2;
            startNode_of_cutEdge = [startNode_of_cutEdge,idx];
        end 
end

% Stage 3: gather at the root nodes and cluster assignment
I_old = (1:N)';
while norm(I-I_old), I_old=I; I=I_old(I_old); end 
 
roots_idx = [initial_root,startNode_of_cutEdge];
Label = zeros(N,1);
for i=1:length(roots_idx), Label(I==roots_idx(i))=i; end
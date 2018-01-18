function Forest = IsolationForest(Data, NumTree, NumSub, NumDim, rseed)
%
% F. T. Liu, K. M. Ting, and Z.-H. Zhou.
% Isolation forest.
% In Proceedings of ICDM, pages 413-422, 2008.
% 
% function IsolationForest: build isolation forest
%
% Input:
%     Data: n x d matrix; n: # of instance; d: dimension;
%     NumTree: # of isolation trees;
%     NumSub: # of sub-sample;
%     NumDim: # of sub-dimension;
%     rseed: random seed;
%
% Output:
%     Forest.Trees: a half space forest model;
%     Forest.NumTree: NumTree;
%     Forest.NumSub: NumSub;
%     Forest.NumDim: NumDim;
%     Forest.HeightLimit: height limitation;
%     Forest.c: a normalization term for possible usage;
%     Forest.ElapseTime: elapsed time;
%     Forest.rseed: rseed;
%

[NumInst, DimInst] = size(Data);
Forest.Trees = cell(NumTree, 1);

Forest.NumTree = NumTree;
Forest.NumSub = NumSub;
Forest.NumDim = NumDim;
Forest.HeightLimit = ceil(log2(NumSub));
Forest.c = 2 * (log(NumSub - 1) + 0.5772156649) - 2 * (NumSub - 1) / NumSub;
Forest.rseed = rseed;
rand('state', rseed);

% parameters for function IsolationTree
Paras.HeightLimit = Forest.HeightLimit;
Paras.NumDim = NumDim;

et = cputime;
for i = 1:NumTree
    
    if NumSub < NumInst % randomly selected sub-samples
        [temp, SubRand] = sort(rand(1, NumInst));
        IndexSub = SubRand(1:NumSub);
    else
        IndexSub = 1:NumInst;
    end
    if NumDim < DimInst % randomly selected sub-dimensions
        [temp, DimRand] = sort(rand(1, DimInst));
        IndexDim = DimRand(1:NumDim);
    else
        IndexDim = 1:DimInst;
    end
    
    Paras.IndexDim = IndexDim;
    Forest.Trees{i} = IsolationTree(Data, IndexSub, 0, Paras); % build an isolation tree
    
end

Forest.ElapseTime = cputime - et;

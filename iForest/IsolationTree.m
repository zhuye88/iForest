function Tree = IsolationTree(Data, CurtIndex, CurtHeight, Paras)
% 
% Function IsolationTree: build an isolation tree
% 
% Inputs:
%     Data: n x d matrix; n: # of instance; d: dimension (the whole data set);
%     CurtIndex: vector; indices of the current data instances;
%     CurtHeight: current height;
%     Paras.IndexDim: sub-dimension index;
%     Paras.NumDim:  # of sub-dimension;
%     Paras.HeightLimit: maximun height limitation;
% 
% Outputs:
%     Tree: an isolation tree model
%     Tree.NodeStatus: 1: inNode, 0: exNode;
%     Tree.SplitAttribute: splitting attribute;
%     Tree.SplitPoint: splitting point;
%     Tree.LeftChild: left child tree which is also a half space tree model;
%     Tree.RightChild: right child tree which is also a half space tree model;
%     Tree.Size: node size;
%     Tree.Height: node height;
% 
% Reference:
%     F. T. Liu, K. M. Ting, and Z.-H. Zhou.
%     Isolation Forest.
%     In Proceedings of ICDM, pages 413-422, 2008.
% 
% Copyright by Guang-Tong Zhou, April, 22, 2012 (zhouguangtong@gmail.com).
% 
Tree.Height = CurtHeight;
NumInst = length(CurtIndex);

if CurtHeight >= Paras.HeightLimit || NumInst <= 1
    Tree.NodeStatus = 0;
    Tree.SplitAttribute = [];
    Tree.SplitPoint = [];
    Tree.LeftChild = [];
    Tree.RightChild = [];
    Tree.Size = NumInst;
    return;
else
    Tree.NodeStatus = 1;
    % randomly select a splitting attribute
    [temp, rindex] = max(rand(1, Paras.NumDim));
    Tree.SplitAttribute = Paras.IndexDim(rindex);
    CurtData = Data(CurtIndex, Tree.SplitAttribute);
    v = max(CurtData) - min(CurtData);
    Tree.SplitPoint = min(CurtData) + v * rand(1);
    Tree.UpperLimit = Tree.SplitPoint + v;
    Tree.LowerLimit = Tree.SplitPoint - v;
    
    % instance indices for the left child and the right child
    LeftCurtIndex = CurtIndex(CurtData < Tree.SplitPoint);
    RightCurtIndex = setdiff(CurtIndex, LeftCurtIndex);
    
    % bulit right and left trees
    Tree.LeftChild = IsolationTree(Data, LeftCurtIndex, CurtHeight + 1, Paras);
    Tree.RightChild = IsolationTree(Data, RightCurtIndex, CurtHeight + 1, Paras);
    
    iTree.size = [];
end

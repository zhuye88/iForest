function mass = IsolationMass(Data, CurtIndex, Tree, mass)
% 
% F. T. Liu, K. M. Ting, and Z.-H. Zhou.
% Isolation forest.
% In Proceedings of ICDM, pages 413-422, 2008.
% 
% function IsolationMass: estimate the mass and depth of test instances on an isolation tree
% 
% Input:
%     Data: n x d matrix; n: # of instance; d: dimension;
%     CurtIndex: index of current data instance;
%     Tree: a half space tree;
%     mass: n x 1 vector; previously estimated mass;
% 
% Output:
%     mass: currently estimated mass;
%     depth: currently estimated depth;
% 

if Tree.NodeStatus == 0
    
    if Tree.Size <= 1
        mass(CurtIndex) = Tree.Height;
    else
        c = 2 * (log(Tree.Size - 1) + 0.5772156649) - 2 * (Tree.Size - 1) / Tree.Size;
        mass(CurtIndex) = Tree.Height + c;
    end
    return;
    
else
    
    LeftCurtIndex = CurtIndex(Data(CurtIndex, Tree.SplitAttribute) < Tree.SplitPoint);
    RightCurtIndex = setdiff(CurtIndex, LeftCurtIndex);
    
    if ~isempty(LeftCurtIndex)
        mass = IsolationMass(Data, LeftCurtIndex, Tree.LeftChild, mass);
    end
    if ~isempty(RightCurtIndex)
        mass = IsolationMass(Data, RightCurtIndex, Tree.RightChild, mass);
    end
    
end

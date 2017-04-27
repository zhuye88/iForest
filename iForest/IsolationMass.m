function IsolationMass(Data, CurtIndex, Tree, result,Harmonic)
% 
% Function IsolationMass: estimate the mass and depth of test instances on an isolation tree
% 
% Inputs:
%     Data: n x d matrix; n: # of instance; d: dimension;
%     CurtIndex: vector; indices of the current data instances;
%     Tree: structure; a half space tree;
%     mass: n x 1 vector; previously estimated mass;
% 
% Outputs:
%     mass: currently estimated mass;
%     depth: currently estimated depth;
% 
% Reference:
%     F. T. Liu, K. M. Ting, and Z.-H. Zhou.
%     Isolation Forest.
%     In Proceedings of ICDM, pages 413-422, 2008.
% 
% Copyright by Guang-Tong Zhou, April, 22, 2012 (zhouguangtong@gmail.com).
% 
if Tree.NodeStatus == 0
    
    if Tree.Size <= 1
        result.mass(CurtIndex) = Tree.Height;
    else
%         c = 2 * (log(Tree.Size - 1) + 0.5772156649) - 2 * (Tree.Size - 1) / Tree.Size;
        c = 2 * ( Harmonic(Tree.Size) - 1);
        result.mass(CurtIndex) = Tree.Height + c;
    end
    return;
    
else
    CurtData = Data(CurtIndex, Tree.SplitAttribute);
    LeftCurtIndex = CurtIndex(((CurtData >= Tree.LowerLimit)  & (CurtData < Tree.SplitPoint)));
    RightCurtIndex = CurtIndex(((CurtData <= Tree.UpperLimit)  & (CurtData >= Tree.SplitPoint)));
    
    if ~isempty(LeftCurtIndex)
       IsolationMass(Data, LeftCurtIndex, Tree.LeftChild, result,Harmonic);
    end
    if ~isempty(RightCurtIndex)
        IsolationMass(Data, RightCurtIndex, Tree.RightChild, result,Harmonic);
    end
    
%      mass(CurtIndex(Data(CurtIndex, Tree.SplitAttribute) < Tree.LowerLimit)) = 0;
%      mass(CurtIndex(Tree.UpperLimit < Data(CurtIndex, Tree.SplitAttribute))) = 0;

end

classdef TreeNode_iForest < handle
    
    properties
        LeftChild = []; %TreeNode.empty;
        RightChild = []; %TreeNode.empty;
        NodeStatus = uint8(1);
        SplitAttribute = uint16(0);
        SplitPoint = 0;
        Size = 0;   
        Height = uint16(0);
        UpperLimit = 0;
        LowerLimit = 0;
    end
    
    methods
        function node = TreeNode_iForest(Data, CurtIndex, CurtHeight, Paras)
                NumInst = size(CurtIndex,2);    
                node.Height = uint16(CurtHeight);
                node.Size = NumInst;
%                

                if (length(CurtIndex) <= 1) || (CurtHeight >= Paras.HeightLimit) 
                    node.NodeStatus = uint8(0);
                    return;
                    
                else

                    % randomly select a splitting attribute
                    node.SplitAttribute = uint16(randi(Paras.NumDim));
                    CurtData = Data(CurtIndex, node.SplitAttribute);

                    v = max(CurtData) - min(CurtData);
                    node.SplitPoint = min(CurtData) + (v) * rand(1);

                    node.UpperLimit = node.SplitPoint +  v;
                    node.LowerLimit = node.SplitPoint - v;

                    % bulit right and left trees
                    node.LeftChild = TreeNode_iForest(Data, CurtIndex(CurtData < node.SplitPoint), CurtHeight + 1, Paras);
                    node.RightChild = TreeNode_iForest(Data, CurtIndex(CurtData >= node.SplitPoint), CurtHeight + 1, Paras);
%                     clearvars CurtData v NumInst LeftCurtIndex RightCurtIndex
                end
        end
    end
end


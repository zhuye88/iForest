function [Mass, ElapseTime] = IsolationEstimation(TestData, Forest)
% 
% Function IsolationEstimation: estimate test instance mass on isolation forest
% 
% Inputs:
%     TestData: test data; nt x d matrix; nt: # of test instance; d: dimension;
%     Forest: structure; isolation forest model;
% 
% Outputs:
%     Mass: nt x NumTree matrix; mass of test instances;
%     ElapseTime: elapsed time;
% 
% Reference:
%     F. T. Liu, K. M. Ting, and Z.-H. Zhou.
%     Isolation Forest.
%     In Proceedings of ICDM, pages 413-422, 2008.
% 
% Copyright by Guang-Tong Zhou, April, 22, 2012 (zhouguangtong@gmail.com).
% 
NumInst = size(TestData, 1);
Mass = zeros(NumInst, Forest.NumTree);
Harmonic = GetHarmonicSeries(Forest.NumSub);

et = cputime;
for k = 1:Forest.NumTree
    result = Result_iForest(NumInst);
    IsolationMass(TestData, 1:NumInst, Forest.Trees{k, 1}, result,Harmonic);
    Mass(:, k) = result.mass;
end
ElapseTime = cputime - et;
end

function Harmonic = GetHarmonicSeries(NumSub)
    Harmonic = zeros(NumSub,1);
    Harmonic(1)  = 1;
    
    for i = 2:NumSub
        Harmonic(i) = Harmonic(i - 1) + 1/i;
    end
end
function [Mass, ElapseTime] = IsolationEstimation(TestData, Forest)
% 
% F. T. Liu, K. M. Ting, and Z.-H. Zhou.
% Isolation forest.
% In Proceedings of ICDM, pages 413-422, 2008.
% 
% function IsolationEstimation: estimate test instance mass on isolation forest
% 
% Input:
%     TestData: test data; nt x d matrix; nt: # of test instance; d: dimension;
%     Forest: isolation forest model;
% 
% Output:
%     Mass: nt x NumTree matrix; mass of test instances;
%     ElapseTime: elapsed time;
% 

NumInst = size(TestData, 1);
Mass = zeros(NumInst, Forest.NumTree);

et = cputime;
for k = 1:Forest.NumTree
    Mass(:, k) = IsolationMass(TestData, 1:NumInst, Forest.Trees{k, 1}, zeros(NumInst, 1));
end
ElapseTime = cputime - et;

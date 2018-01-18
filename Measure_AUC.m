function AccumAuc = Measure_AUC(Scores, Labels)
% Area Under Curve for Amonaly
% 
% Scores: predicted scores;
% Labels: groundtruth labels, PosLabel = 1& NegLabel = 0;

NumInst = length(Scores);

% sort Scores and Labels
[Scores, index] = sort(Scores, 'descend');
Labels = Labels(index);

PosLabel = 1;
NegLabel = 0;

NumPos = length(find(Labels == PosLabel));
NumNeg = length(find(Labels == NegLabel));

AccumPos = 0;
AccumNeg = 0;
AccumAuc = 0;

UnitPos = 1 / NumPos;
UnitNeg = 1 / NumNeg;

i = 1;
while i <= NumInst
    temp = AccumPos;
    if (i < NumInst - 1) && (Scores(i) == Scores(i + 1))
        while (i < NumInst - 1) && (Scores(i) == Scores(i + 1))
            if Labels(i) == NegLabel
                AccumNeg = AccumNeg + 1;
            elseif Labels(i) == PosLabel
                AccumPos = AccumPos + 1;
            else
                disp('Label is not defined!');
            end
            i = i + 1;
        end

        if Labels(i) == NegLabel
            AccumNeg = AccumNeg + 1;
        elseif Labels(i) == PosLabel
            AccumPos = AccumPos + 1;
        else
            disp('Label is not defined!');
        end

        AccumAuc = AccumAuc + (AccumPos + temp) * UnitPos * AccumNeg * UnitNeg / 2;
        AccumNeg = 0;
    else
        if Labels(i) == NegLabel
            AccumNeg = AccumNeg + 1;
            AccumAuc = AccumAuc + AccumPos * UnitPos * AccumNeg * UnitNeg;
            AccumNeg = 0;
        elseif Labels(i) == PosLabel
            AccumPos = AccumPos + 1;
        else
            disp('Label is not defined');
        end
    end
    i = i + 1;
end
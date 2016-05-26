function [idx, C, frames, k] = clustering(gestureExamples)

count = 1;

[d, ~] = size(find(gestureExamples{1}(:,:,1)));
X = zeros(d,1);
numExamples = size(gestureExamples,2);
frames = zeros(1,numExamples);

for i = 1:numExamples
    [joint, pos, frame] = size(gestureExamples{i});
    frames(i) = frame;
    example = gestureExamples{i};
    for j = 1:frame
        framej = example(:,:,j);
        X(:,count) = framej(find(gestureExamples{i}(:,:,j)));
        count = count + 1;
    end;
end;

k = round(mean(frames)/2)-6;

[idx, C] = kmeans(X', k);

idx = idx'; C = C';

coeff = pca(X');                            %
testing = coeff'*X;                         % Just seeing if the dimensionality 
[idxTest, CTest] = kmeans(testing', k);     % reduction could be a viable
idxTest = idxTest'; CTest = CTest';         % option for clustering.
                                            %
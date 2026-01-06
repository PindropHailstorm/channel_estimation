function [Xcell, Ycell, inputSize] = preprocess_dataset(dataset)
% Converts dataset.* into cell arrays Xcell, Ycell suitable for trainNetwork
% Each time step feature vector = real+imag flattened: (K*L*R*2) features


numSeq = numel(dataset.input);
Xcell = cell(numSeq,1);
Ycell = cell(numSeq,1);
for i=1:numSeq
inGrid = dataset.input{i}; % K x L x R x T
outGrid = dataset.output{i}; % K x L x R x T
[K,L,R,T] = size(inGrid);
F = K*L*R;
seqX = zeros(F*2, T); % real + imag
seqY = zeros(F*2, T);
for t=1:T
x = inGrid(:,:,:,t);
y = outGrid(:,:,:,t);
% flatten
vx = reshape(x, [], 1);
vy = reshape(y, [], 1);
% split real/imag
seqX(:,t) = [real(vx); imag(vx)];
seqY(:,t) = [real(vy); imag(vy)];
end
Xcell{i} = seqX;
Ycell{i} = seqY;
end
inputSize = size(Xcell{1},1);
end
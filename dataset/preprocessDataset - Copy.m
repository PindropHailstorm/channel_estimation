function [X, Y, inputSize] = preprocessDataset(dataset)
N = length(dataset.input);
for i = 1:N
    in = dataset.input{i};
    out = dataset.output{i};
    [K,L,R,T] = size(in);
    F = K*L*R;
    X{i} = reshape(in, F, T);
    Y{i} = reshape(out, F, T);
end
inputSize = size(X{1},1);
end
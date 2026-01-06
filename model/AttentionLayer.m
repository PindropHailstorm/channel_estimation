classdef AttentionLayer < nnet.layer.Layer
properties (Learnable)
    Weights
end
methods
    function layer = AttentionLayer(numHiddenUnits, name)
        layer.Name = name;
        layer.Weights = randn(numHiddenUnits, numHiddenUnits);
    end
    function Z = predict(layer, X)
        scores = layer.Weights * X;
        attention = softmax(scores, 2);
        Z = sum(attention .* X, 2);
    end
end
end
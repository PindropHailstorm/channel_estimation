function net = createAttentionLSTM(inputSize, hiddenSize, ~)

    layers = [
        sequenceInputLayer(inputSize, 'SplitComplexInputs', true)

        lstmLayer(hiddenSize,'OutputMode','sequence')
        dropoutLayer(0.2)

        lstmLayer(hiddenSize,'OutputMode','sequence')
        dropoutLayer(0.2)

        fullyConnectedLayer(hiddenSize)
        softmaxLayer

        fullyConnectedLayer(inputSize)
        regressionLayer
    ];

    net = layerGraph(layers);
end

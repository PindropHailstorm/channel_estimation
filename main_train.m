clear; clc;
carrier = config_carrier();
pdsch   = config_pdsch();
channel = config_channel();
if ~isfile('dataset/dataset_temporal.mat')
    dataset = generateTemporalDataset(carrier, pdsch, channel, 200, 14);
    save('dataset/dataset_temporal.mat', 'dataset', '-v7.3');
else
    load('dataset/dataset_temporal.mat');
end
[X, Y, inputSize] = preprocessDataset(dataset);
net = createAttentionLSTM(inputSize, 256, 2);

netTrained = trainModel(net, X, Y);
save('trainedModel.mat', 'netTrained');
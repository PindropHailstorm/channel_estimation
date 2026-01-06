function netTrained = trainModel(net, X, Y)
opts = trainingOptionsConfig();
netTrained = trainNetwork(X, Y, net, opts);
end
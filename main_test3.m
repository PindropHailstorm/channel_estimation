% load + preprocess (as in your snippet)
load('trainedModel.mat');                     % expects netTrained
load('dataset/dataset_temporal.mat');         % expects dataset
[X, Y, inputSize] = preprocessDataset(dataset);

N = numel(X);
nmse_linear = zeros(5,1);   % store linear NMSE
for ii = 1:5
    yPred = predict(netTrained, X{ii});
    % If computeNMSE returns linear NMSE:
    %nmse_linear(ii) = computeNMSE(Y{ii}, yPred);
    % If computeNMSE already returns dB, comment previous line and use:
     nmse_db(ii) = computeNMSE(Y{ii}, yPred);
end

% Convert to dB (if you stored linear NMSE)
%nmse_db = 10*log10(nmse_linear);

fprintf('Mean NMSE = %.2f dB (N = %d)\n', mean(nmse_db), N);
fprintf('Median NMSE = %.2f dB\n', median(nmse_db));

% Visualize first few examples
for k = 1:min(5,N)
    figure;
    visualizeChannel(Y{k}, predict(netTrained, X{k}));
    title(sprintf('Example %d — NMSE = %.2f dB', k, nmse_db(k)));
end

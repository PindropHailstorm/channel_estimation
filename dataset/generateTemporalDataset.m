function dataset = generateTemporalDataset(carrier, pdsch, channel, numSequences, sequenceLength)
% Generate sequential (temporal) dataset using real 5G Toolbox functions

dataset = struct();

for seq = 1:numSequences
    reset(channel);

    seq_in = [];
    seq_out = [];

    for slot = 1:sequenceLength

        carrier.NSlot = slot-1;

        % -------------------
        % Build TX Resource Grid
        % -------------------
        txGrid = nrResourceGrid(carrier, pdsch.NumLayers);

        % Get PDSCH indices and required bit count
       [ind, info] = nrPDSCHIndices(carrier, pdsch);
       numBits = info.G;

        % Generate random bits
        bits = randi([0 1], numBits, 1);
 
        % Modulate
        pdschSymbols = nrPDSCH(carrier, pdsch, bits);

        % Map onto grid
        txGrid(ind) = pdschSymbols;

        % -------------------
        % OFDM Modulate
        % -------------------
        txWaveform = nrOFDMModulate(carrier, txGrid);

        % -------------------
        % Channel
        % -------------------
        [rxWaveform, pathGains, sampleTimes] = channel(txWaveform);

        SNR = randi([-10 30]);
        rxWaveform = awgn(rxWaveform, SNR, "measured");

        % -------------------
        % OFDM Demod
        % -------------------
        rxGrid = nrOFDMDemodulate(carrier, rxWaveform);

        % -------------------
        % Perfect Channel
        % -------------------
        pathFilters = getPathFilters(channel);
        [offset, ~] = nrPerfectTimingEstimate(pathGains, pathFilters);

        H = nrPerfectChannelEstimate( ...
            carrier, pathGains, pathFilters, offset, sampleTimes);

        % -------------------
        % Temporal stacking
        % -------------------
        seq_in  = cat(4, seq_in,  rxGrid);
        seq_out = cat(4, seq_out, H);

    end

    dataset.input{seq} = seq_in;
    dataset.output{seq} = seq_out;

    if mod(seq, 5) == 0
        fprintf("Generated %d/%d sequences\n", seq, numSequences);
    end
end

end

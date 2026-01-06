function channel = config_channel()
channel = nrTDLChannel;
channel.DelayProfile = 'TDL-C';
channel.MaximumDopplerShift = 70;
channel.SampleRate = 30.72e6;
end
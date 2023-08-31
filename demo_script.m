clear; clc
sf = 44100; dur = 1;
noise = randn(sf*dur,1);

buff_size = 256; 
overlap = buff_size/2; % 50 percent
buff_noise = buffer(noise, buff_size, overlap);
out = unbuffer(buff_noise, buff_size, overlap);
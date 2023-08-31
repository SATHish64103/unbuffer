function out = unbuffer(signal, buff_size, overlap)
% signal = single channel signal splited using MATLAB's buffer command [buffer_size x n_buffers]
% buff_size = length of buffered signal [in samples]
% overlap = number of samples considered for overlapping 

% Duplicate last buffer to avoid error
x = signal(:,end);
signal = [signal, [x(overlap+1:end); zeros(overlap,1)]];

% Apply window to create overlap
win = hann(buff_size,"periodic");

out = [];
for ii = 1:length(signal)-1
    if ii == 1
        a = signal(:,ii).*win;
        b = signal(:,ii+1).*win;
        c = [a; zeros(overlap,1)];
        d = [zeros(overlap*ii,1); b];
        out = c + d;
    else
        a = out;
        b = signal(:,ii+1).*win;
        c = [a; zeros(overlap,1)];
        d = [zeros(overlap*ii,1); b];
        out = c + d;
    end
end
out = out(overlap+1: end-overlap);

function [Dbpf,sp_bpf,f]=bpf(data,dt,N,cutoff)
% band-pass frequency filter
% data = input shot gathers
% N = the BPF fir filter length
% cut_off = vector equal to f_low and f_high cut-off values
% Dbpf = BP filtered data
% sp_bpf = BP filtered data spectra
% f = a vector containing the frequency values

[nt,nx] = size(data);
nt_fft = 2*nt;
data_f = fx(data,dt,nt_fft);
B = fir1(N,cutoff*2*dt);
HH = fft(B,nt_fft);
HH = conj(HH)';

sp_bpf = zeros(size(data_f));
for i = 1:nx
    sp_bpf(:,i) = data_f(:,i).*HH;
end
Dbpf = real(ifft(sp_bpf,[],1));
Dbpf = Dbpf(1+(length(B)-1)/2:nt+(length(B)-1)/2,:);
%importing audio file
clc;
clear;
close;

%Importing Audio File and storing sampling frequency
[inp,fs]=audioread('C:\Users\91771\Desktop\College\sem5\SS\test5.mp3');
% sound(inp,fs)
t=0:length(inp)-1;
subplot(5,1,1);
plot(t,inp);
title("Input");
xlabel("time");
ylabel("Amplitude");

%Increasing frequency(time scaling)
pitchup = shiftPitch(inp,4);
% sound(pitchup,fs);
subplot(5,1,2);
plot(t,pitchup);
title("High Pitch");
xlabel("time");
ylabel("Amplitude");

%Decreasing frequency(time scaling)
pitchdown=shiftPitch(inp,-4);
% sound(pitchdown,fs);
subplot(5,1,3);
plot(t,pitchdown);
title("Low Pitch");
xlabel("time");
ylabel("Amplitude");

%distorting input signal (quantization)
partition=[-1:0.2:1]*round(max(inp),1);
codebook = [-1.2:0.2:1]*round(max(inp),1);
[index,quants]=quantiz(inp,partition,codebook);
% sound(quants,fs);
figure(2);
plot(t,inp,'.b',t,quants,'.r');
title("Quantized");
xlabel("time");
ylabel("Amplitude");

%Adding the scaled and original signals (Signal Addition)
final= pitchup+pitchdown+inp;
% sound(final,fs);
figure(1);
subplot(5,1,4);
plot(t,final);
title("Scrambled Signal");
xlabel("time");
ylabel("Amplitude");

%Adding some noise to the signal to make it undetectable (Amplitude
%scaling)
rfinal=final (:,1);
noised = rfinal + 0.1 * randn(size(rfinal));
% sound(noised,fs);
subplot(5,1,5);
plot(t,noised);
title("Scrambled Signal with noise");
xlabel("time");
ylabel("Amplitude");

% Quantizing final signal for distortion and ease of transmission
finalpartition=[-1:0.2:1]*round(max(noised),1);
finalcodebook = [-1.2:0.2:1]*round(max(noised),1);
[finalindex,finalquants]=quantiz(noised,finalpartition,finalcodebook);
% sound(finalquants,fs);



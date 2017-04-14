%% Simulation Exercise number2
clear all
close all
%%      1 Preparations
gammabar = 42.58e6;
gamma = 2*pi*gammabar;
%%      2 The Signal
B0 = 2;
tp = 10e-6;
iv = ImagingVolume(0, 0, 0.5, 0.02);  %T1=0.5s and T2= 0.02s
f = gammabar*B0;
B1 = [5.9e-3, 5.9e-3, 2.9e-3];  %Calculated
%Rectangular RF pulses
rf1 = RectPulse(B1(1), f, pi/2, tp);
rf2 = RectPulse(B1(2), f, -pi/2, tp);
rf3 = RectPulse(B1(3), f, pi/4, tp);

% Creation of the ADC for the object, obtaining digital form
[S1,ts] = seemri(iv,B0,rf1,[],[],ADC(0.2,0.2/100));
iv.toEquilibrium();
[S2,ts] = seemri(iv,B0,rf2,[],[],ADC(0.2,0.2/100));
iv.toEquilibrium();
[S3,ts] = seemri(iv,B0,rf3,[],[],ADC(0.2,0.2/100));
iv.toEquilibrium();
%%
figure;
subplot(2,1,1);
plot(ts, abs(S1), ts, abs(S2), '--', ts, abs(S3), '-.');
xlabel ('Time');
ylabel('Signal magnitude');
subplot(2,1,2);
plot(ts, angle(S1), ts, angle(S2), '--',ts,angle(S3),'-.');
xlabel('Time (s)')
ylabel('Signal phase(radians)');

%% Preguntas
% Porque el Beff no esta rotando?, la magnitud y fase no deberian de afectar

% Q1. En amplitud, las tres cumplen con T1 y tienen el mismo
% comportamiento. para rf1 y rf2 tienen exactamente la misma ampl para la
% fase no se
% Q2. las funciones de S(t).

%%      3. The Spin Echo
iv = ImagingVolume(-4:1:4, -4:1:4, 0.5, 0.02, 1, 'dB0Gamma', 1e-6);
B0 = 2;
tp = 10e-6;
phi_rf = [0 pi/2];

B1_90 = pi/2 / (gamma*tp);
B1_180 = pi / (gamma*tp);
f_rf = gammabar * B0;

rf = RectPulse([B1_90 B1_180], f_rf, phi_rf, tp, [0 5e-3]); 
% figure
% plot(rf);
figure

[S, ts] = seemri(iv, B0, rf, [], [], ADC(0.02, 0.02/100));

% Q3. echo at t=0.01s=10ms ->2t?

%%
B0 = 2;
G = 1.2e-6;
tau = 5e-3;
iv = ImagingVolume(-4:1:4, -4:1:4, 0.5, 0.02, 1, 'dB0Gamma', 0.1e-6);

Gx = Gradient([tp tp+tau tp+3*tau], [-G 2*G 0]);





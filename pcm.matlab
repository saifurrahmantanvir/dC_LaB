clc; clear; close all;

%% ----- User Inputs -----
fm = input('Enter message signal frequency (Hz): ');  % Message signal frequency
fs = input('Enter sampling frequency (Hz): ');  % Sampling frequency
L = input('Enter number of quantization levels (L): '); % Quantization levels

%% Automatically calculate number of bits
n = ceil(log2(L));
fprintf('Calculated number of bits: %d\n', n);

%% Step 1: Generate Analog Signal
t = 0:0.001:1;  % Time vector for analog signal 
x = sin(2*pi*fm*t); % Analog message signal

%% Step 2: Sampling
ts = 0:1/fs:1;  % Time vector for sampled signal
x_sampled = sin(2*pi*fm*ts);  % Sampled signal

%% Step 3: Quantization
x_min = min(x_sampled);
x_max = max(x_sampled);
q_step = (x_max - x_min) / L; % Quantization step size

% Compute quantization indices, clamp to [0, L-1]
q_index = min(round((x_sampled - x_min) / q_step), L-1);

% Reconstruct quantized signal from indices
x_quantized = q_index * q_step + x_min;

%% Step 4: PCM Encoding (Binary)
pcm_encoded = dec2bin(q_index, n);  % Convert to binary (char matrix)

% Flatten into bit stream
bit_stream = [];
for i = 1:length(q_index)
  bit_stream = [bit_stream, pcm_encoded(i,:) - '0'];  % Convert '0'/'1' to 0/1
end

%{ 
%% Step 5: Line Coding (Unipolar NRZ) 
bit_time = 1; % Duration of each bit 
points_per_bit = 100; % Resolution for plotting
t_line = 0:1/points_per_bit:bit_time*length(bit_stream); 
line_signal = zeros(1, length(t_line));

for i = 1:length(bit_stream)
  idx_start = (i-1)*points_per_bit + 1;
  idx_end = i*points_per_bit;
  line_signal(idx_start:idx_end) = bit_stream(i);
end
%}

%% ---------------- PLOTS ---------------- 
figure('Position',[100 100 800 1000]);

subplot(5,1,1);
plot(t, x, 'b', 'LineWidth', 1.5); grid on;
title('Original Analog Signal');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(5,1,2);
stem(ts, x_sampled, 'r', 'filled'); grid on;
title('Sampled Signal');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(5,1,3);
stairs(ts, x_quantized, 'g', 'LineWidth', 1.5); grid on;
title('Quantized Signal');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(5,1,4);
stairs(bit_stream, 'm', 'LineWidth', 1.5); grid on;
title('PCM Encoded Bit Stream');
xlabel('Bit Index'); ylabel('Bit Value');
axis([0 length(bit_stream) -0.5 1.5]);

%{
subplot(5,1,5);
plot(t_line, line_signal, 'k', 'LineWidth', 1.5); grid on;
title('Line Coded Signal (Unipolar NRZ)');
xlabel('Time'); ylabel('Voltage Level');
axis([0 length(t_line)/points_per_bit -0.2 1.2]);
%}
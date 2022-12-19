% Load splat which adds y and Fs to the workspace
load handel
% Call echo_gen to create the new audio data
output = echo_gen(y, Fs, 0.25, 0.6);
% The time between points is 1/Fs;
dt = 1/Fs;
% Plot the original sound
plot(0:dt:dt*(length(y)-1), y)
% Plot the new data to see visualize the echo
figure
plot(0:dt:dt*(length(output)-1), output)

% sound (output, Fs) % Uncomment in MATLAB to listen to the new sound data


function output=echo_gen(input,fs,delay,amp)
row=length(input);
new_delay=round(delay*fs);
if new_delay<=row
    for i=1:(row+new_delay)
        if i<=new_delay
            out(i,1)=input(i,1);
        elseif i>new_delay && i<=row
        out(i,1)=input(i)+amp*input(i-new_delay,1);
        else 
            out(i,1)=amp*input(i-new_delay, 1);
        end
    end
else
   for i=1:(row+new_delay)
        if i<=row
            out(i,1)=input(i,1);
        elseif i>row && i<=new_delay
            out(i,1)=0;
        else 
            out(i,1)=amp*input(i-new_delay, 1);
        end
   end  
end 
absolute=abs(out);
maxi=max(absolute(:));
if maxi>1
    output=out/maxi;
else
    output=out;
end
end
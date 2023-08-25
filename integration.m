%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%@brief:Code for SEF function f(x)=<0,x>{exp(-t^2/(2*eta^2))}  
%       to generate a lookup table for some specfic applications.
% eta^2=0.1, severe nonlinearity
% eta^2=1.0, moderate nonlinearity
% eta^2=10,  soft nonlinearity
% eta^2=∞,   linear
%@author:Hong Yang @August 25, 2023        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;
step=0.0001;                  % sample step
sqeta=0.2;                    % square of non-linearity factor eta
limit=2.5;                    % integral limit

f = @(t) exp(-t.^2/(sqeta*2));% integrand definition

x = -limit:step:limit;        % discreted function arguments  
result=zeros(1,numel(x));     % integration result

for i=1:numel(x)
    result(i) =integral(f, 0, x(i),'AbsTol',1e-12);
end

plot(x,result)
saveBinary("./lookupTable_Sqeta_0_2.dat",result,"float32");
fprintf('Info:result %f\n', result);


%% function of saving matlab variable to binary file%%%%%%%%%%%%%%%%%%%%%%%
function saveBinary(filename, data, dtype)
%@brief  save variable to binary file
%@para   filename - path to save file
%@para   data     - matlab array
%@para   dtype    - data type to write
%@return None
fileID = fopen(filename, 'wb');
if fileID == -1
    error('Error:Cannot open file %s to write', filename);
end
count = fwrite(fileID, data, dtype);
fclose(fileID);

if count == numel(data)
    fprintf('Info:Data has been save to file %s in %s format\n', filename,dtype);
else
    fprintf('Error:Failed to save data to file %s\n', filename);
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
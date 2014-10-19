   %Clear Screen
clc;
%Clear Variables
clear all;
%Close figures
close all;
%Preallocate buffer
data_blink = zeros(1,256);
data_att = zeros(1,256);


%Comport Selection
portnum1 = 29;
%COM Port #
comPortName1 = sprintf('\\\\.\\COM%d', portnum1);
% Baud rate for use with TG_Connect() and TG_SetBaudrate().
TG_BAUD_115200 = 115200;
% Data format for use with TG_Connect() and TG_SetDataFormat().
TG_STREAM_PACKETS = 0;
% Data type that can be requested from TG_GetValue().
TG_DATA_BLINK_STRENGTH = 37;
TG_DATA_ATTENTION = 2;
%load thinkgear dll
loadlibrary('Thinkgear.dll');
%To display in Command Window
fprintf('Thinkgear.dll loaded\n');
%get dll version
dllVersion = calllib('Thinkgear', 'TG_GetDriverVersion');
%To display in command window
fprintf('ThinkGear DLL version: %d\n', dllVersion );
% Get a connection ID handle to ThinkGear
connectionId1 = calllib('Thinkgear', 'TG_GetNewConnectionId');
if ( connectionId1 < 0 )
sprintf( 'ERROR: TG_GetNewConnectionId() returned %d.\n', connectionId1 ) ;
end;
% Attempt to connect the connection ID handle to serial port "COM3"
errCode = calllib('Thinkgear', 'TG_Connect',connectionId1,comPortName1,TG_BAUD_115200,TG_STREAM_PACKETS );
if ( errCode < 0 )
sprintf( 'ERROR: TG_Connect() returned %d.\n', errCode ) ;
end
fprintf( 'Connected. Reading Packets...\n' );
if(calllib('Thinkgear','TG_EnableBlinkDetection',connectionId1,1)==0)
disp('blinkdetectenabled');
end
fprintf( 'Connected. Reading Packets...\n' );
i=0;
j=0;
%To display in Command Window

figure;

x=0;
cs=0;
ce=0;
cm=0;
c1=0;
c2=0;
opn=0;
bnn=0;
msx=0;
atn10=0;
asd=0;
atn1=0;
   
disp('Reading Brainwaves');
while i < 2048
if (calllib('Thinkgear','TG_ReadPackets',connectionId1,1) == 1) %if a packet was read...
if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_BLINK_STRENGTH) ~= 0)
j = j + 1;
i = i + 1;
x = x + 1;
%Read attention Valus from thinkgear packets
data_blink(j) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_BLINK_STRENGTH );
disp(data_blink(j));
dta = data_blink(j);
     c1=right1(dta,c1);
     
     c2=left1(data_blink(j),c2);
     
     opn=optin(data_blink(j),opn);
     
     cm=modee(dta,cm);
    cs=settt(dta,cs);
    bnn=bann(dta,bnn);
    asd=rota(dta,asd);
    
if (c1==3)
    fileID = fopen('vals.txt','w');

    fprintf(fileID,'%s','f');
    fclose(fileID);
end
if (c2==3)
    fileID = fopen('vals.txt','w');
fprintf(fileID,'%s','b');

fclose(fileID);
end
if (opn==3)
    fileID = fopen('vals.txt','w');
fprintf(fileID,'%s','r');
fclose(fileID);
end
if (cm==3)
    fileID = fopen('vals.txt','w');
fprintf(fileID,'%s','l');
fclose(fileID);
end
if (cs==3)
    
  fileID = fopen('vals.txt','w');  
    
fprintf(fileID,'%s','t');
 fclose(fileID);
 atn10=1;
end
if (bnn==3)
    fileID = fopen('vals.txt','w');

fprintf(fileID,'%s','g');
fclose(fileID);
end
if (asd==3)
    atn1=1;
end
if (x==3)
cs1=0;
cs2=0;
opn=0;
cm=0;
cs=0;
ce=0;
bnn=0;
asd=0;
x=0;
disp('New pattern');
end

if(atn10==1)
disp('Attention Values:');
s=0;
w=0;
pause(3);
while w < 10
if (calllib('Thinkgear','TG_ReadPackets',connectionId1,1) == 1) %if a packet was read...
if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_ATTENTION ) ~= 0)
s = s + 1;
w = w + 1;
%Read attention Valus from thinkgear packets
data_att(s) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_ATTENTION );
%To display in Command Window
disp(data_att(s));
if (data_att(s)> 50)
    fileID = fopen('vals.txt','w');

fprintf(fileID,'%s','u');
fclose(fileID);
end
if (data_att(s) < 51)
    fileID = fopen('vals.txt','w');

fprintf(fileID,'%s','d');
fclose(fileID);
end



end
end
end
atn10=0;
disp('New pattern');
end

if(atn1==1)
disp('Attention Values:');
s=0;
w=0;
pause(3);
while w < 20
if (calllib('Thinkgear','TG_ReadPackets',connectionId1,1) == 1) %if a packet was read...
if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_ATTENTION ) ~= 0)
s = s + 1;
w = w + 1;
%Read attention Valus from thinkgear packets
data_att(s) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_ATTENTION );
%To display in Command Window
disp(data_att(s));
if (data_att(s)> 50)
    fileID = fopen('vals.txt','w');

fprintf(fileID,'%s','x');
fclose(fileID);
end
if (data_att(s) < 51)
    fileID = fopen('vals.txt','w');

fprintf(fileID,'%s','y');
fclose(fileID);
end



end
end
end
atn1=0;
disp('New pattern');
end
%Plot Graph
end
end
end
%To display in Command Window
disp('Loop Completed')
 fclose(fileID);
   
%Release the comm port
calllib('Thinkgear', 'TG_FreeConnection', connectionId1 );

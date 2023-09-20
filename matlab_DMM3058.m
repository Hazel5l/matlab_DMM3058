% General example of an *IDN? query
% Make sure you have installed NI VISA 15.0 or newer with .NET support
% This example does not require MATLAB Instrument Control Toolbox
% It is based on using .NET assembly called Ivi.Visa
% that is istalled together with NI VISA
clear;
close all;
clc;
try
   assemblyCheck = NET.addAssembly('Ivi.Visa');
catch
   error('Error loading .NET assembly Ivi.Visa');
end
resourceString1 = 'TCPIP::192.168.2.101::INSTR'; % Standard LAN connection (also called VXI-11)
resourceString2 = 'TCPIP::192.168.2.101::hislip0'; % Hi-Speed LAN connection - see 1MA208
resourceString3 = 'GPIB::20::INSTR'; % GPIB Connection
resourceString4 = 'USB::0x0AAD::0x0119::022019943::INSTR'; % USB-TMC (Test and Measurement Class)
resourceString5 = 'USB0::0x1AB1::0x09C4::DM3R183401922::INSTR'; % USB-TMC (Test and Measurement Class)
% Opening VISA session to the instrument
scope = Ivi.Visa.GlobalResourceManager.Open(resourceString5);
scope.Clear()
scope.RawIO.Write(['*CLS']);
scope.RawIO.Write(['*RST']);
pause(5);
% LineFeed character at the end
scope.RawIO.Write(['*IDN?' char(10)]);
idnResponse = char(scope.RawIO.ReadString());
scope.RawIO.Write(['*TST?' char(10)]);
testres = char(scope.RawIO.ReadString());
if (testres==1)
   disp('DM3058 TEST Fail!');
else
   disp('DM3058 TEST OK!');
end   
scope.RawIO.Write(['SYSTem:VERSion?' char(10)]);
ver = char(scope.RawIO.ReadString());
disp('Ver:');disp(ver);
%disp(sprintf('Ver:%',ver));
scope.RawIO.Write(['FUNCtion:RESistance' char(10)]);
pause(5);
scope.RawIO.Write(['MEASure:RESistance?' char(10)]);
ohm = char(scope.RawIO.ReadString());
%msgbox(sprintf('Hello, I am\n%s', idnResponse));
disp(idnResponse);
%msgbox(sprintf('Resistor:%s', ohm));
disp(ohm);
rv=str2double(ohm);
thingSpeakWrite(1714105,rv,'WriteKey','R8CO58CEVYQA4F0N')
add1h=100.00+rv;
disp(add1h);


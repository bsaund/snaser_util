function [ T ] = config2T( configuration )
T = [cos(configuration(3)+pi/2),-sin(configuration(3)+pi/2),configuration(1);
         sin(configuration(3)+pi/2),cos(configuration(3)+pi/2),configuration(2);
         0,0,1];
end
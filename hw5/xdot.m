function [xdot] = xdot(t,x)

global A;
global B;
global F;

xdot = (A-B*F)*(x-[4;0]);
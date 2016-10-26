function [xdot] = xdot(t,x)

global A;
global B;
global K;

xdot = (A-B*K)*x;
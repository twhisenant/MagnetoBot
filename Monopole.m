function y = Monopole(b,xp)
%Assume the array varparm has been fixed by guess or calculation
%	x and y are toward magnetic north and east respectively
%	x' and y' are normal to strike and along strike.  Positive x' is on
%	          north side of dike. Positive y' varies from mag east to south
%	xp	= array of observation distances from arbitrary origin along
%	          principle profile (x' axis) toward north
%	fixparm = [be, incb, beta, comp]   
%	varparm = [x0, ksus, dip, dtop, dbot, bwid]
%	vr	= [DREF, KREF,1,  DREF, DREF, DREF]
%	be      = strength of earth's B field in nT
%	incb	= inclination of earth's B field in degrees
%	beta    = angle of negative y' axis relative to magnetic north (dec)
%	comp	= switch for Z vertical (comp=1) or total component (comp=0)
%	x0		= extrapolated surface location of south edge of dike along x'
%	ksus	= mks magnetic susceptibility of material
%	KREF	= Reference value for ksus to normalize it close to 1.0
%	dip		= dip of prism [ 0 => horizontal south, 90 => vertical]
%	dtop	= depth in meters to top of prism
%	dbot	= depth in meters to bottom of prism
%	bwid	= width in meters of prism
%	DREF	= Reference value for all distances
%   slope   = background magnetic gradient

% Deg to Rad conv if necessary
dr1		= pi/180;
dr      = 1;

% Input Fixed Parameters
B_e    = xp(length(xp) - 3);
INCLINATION = xp(length(xp) - 2);
    incb = INCLINATION*dr1;
STRIKE = xp(length(xp) - 1);
    beta = (360-(STRIKE))*dr1;
LENGTH = xp(length(xp));
    length1 = LENGTH;
 
comp	= 0;	        		%Use either total (0) or vertical (1) component of field {0,1}
dref	= 1;
kref    = 1;

x0		= b(1);
dtop	= b(2);
dbot    = b(2) + length1;
bwid    = b(3);
dip     = b(4);
ksus    = b(5);
offset  = b(6);
slope   = b(7);

% Redefine xp to exclude fixed values
 xp = xp(1:(length(xp)-4));

%.......CONVERT THE EXTERNAL DISTANCE ARRAY TO DIKE DISTANCE
tz	= tan(dip);
% if(dip==pi/2)
% 	tz=1e+16;
% end
con	= kref*ksus*(B_e+offset);			%kref is the reference value of mag suscept
% [m,n]	= size(xp);
% if(n > 1);     x = xp' - x0;
% elseif(n == 1);x = xp' - x0;
% else;          disp('Problem with position array xp - STOP');disp(n);
% keyboard;return;
% end

x = xp - x0;


r1	= sqrt(dtop^2 + x.^2);


    % Calc Field
    y = (con./(r1.^3)) .* (dtop * sin(incb)  - x.*cos(incb));

   % Add Background Parameters
   y = y + offset + B_e + slope.*xp;
   y = y';
   
   
end
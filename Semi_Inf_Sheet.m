function y = Semi_Inf_Sheet(b,xp)
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
%   B_e     = Earth's Magnetic Field

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
dbot    = b(2) + b(3);
length1 = dtop - dbot;
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
con	= -2*kref*ksus*length1*(B_e+offset);			%kref is the reference value of mag suscept
[m,n]	= size(xp);
if(n == 2);    x = xp(:,1)-x0;
elseif(n == 1);x = xp-x0;
elseif(m == 1);x = xp' - x0;
else;          disp('Problem with position array xp - STOP');disp(n);
keyboard;return;
end

% Radii to Anomaly
    r1	= sqrt(dtop^2 + (x+dtop*cot(dip)).^2);
    r2	= sqrt(dbot^2 + (x+dbot*cot(dip)).^2);

% TOTAL FIELD SIGNATURE OF FAULT
    si	= sin(dr*incb);
    ci	= cos(dr*incb);
    s2i	= sin(2*dr*incb);
    sd	= sin(dr*dip);
    cd	= cot(dr*dip);
    sb	= sin(dr*beta);

% Calculation from Telford 3.61b

   term1	= (1./(r1.^2)).*(dtop*s2i*sb - (x+dtop*cd).*(ci^2 * sb^2 - si^2));
   term2	= (1./(r2.^2)).*(dbot*s2i*sb - (x+dbot*cd).*(ci^2 * sb^2 - si^2));
   y		=  con*(term1 - term2);
   
   % Add Background Param
   y = y + offset + B_e + slope.*xp';
end

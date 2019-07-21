/*
    Wrap
    ---
    Wrap input to 'mod' value.
    It is also possible to apply a gain to the input.
*/

declare name 		"Wrap";
declare version 	"0.1";
declare author 		"Mario Buoninfante";
declare license 	"GPL v2.1";

import("stdfaust.lib");
import("instruments.lib");

g = hslider("gain",1,0,1000,0.0000001);
m = hslider("mod", 1,0,1000,0.0000001);

y(a,b,c) = fmod( ( a * b ), c );

process = y(_, g, int(m));

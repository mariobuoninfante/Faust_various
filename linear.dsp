declare name "linear";
declare author "Mario Buoninfante";
declare version "0.1";
declare license "GPL v2.1";

/*
    Generates a linear ramp that reaches 'target' in an amount of time equal to 'time'
    This scripts has been initially created as a module for a ChucK program (via Fauck - Faust integration in ChucK)
*/

import("stdfaust.lib");
target = hslider( "target", 0, 0, 100000000, 1 );
time   = hslider( "time", 0.001, 0, 50, 0.001 );        // max time 50 sec

line = ( _ <: ( _ <: raise ) + ( _ <: decay ) ) ~ _
  with {
  	raise(y) 		= ( delta_r >= 0 ) * ( ( y < target ) * ( y + rate_r ) + ( y >= target ) * target );	// when 'target delta' is 0 or positive, if less than 'target' increase, if equal or bigger than 'target' then 'target'
  	delta_r( r )	= ( ( target - r ) * ( target != target' ) + _ * ( target == target' ) ) ~ _;	// (target-value) when target changes
	rate_r( x )		= delta_r(x) / max( 1, time * ma.SR );

  	decay(y)		= ( delta_d < 0 ) * ( ( y > target ) * ( y + rate_d ) + ( y <= target ) * target );	// when 'target delta' is negative, if bigger than 'target' increase, if equal or smaller than 'target' then 'target'
  	delta_d( r )	= ( ( target - r ) * ( target != target' ) + _ * ( target == target' ) ) ~ _;	// (target-value) when target changes
	rate_d( x )		= delta_d(x) / max( 1, time * ma.SR );
};

process = line;

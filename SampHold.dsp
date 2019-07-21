/*
	SampHold - Sample and Hold
    ---
    Sample input 1 (left) when input 2 (right) decreases
*/

declare name        "SampHold";
declare author      "Mario Buoninfante";
declare version     "0.1";
declare license     "GPLv2.1";

import("stdfaust.lib");

main( sig, ctrl ) = ( ( dec( ctrl ) ) : fback )
  with
	{
  		dec(x) = ( x < x' );
  		fback( in ) = ( ( sig * in ) + ( _ * ( 1 - in ) ) ) ~ ( _ );
	};

process = (_,_):main:>_;

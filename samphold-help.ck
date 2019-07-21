/*
	SampHold - Sample and Hold Chugin
	---
	input 0 = signalt to sample
	input 1 = control signal - when this decreases 'input 0' gets sampled

	When faust2ck creates Chugins from Faust code, it seems like the number of input and output matches
	thus also if SampHold only has 1 output in Faust, here in ChucK has 2 outputs.
	It means in order to use it properly, .chan(0) should be used to connect SampHold to other UGens (see code below).
*/

SampHold samphold;
SinOsc osc => dac;
samphold.chan(0) => osc;
Noise sig => Gain offset => samphold.chan(0);
Phasor ctrl => samphold.chan(1);
Step step => offset;

200 => float noise_range;
250 => float lowest_freq;

step.next( lowest_freq + noise_range );
sig.gain( noise_range );
ctrl.freq(2);

while( true )
{
	500::ms => now;
}

### See the LICENSE file for details
### use v6.0;
use NativeCall;

unit module pagan;

### This is a quasi-static game object class which must be subclassed to be useful
### A healing potion is an example of this. You can pick it up so it has some
### action dependant game mechanics.
### See the Entity, MovingEntity and Sprite perl6 modules in this directory for
### more options.

class pagan::GameObject
{
	has $!x;
	has $!y;
	has $!w;
	has $!h;

	multi method update {
	}

}

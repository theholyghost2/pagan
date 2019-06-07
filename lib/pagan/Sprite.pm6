### See the LICENSE file for details
### use v6.0;
use NativeCall;
use GameObject;

unit module pagan;

### A Sprite instance just paints itself all the time, it can update itself
### but there is no action which can access it, it can only be destroyed
### e.g. by making a new room subclass

class pagan::Sprite is GameObject
{
	has $!x;
	has $!y;
	has $!w;
	has $!h;

	multi method paint {
	}

}

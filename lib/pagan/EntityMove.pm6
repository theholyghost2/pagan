### See the LICENSE file for details
### use v6.0;
use NativeCall;
use Entity;

unit module pagan;

### A MovingEntity is an Entity which moves from tome to time
### If it does not move it uses the Entity superclass to paint it
### If it moves it uses a left, right, up and down image library to paint it
### NOTE that you are free to subclass from this and paint where and when
### you want with the paint method

class pagan::EntityMove is Entity
{
	has $!direction;
	has $!moving;
	has $!dx; ### move x + dx
	has $!dy;

	has $!left-imagestatelib; ### ImageStateLibrary.pm6
	has $!right-imagestatelib;
	has $!up-imagestatelib;
	has $!down-stateimagelib;

	### For a Moving Entity
	multi method make-imagemovingstatelibraries($renderer) {

		self.make-default-imagestatelibrary($!left-imagestatelib);
		self.make-default-imagestatelibrary($!right-imagestatelib);
		self.make-default-imagestatelibrary($!up-imagestatelib);
		self.make-default-imagestatelibrary($!down-imagestatelib);

	}

	multi method update {
		
	}

	### This is EntityMove's paint method
	multi method draw-on($renderer) {

	}

}

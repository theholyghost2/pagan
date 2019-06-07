### See the LICENSE file for details
### use v6.0;

unit module pagan;

### a Room is the base class of the environment the player and non-player 
### characters move in.
### It can be subclassed for moving backgrounds, overlord view, isometric, 
### any 3rd person view and so on

class pagan::Room
{
	has $!bg_image is rw; ### an Image (handle) background, a reference

	has $!x is rw;
	has $!y is rw;
	has $!dx is rw; ### Room pixel update differential/distance
	has $!dy is rw;
	has $!width is rw;
	has $!height is rw;

	has $!Gfx is rw;

	submethod BUILD(:$x, :$y, :$w, :$h, :$dx, :$dy, :$Gfx, :$renderer) {
		
		$!x = $x;
		$!y = $y;

		$!dx = $dx;
		$!dy = $dy;

		$!width = $w;
		$!height = $h;

		$!Gfx = $Gfx;

		self.make-default-background-image(\$!bg_image, $renderer);

	}


	multi method levitate-entities {
		return \();
	}

	multi method levitate-entity-move {
		return \();
	}

	multi method levitate-game-objects {
		return \();
	}

	multi method levitate-sprites {
		return \();
	}

	multi method update {
		
	}

	method make-default-background-image($renderer) {
		my $imageh = $!bg_image;
		
		$imageh.load("./pics/" ~ "default-entity-image.bmp", $renderer);

	}


	multi method paint($x, $y, $imageh, $renderer) {

		my $imageh = $*($!bg_image);
		Gfx.paint($!x, $!y, $imageh, $renderer);

	}

}

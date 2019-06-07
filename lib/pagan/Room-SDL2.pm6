### See the LICENSE file for details
### use v6.0;
use Image;
use Room;
use Image-SDL2;
use Gfx-SDL2;

unit module pagan;

### a Room is the base class of the environment the player and non-player 
### characters move in.
### It can be subclassed for moving backgrounds, overlord view, isometric, 
### any 3rd person view and so on

class pagan::Room-SDL2 is Room
{

	submethod BUILD(:$x, :$y, :$w, :$h, :$dx, :$dy, :$renderer) {
		
		$!x = $x;
		$!y = $y;

		$!dx = $dx;
		$!dy = $dy;

		$!width = $w;
		$!height = $h;

		$!Gfx = Gfx-SDL2.new;

		self.make-default-background-image(\$!bg_image, $renderer);

	}

	method make-default-background-image($imageh, $renderer) {
		$*($imageh) = \Image-SDL2.new($!width, $!height).load("./pics/" ~ "default-bg-image.bmp", $renderer);

	}


	multi method paint($renderer) {

		my $imageh = $!bg_image;
		Gfx.paint($!x, $!y, $imageh, $renderer);

	}

}

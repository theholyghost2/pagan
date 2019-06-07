### See the LICENSE file for details
### use v6.0;

unit module pagan;
use Room-Cairo;

### a Room is the base class of the environment the player and non-player 
### characters move in.
### It can be subclassed for moving backgrounds, overlord view, isometric, 
### any 3rd person view and so on

class pagan::RoomPlains1 is Room-Cairo
{
	submethod BUILD(:$x, :$y, :$dx, :$dy, :$w, :$h, :$renderer) {
		
		$!x = $x;
		$!y = $y;

		$!dx = $dx;
		$!dy = $dy;

		$!width = $w;
		$!height = $h;

		self.make-background-image(\$!bg-image, $renderer);

	}

	multi method make-background-image($imageh, $renderer) {
		$*($imageh) = \Image.new($!width, $!height).load("./pics/" ~ "Room-Plains-1-bg.png", $renderer); ### FIXME add png file

	}

	multi method update {
		
	}

}

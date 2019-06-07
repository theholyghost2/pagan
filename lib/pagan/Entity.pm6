### See the LICENSE file for details
### use v6.0;
use NativeCall;
use EntityHandle;

unit module pagan;

### An Entity instance has a single ImageStateLibrary,
### There is a MovingEntity subclass which has 4 (up, down, left, right movement)
#
### It is different from a Game Object and a Sprite, see those modules for help
### with using them in a game
#
### Entity is a class which paints a default image, games should use a subclass
### of MovingEntity, Entity, GameObject and Sprite to be useful.

class pagan::Entity is EntityHandle
{

	has $!Gfx is rw;

	submethod BUILD(:$x, :$y, :$w, :$h, :$renderer, :$Gfx) {
		$!x = $x;
		$!y = $y;

		$!width = $w;
		$!height = $h;

		$!Gfx = $Gfx;

		self.make-imagestatelibrary($renderer); 
	}

	method make-default-imagestatelibrary($renderer) {
		my $imageh = Image.new($!width, $!height, $!Gfx);
		
		$imageh.load("./pics/" ~ "default-entity-image." ~ self.get-filename-suffix, $renderer);

		$!imagestatelib.addImage($imageh);
	}

	### For a Entity, a Sprite
	multi method make-imagestatelibrary($renderer) {

		self.make-default-imagestatelibrary($renderer);

	}

	### For a Moving Entity
	multi method make-imagemovingstatelibraries($renderer) {

		self.make-imagestatelibrary($renderer);

	}

	multi method update {
		
	}

	multi method paint($renderer) {

		my $imageh = $*($!imagestatelib.getImage());
		Gfx.paint($!x, $!y, $imageh, $renderer);

	}

}

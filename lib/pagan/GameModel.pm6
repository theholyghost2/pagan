### See the LICENSE file for details
### use v6.0;
use NativeCall;

unit module pagan;

### A GameModel is a type of game bootstrapped with several parameters by
### its subclasses

class pagan::GameModel
{
	has $.number is rw;
	has $.room is rw;

	has $.entities is rw;
	has $.entity-move is rw;
	has $.game-objects is rw;
	has $.sprites is rw;

	### Note that this is an abstract GameModel class		
	submethod BUILD(:$number = 0) {
		$!number = $number;

		###	$!room = Nil;
	
		if $!room {	
			### set list references
			$!entities = \$!room.levitate-entities;
			$!entity-move = \$!room.levitate-entity-move;
			$!game-objects = \$!room.levitate-game-objects;
			$!sprites = \$!room.levitate-sprites;
		}

		
	}

	multi method paint($renderer) {

	}

}

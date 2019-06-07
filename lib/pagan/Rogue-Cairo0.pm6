### See the LICENSE file for details
### use v6.0;
use NativeCall;
use GameModel;

use RoomPlains1;

unit module pagan;

class pagan::Rogue-Cairo0 is GameModel
{

	submethod BUILD(:$number = 0) {
		$!number = $number;

		### FIXME
		$!room = RoomPlains1.new(0,0,1,1,800,600); 

		### set list references
		$!entities = \$!room.levitate-entities;
		$!entity-move = \$!room.levitate-entity-move;
		$!game-objects = \$!room.levitate-game-objects;
		$!sprites = \$!room.levitate-sprites;

	}

	### This paints everything in a room even offscreen, which should not 
	### matter for drawing bmp image purposes	
	multi method paint($renderer) {

		$!room.paint($renderer);

		for $*($!entities) -> $e {
			$e.paint($renderer);
		}

		for $*($!entity-move) -> $e {
			$e.draw-on($renderer);
		}

		for $*($!game-objects) -> $e {
			$e.paint($renderer);
		}

		for $*($!sprites) -> $e {
			$e.paint($renderer);
		}

	}

	### This updates everything in a room even offscreen, which should not 
	### matter for most purposes. A sort algorithm can be used in a subclass.	
	multi method update {

		$!room.update;

		for $*($!entities) -> $e {
			$e.update;
		}

		for $*($!entity-move) -> $e {
			$e.update;
		}

		for $*($!game-objects) -> $e {
			$e.update;
		}

		for $*($!sprites) -> $e {
			$e.update;
		}

	}
}

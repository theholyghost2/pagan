### See the LICENSE file for details
### use v6.0;
use SDL2::Raw;

unit module pagan;

class pagan::Gfx-SDL2 is Gfx
{

	submethod BUILD() {
	
			
	
	}

	multi method get-filename-suffix {
		return "bmp"
	}


	### This paints everything in a graphics even offscreen
	multi method paint($x, $y, $imageh, $renderer) {

		$imageh.paint($x,$y, $renderer);	

	}

}

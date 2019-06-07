### See the LICENSE file for details
### use v6.0;
use Cairo;

unit module pagan;

class pagan::Gfx-Cairo is Gfx
{

	submethod BUILD() {
	
			
	
	}

	multi method get-filename-suffix {
		return "png"
	}

	### This paints everything in a graphics even offscreen
	multi method paint($x, $y, $imageh, $renderer) {

		$imageh.paint($x,$y,$renderer);		

	}

}

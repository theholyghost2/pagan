### See the LICENSE file for details
### use v6.0;

unit module pagan;

class pagan::Gfx
{

	submethod BUILD() {
	
			
	
	}

	multi method get-filename-suffix {
		return "png"
	}

	multi method load($filename, $renderer) {

	}

	### This paints everything in a graphics even offscreen
	multi method paint($x, $y, $imageh, $renderer = Nil) {


	}

}

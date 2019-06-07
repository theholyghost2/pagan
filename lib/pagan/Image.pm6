### See the LICENSE file for details
### use v6.0;
use NativeCall;
use SDL2::Raw
use ImageHandle;

unit module pagan;

### An Image handle class

class pagan::Image is ImageHandle
{
	### has $!image_data;
	has $.tile is rw; ### The SDL Image texture

	has $.width is rw;
	has $.height is rw;

	has $!Gfx is rw;

	submethod BUILD(:$width, :$height, :$Gfx, :$tile = Nil) {
		###my CArray[int32] $data .= new;
		### $!image_data = $data;

		$!width = $width;
		$!height = $height;

		$!Gfx = $Gfx;	

		$!tile = $tile;	
	}

	### $renderer is only needed for SDL2
	multi method load($filename, $renderer = Nil) {

		$!Gfx.load($filename, $renderer);

	}

	multi method paint($x, $y, $imageh, $renderer = Nil) {
	
		$!Gfx.paint($x, $y, $imageh, $renderer);

	}
}

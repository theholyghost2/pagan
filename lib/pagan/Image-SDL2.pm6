### See the LICENSE file for details
### use v6.0;
use NativeCall;
use SDL2::Raw

use ImageHandle;

unit module pagan;

### An Image handle class

class pagan::Image-SDL2 is ImageHandle
{
	has $!srcrect is rw;
	has $!destrect is rw;

	submethod BUILD(:$width, :$height, :$tile = Nil) {
		###my CArray[int32] $data .= new;
		### $!image_data = $data;

		$!width = $width;
		$!height = $height;

		###SDL_Rect 
		SDL_Rect $!srcrect .= new: x => 0, y => 0, w => $width, h => $height;
		### $!destrect .= new: x => $!x, y => $!y, w => $width, h => $height;
	
		$!tile = $tile;	
	}

	### This loads a texture from a filename into $.tile
	multi method load($filename, $renderer) {
		my $surface = SDL_LoadBMP($filename);
		$!tile = SDL_CreateTextureFromSurface($renderer, $surface);
	}

	multi method paint($x, $y, $renderer) {
	
		###SDL_Rect 
		SDL_Rect $!destrect .= new: x => $x, y => $y, w => $!width, h => $!height;
		### SDL_RenderCopy($renderer, $!tile, $src, SDL_Rect);
		SDL_RenderCopy($renderer, $!tile, $!srcrect, $!destrect);


	}
}

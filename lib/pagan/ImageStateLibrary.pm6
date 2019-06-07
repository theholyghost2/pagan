### See the LICENSE file for details
### use v6.0;

use NativeCall;
use SDL2::Raw;

use Image;

unit module pagan;

class pagan::StateImageLibrary
{
	has @!images; ### list of ImageHandles
	has $index;

	method addImage($image) { ### , $renderer) {
		###my $tile = SDL_CreateTexture($renderer, %PIXELFORMAT<RGBA8888>,
		###        TARGET, $image.width, $image.height);
		push(@!images, $image);
	}

	### This returns an Image (handle) reference
	### method getImage($entity) {
	method getImage {

		if ($index >= @!images.elems) {
			$index = 0;
		}
		my $imageh = @!images[$index];

		### update the image before rendering it to the screen
		### with $imageh.display($renderer)
		### FIXME data is the raw pixel data of the texture $.tile
		### SDL_UpdateTexture($imageh, 0, $image.tile.data,$imageh.width*$imageh.height);
		return \$imageh;			
	}

	### This returns an Image (handle) reference
	method getImageWithIndex($ind) {
		return \@!images[$ind];			
	}


}

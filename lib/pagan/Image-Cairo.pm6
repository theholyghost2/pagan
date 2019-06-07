### See the LICENSE file for details
### use v6.0;
use Cairo; 

use ImageHandle;

unit module pagan;

### An Image handle class

class pagan::Image-Cairo is ImageHandle
{

	has $!context is rw;

	submethod BUILD(:$width, :$height, :$tile = Nil) {
		$!width = $width;
		$!height = $height;

		$!tile = $tile;	
	}

	### This loads a texture from a filename into $.tile
	multi method load($filename, $renderer = Nil) {
		$!tile = Cairo::Image.create(Cairo::FORMAT_ARGB32, $!width, $!height) {
    			$!context = Cairo::Context.new($_) {
        			###.arc(128.0, 128.0, 76.8, 0, 2*pi);
        			.clip;
        			###.new_path; # path not consumed by .clip

        			my \image = Cairo::Image.open($filename);
        			my \w = image.width;
        			my \h = image.height;

        			###.scale(256.0/w, 256.0/h);

        			.set_source_surface(image, 0, 0);
				###.paint;

        			###image.destroy;
			}
		}
	}

	multi method paint($x, $y, $renderer = Nil) {
	
		$!context.set_source_surface($!context.image, $x, $y);

	}
}

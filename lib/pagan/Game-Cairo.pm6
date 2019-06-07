### See the LICENSE file for details
### use v6.0;

unit module pagan;
use nqp;
use NativeCall;
use Cairo;

### use Rogue-Cairo0;

class pagan::Game
{
	has $.gamemodel is rw;
	has $.screen-surface is rw;

	submethod BUILD(:$gamemodelnumber = 0) {
		my int ($w, $h) = 800, 600;

		my $!screen-surface = Cairo::Image.create(Cairo::FORMAT_ARGB32, $w, $h) {
    			my $context = Cairo::Context.new($_) {
        			###.arc(128.0, 128.0, 76.8, 0, 2*pi);
        			.clip;
        			###.new_path; # path not consumed by .clip

        			###my \image = Cairo::Image.open("examples/camelia.png" );
        			###my \w = image.width;
        			###my \h = image.height;

        			###.scale(256.0/w, 256.0/h);

        			###.set_source_surface(image, 0, 0);
        			.paint;

        			###image.destroy;
    			}
		}

		given $gamemodelnumber {
			when (* == 0) {
				###$!gamemodel = Rogue-Cairo0.new;
			}
		}

	}

	method render() {


		### the update is in the main-loop method of this file
		### $!gamemodel.paint($.screen-surface);	

	}

 	method main-loop() {

		### The rawinng code is in the render method
		### $!gamemodel.update;	
		self.render();

		return 0;
	}
}

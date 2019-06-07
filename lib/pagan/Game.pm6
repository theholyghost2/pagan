### See the LICENSE file for details
### use v6.0;

unit module pagan;
use nqp;
use NativeCall;
use SDL2::Raw;

use Rogue0;

class pagan::Game
{
	has $.gamemodel is rw;
	has $.renderer is rw;

	enum GAME_KEYS (
		K_UP => 82,
		K_DOWN => 81,
		K_LEFT => 80,
		K_RIGHT => 79,
		K_SPACE => 44,
	);


	submethod BUILD(:$gamemodelnumber = 0) {
		my int ($w, $h) = 800, 600;
		my SDL_Window $window;
		my SDL_Renderer $renderer;
		constant $sdl-lib = 'SDL2';



		SDL_Init(VIDEO);

		$window = SDL_CreateWindow(
		"Pagan Visions Roguelike - SDL 2",
		SDL_WINDOWPOS_CENTERED_MASK, SDL_WINDOWPOS_CENTERED_MASK,
		$w, $h,
		SHOWN
		);	

		$renderer = SDL_CreateRenderer( $window, -1, ACCELERATED );

		SDL_ClearError();

		my SDL_RendererInfo $renderer_info .= new;
		SDL_GetRendererInfo($renderer, $renderer_info);
		say $renderer_info;
		say %PIXELFORMAT.pairs.grep({ $_.value == any($renderer_info.texf1, $renderer_info.texf2, $renderer_info.texf3) });

		self.renderer = $renderer;

		given $gamemodelnumber {
			when (* == 0) {
				$!gamemodel = Rogue0.new;
			}
		}

	}

	method render() {

		SDL_SetRenderDrawColor(self.renderer, 0x0, 0x0, 0x0, 0xff);
		SDL_RenderClear(self.renderer);

		### the update is in the main-loop method of this file
		$!gamemodel.paint(self.renderer);	

		SDL_RenderPresent(self.renderer);
		SDL_RendererFlip;
	}

 	method main-loop() {
		my $event = SDL_Event.new;
		my %down_keys;

		while SDL_PollEvent($event) { ### SDL_WaitEvent 
			my $casted_event = SDL_CastEvent($event);

			given $casted_event {
				when (*.type == QUIT) {
					return -1; ###last;### mainloop;
			}

			when (*.type == KEYDOWN) {
				if GAME_KEYS(.scancode) -> $comm {
					%down_keys{$comm} = 1;
				}
				CATCH { say $_ }
			}
	
			when (*.type == KEYUP) {
				if GAME_KEYS(.scancode) -> $comm {
					%down_keys{$comm} = 0;
				} 
				CATCH { say $_ }
			}
		}

		### The rawinng code is in the render method
		$!gamemodel.update;	
		self.render();

		}
	return 0;
	}
}

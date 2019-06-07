### See the LICENSE file for details
### use v6.0;

unit module pagan;
use nqp;
use NativeCall;
use SDL2::Raw;

class pagan::Game
{
	my $.renderer;

	method BUILD() {
		my int ($w, $h) = 800, 600;
		my SDL_Window $window;
		my SDL_Renderer $renderer;
		constant $sdl-lib = 'SDL2';


enum GAME_KEYS (
	K_UP => 82,
	K_DOWN => 81,
	K_LEFT => 80,
	K_RIGHT => 79,
	K_SPACE => 44,
);


		SDL_Init(VIDEO);

		$window = SDL_CreateWindow(
		"Pagan Visions - SDL 2",
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

		my CArray[int32] $data .= new;
		my int $numpoints;

		self.renderer = $renderer;


	}

	method render() {

		###SDL_UpdateTexture($tile, 0, $data, 320*32);

		SDL_SetRenderDrawColor(self.renderer, 0x0, 0x0, 0x0, 0xff);
		SDL_RenderClear(self.renderer);
		SDL_SetRenderDrawColor(self.renderer, 0xff, 0xff, 0xff, 0x7f);
#	self.renderer.fill-rect(
#    SDL_Rect.new(
#      2 * min(now * 300 % 800, -now * 300 % 800),
#      2 * min(now * 470 % 600, -now * 470 % 600),
#    sin(3 * now) * 50 + 80, cos(4 * now) * 50 + 60));


my $rect = SDL_Rect.new(
      2 * min(now * 300 % 800, -now * 300 % 800),
      2 * min(now * 470 % 600, -now * 470 % 600),
    sin(3 * now) * 50 + 80, cos(4 * now) * 50 + 60);

###SDL_RenderFillRect(self.renderer,  $rect);

		###my $texture = IMG_LoadTexture(self.renderer, "./pics/test.bmp");

		###my $surface = SDL_LoadBMP("./pics/test.bmp");
		###my $surface = IMG_Load("./pics/test.bmp");
		###my $surface = SDL_LoadBMP_RW(SDL_RWFromFile("./pics/test.bmp"i, "rb"), 1);
		###my $texture = SDL_CreateTextureFromSurface(self.renderer, $surface);

SDL_RenderCopy(self.renderer,
                   $texture,
			$rect, $rect);

		SDL_RenderPresent(self.renderer);
		SDL_RendererFlip;
	}

 	method mainloop() {
		my $event = SDL_Event.new;
		my %down_keys;

		while SDL_PollEvent($event) {
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

	###update();
	###draw();
		self.render();

		}
	return 0;
	}
}

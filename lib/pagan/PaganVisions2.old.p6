### See the LICENSE file for details

use NativeCall;
use SDL2::Raw;
use nqp;
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

my %down_keys;

SDL_Init(VIDEO);

$window = SDL_CreateWindow(
"Pagan Visions - SDL 2.x",
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

my @entities; ## a list of Entity.pm6
my @moving_entities;

sub update () {
	for @entities -> $e {
		$e.update();
	}

	for @moving_entities -> $e {
		$e.update();
	}
}

sub draw () {
	for @entities -> $e {
		$e.draw($renderer);
	}

	for @moving_entities -> $e {
		$e.draw($renderer);
	}
}

sub render {

	### SDL_UpdateTexture($tile, 0, $data, 320*32);

	SDL_SetRenderDrawColor($renderer, 0x0, 0x0, 0x0, 0xff);
	SDL_RenderClear($renderer);
	SDL_SetRenderDrawColor($renderer, 0xff, 0xff, 0xff, 0x7f);
	SDL_RenderPresent($renderer);

	### SDL_RendererFlip;
}

my @times;
my $event = SDL_Event.new;
my num $df = 0.0001e0;

main: loop {
	my $start = nqp::time_n();


	while SDL_PollEvent($event) {
	my $casted_event = SDL_CastEvent($event);

	given $casted_event {
		when *.type == QUIT {
			last main;
		}

		when *.type == KEYDOWN {
			if GAME_KEYS(.scancode) -> $comm {
				%down_keys{$comm} = 1;
			}
			CATCH { say $_ }
		}

		when *.type == KEYUP {
			if GAME_KEYS(.scancode) -> $comm {
				%down_keys{$comm} = 0;
			} 
			CATCH { say $_ }
		}
	}

	update();
	draw();
}

render();


@times.push: nqp::time_n() - $start;
$df = nqp::time_n() - $start;
}
@times .= sort;
my @timings = (@times[* div 50], @times[* div 4], @times[* div 2], @times[* * 3 div 4], @times[* - * div 100]);
say "frames per second:";
say (1 X/ @timings).fmt("%3.4f");
say "timings:";
say ( @timings).fmt("%3.4f");
say "";
'raw_timings.txt'.IO.spurt((1 X/ @times).join("\n"));

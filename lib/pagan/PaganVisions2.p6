### See the LICENSE file for details
use nqp;
use NativeCall;
use SDL2::Raw;
use Game;

my $game = pagan::Game.new;

my $start = nqp::time_n();
my num $df = 0.0001e0;
my @times;
main: loop {
my $r = $game.main-loop();
if ($r == -1) { exit };
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


#include <stdio.h> 
#include <unistd.h>
#include <allegro.h> 
#include "f.h"

double alfa = 3.14/4, K = 0.5, v0 = 15.0d, g = 10.0d, time_step = 0.002; 

int main()
{
	printf("podaj v0 : ");
	scanf("%lf", &v0);
	
	printf("podaj kąt (deg) : ");
	scanf("%lf", &alfa);
	
	printf("podaj K : ");
	scanf("%lf", &K);
	allegro_init(); 
	set_color_depth(24);
	set_gfx_mode(GFX_AUTODETECT_WINDOWED, 1920, 1080, 0, 0);
	
	BITMAP *output = create_bitmap_ex(8, 1920, 1080);
	
	if(!output)
	{
		set_gfx_mode(GFX_TEXT, 0, 0, 0, 0);
		allegro_message("bitmap error");
		allegro_exit();
		return 1; 
	}
	
	clear_to_color (output, makecol(0, 0, 0)) ; 
	printf("%f\n", quadratic_drag(output -> line, v0, alfa*0.017, K, g, time_step));
	blit(output, screen, 0, 0, 0, 0, output -> w, output -> h);
	sleep(3);
	destroy_bitmap(output);
	return 0; 
}

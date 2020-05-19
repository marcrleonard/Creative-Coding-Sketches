from p5 import *

window_w = 1500
window_h = 1000
center_x = window_w/2
center_y = window_h/2


def delta_coords(degrees, distance):
	angle_radians = degrees * math.pi / 180
	x = math.cos(angle_radians) * distance
	y = math.sin(angle_radians) * distance
	return x, y

def setup():
	size(window_w, window_h)
	background(255)


def draw():
	background(255)
	for n in range(1):
		start_angle = 0
		end_angle = 500
		start_radius = 350

		curr_raidus = start_radius

		no_fill()
		begin_shape()
		for d in range(start_angle, end_angle):

			final_distance = curr_raidus
			d_x, d_y = delta_coords(d, final_distance)

			x = center_x + d_x
			y = center_y + d_y

			vertex(x, y)

			curr_raidus += .02

		end_shape()

	no_loop()

run()



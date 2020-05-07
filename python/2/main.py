# import p5 as p
from p5 import *
import math
import random
random.seed(100)
import copy
import time

a3_ratio = (1.0,1.468)

#1920/1080
window_w = 1200
window_h = 800
center_x = window_w/2
center_y = window_h/2
rad_inc = .07
seed_num = 60
loops = 100
# 38, 44, 52, 60
##################

#3840/2180
# window_h = 2160
# window_w = window_h*a3_ratio[1]
# center_x = window_w/2
# center_y = window_h/2
# rad_inc = .075
# seed_num = 60
# 38, 44, 52, 60
##################


# each arc segment has end distance, start angle, end angle

'''
Create a spiral 'wreath' ... and eventual the ends of the 'tentacals' do something...
 - maybe they all sway out to one side 
 - maybe they are branch out and then do theur own iterative things/


'''

def delta_coords(degrees, distance):
	angle_radians = degrees * math.pi / 180
	x = math.cos(angle_radians) * distance
	y = math.sin(angle_radians) * distance
	return x, y

class MVector:
	def __init__(self,x,y, d):
		self.x = x
		self.y = y
		self.degrees = d
		self.distance = 500

	def next_coords(self):

		d_x,d_y = delta_coords(self.degrees, self.distance)
		x = d_x+self.x
		y = d_y+self.y

		return x, y


def degrees_to_radians(d):
	return d * math.pi / 180



def setup():
	size(window_w, window_h)
	background(255)





end_vectors = []

def draw():


	#### SINGLE ONE
	noise_seed(seed_num)
	background(255)
	no_fill()
	ellipse_mode('RADIUS')
	stroke_weight(1.2)



	revs = 27

	for r in range(revs):

		n_off = 10
		radius = random.randint(200,290)
		noise_amplitude = random.randint(15, 29)
		r_f = random.random()
		n_speed = remap(r_f, (0,1), (.010, .18))

		start_angle = random.randint(0, 360)

		spiral_size = random.randint(360,450)

		end_angle = start_angle+spiral_size

		d_x, d_y = delta_coords(start_angle, radius)
		s_x = center_x + d_x
		s_y = center_y + d_y

		for d in range(start_angle+1, end_angle):

			_noiseness = noise(0, n_off)

			noiseness = remap(_noiseness,  (0,1), (-noise_amplitude, noise_amplitude))

			noise_dist = radius+noiseness
			d_x, d_y = delta_coords(d, noise_dist)

			e_x = center_x+d_x
			e_y = center_y+d_y
			line((s_x, s_y), (e_x,e_y))

			s_x=e_x
			s_y=e_y

			n_off+=n_speed

			radius +=.001

		v = MVector(s_x, s_y, end_angle+90)
		end_vectors.append(v)

	#draw end vectors
	for v in end_vectors:
		n_x, n_y = v.next_coords()
		line((v.x, v.y), (n_x, n_y))


	# # circle((center_x, center_y), 50)
	# every_degrees = 60
	# for degrees in range(0, 359, every_degrees):
	#
	# 	starting_arc = Arc(degrees, 75, end_degrees=degrees+1000)
	# 	x, y, mydegrees, dist = starting_arc.make()
	#
	#
	#
	# 	v = MVector(x, y, mydegrees, dist)
	# 	return_vectors.append(v)
	#
	#
	#
	# no_loop()
	# # save(f'output_{seed_num}_.png')
	# # exit(1)
	#
	# #####



run()
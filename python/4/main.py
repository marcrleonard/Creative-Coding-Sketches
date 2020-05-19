# import p5 as p
from p5 import *
import math
import random
random.seed(100)
import copy
import time
from MyCollection import *

from tkinter import Tk, mainloop, Scale, HORIZONTAL

a3_ratio = (1.0,1.468)

#1920/1080
window_w = 1500
window_h = 1000
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

class TypeBase:
	def __init__(self):
		pass
	def draw(self):
		raise Exception('Should be implemented by derived class')


class Mothers(TypeBase):
	def __init__(self, start_angle, end_angle, additional_radius=0):
		self.start_angle = start_angle
		# end_angle = self.start_angle +409
		self.end_angle = end_angle
		self.start_radius = random.randint(330,390) + additional_radius
		self.end_radius = self.start_radius

	def draw(self):

		n_off = 30


		noise_amplitude = 100

		n_speed = .009

		curr_raidus = self.start_radius

		last_x = None
		last_y = None

		no_fill()
		begin_shape()
		for d in range(self.start_angle, self.end_angle):
			_noiseness = noise(0, n_off)
			noiseness = remap(_noiseness, (0, 1), (-noise_amplitude, noise_amplitude))
			# noiseness = 0

			final_distance = curr_raidus+noiseness
			d_x, d_y = delta_coords(d, final_distance)

			x = center_x + d_x
			y = center_y + d_y

			last_x = x
			last_y = y

			vertex(x, y)

			n_off += n_speed

			curr_raidus += .02

		# end_shape()
		#
		# begin_shape()

		for p in range(30):
			_noiseness = noise(0, n_off)
			noiseness = remap(_noiseness, (0, 1), (-noise_amplitude, noise_amplitude))

			noiseness = 0
			final_distance = curr_raidus + noiseness
			d_x, d_y = delta_coords(self.end_angle+90, final_distance)


			x = last_x + d_x
			y = last_y + d_y

			vertex(x, y)

			n_off += n_speed

		end_shape()

class MVector:
	def __init__(self,x,y, d, noise_speed=None):
		self.x = x
		self.y = y
		self.degrees = d
		self.distance = 500
		self.noise_speed = noise_speed

	def next_coords(self, dist):

		d_x,d_y = delta_coords(self.degrees, dist)
		x = d_x+self.x
		y = d_y+self.y

		return x, y

	def draw_line(self):
		n_off=10
		for l in range(self.distance):

			_noiseness = noise(0, n_off)
			noise_amplitude = 30
			noiseness = remap(_noiseness,  (0,1), (-noise_amplitude, noise_amplitude))

			n_x, n_y = self.next_coords(l)

			n_x = n_x+noiseness

			line((self.x, self.y),(n_x, n_y))
			self.x = n_x
			self.y = n_y

			n_off+=self.noise_speed





def setup():
	size(window_w, window_h)
	background(255)



end_vectors = []



def draw():
	seed = 100


	#### SINGLE ONE
	noise_seed(seed)
	background(255)
	# ellipse_mode('RADIUS')
	stroke_weight(1.2)

	for n in range(1):
		s_a = random.randint(0,360)
		_e_a = random.randint(360, 540)
		e_a = get_end_angle_in_bounds(_e_a, low_bounds=25, high_bounds=80) + 270

		m = Mothers(s_a, e_a)
		m.draw()
	# 	end_vectors.append(ev)
	#
	# for v in end_vectors:
	#
	# 	last_degrees = v.degrees
	# 	distance = 400
	#
	# 	d_x, d_y = delta_coords(last_degrees+90, distance)
	#
	# 	e_x = v.x+d_x
	# 	e_y = v.y+d_y
	#
	# 	line((v.x, v.y),(e_x, e_y) )

	svg_name = f'output_{seed}.svg'
	# save_svg(svg_name, window_w, window_h)
	# clean_svg(svg_name)
	# save(f'output_{seed}_.png')


	no_loop()
	# exit(1)






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



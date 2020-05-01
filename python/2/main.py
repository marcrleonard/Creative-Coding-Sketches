# import p5 as p
from p5 import *
import math
import random
random.seed(100)
import copy
import time

a3_ratio = (1.0,1.468)

#1920/1080
window_h = 1080
window_w = 1080
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



class ArcSegment(object):
	def __init__(self):
		self.start_degrees=None
		self.end_degrees = None
		self.start_radius = None
		self.rad_inc = rad_inc
		# self.end_radius = None

	@property
	def end_radius(self):

		angle_delta = self.end_degrees - self.start_degrees
		inc_change = angle_delta*self.rad_inc

		final_inc = inc_change+self.start_radius

		return final_inc

	def make(self):
		pass

	def delta_coords(self, degrees, distance):
		angle_radians = degrees * math.pi / 180
		x = math.cos(angle_radians) * distance
		y = math.sin(angle_radians) * distance
		return x, y

# def convert_range(in_range:tuple, out_range:tuple, num_to_convert):
# 	in_low = in_range[0]
# 	in_high = in_range[1]
#
# 	out_low = out_range[0]
# 	out_high = out_range[1]
#
# 	p = num_to_convert/in_high
#
# 	amt = p*(out_high-out_low)
#
# 	final = amt+num_to_convert


class Arc(ArcSegment):
	def __init__(self, start_degrees, start_radius, end_degrees=None):
		super(Arc, self).__init__()

		self.start_degrees = start_degrees

		if end_degrees == None:
			end_degrees = random.randint(start_degrees + 20, start_degrees + 100)

		self.end_degrees = end_degrees

		self.start_radius = start_radius

	def make(self):

		d_x, d_y = self.delta_coords(self.start_degrees, self.start_radius)

		s_x = float(center_x) + d_x
		s_y = float(center_y) + d_y

		angle_distance=1

		rad_inc = self.rad_inc

		curr_radius = self.start_radius
		for curr_degrees in range(self.start_degrees+1, self.end_degrees, angle_distance):


			d_x, d_y = self.delta_coords(curr_degrees, curr_radius)

			ease_in = self.start_degrees + 400.0

			if curr_degrees > ease_in:

				weight_derive = curr_degrees / ease_in
				dd = weight_derive * curr_radius

				# print(weight_derive)
				d_x, d_y = self.delta_coords(curr_degrees, dd)


				if curr_degrees > self.start_degrees + 800:



					# use the last vector. dont create a new curve

					e_x = d_x + center_x
					e_y = d_y + center_y

					myradians = math.atan2(e_y - s_y, e_x - s_y)
					mydegrees = math.degrees(myradians)

					dist = math.sqrt((e_x - s_x) ** 2 + (e_y - s_y) ** 2)

					return s_x, s_y, mydegrees, dist



			e_x = d_x + center_x
			e_y = d_y + center_y

			line((s_x, s_y), (e_x, e_y))

			s_x = e_x
			s_y = e_y

			curr_radius += rad_inc


class MVector:
	def __init__(self,x,y, d, speed):
		self.x = x
		self.y = y
		self.degrees = d
		self._speed = speed
		self.speed = self._speed * 20

	def next_coords(self):
		angle_radians = self.degrees * math.pi / 180
		d_x = math.cos(angle_radians) * self.speed
		d_y = math.sin(angle_radians) * self.speed

		x = d_x+self.x
		y = d_y+self.y

		return x, y

def degrees_to_radians(d):
	return d * math.pi / 180



def setup():
	size(window_w, window_h)
	background(255)



def delta_coords(degrees, distance):
	angle_radians = degrees * math.pi / 180
	x = math.cos(angle_radians) * distance
	y = math.sin(angle_radians) * distance
	return x, y


def draw():


	#### SINGLE ONE
	noise_seed(seed_num)
	background(255)
	no_fill()
	ellipse_mode('RADIUS')
	stroke_weight(1.2)


	return_vectors=[]

	s_a = 0
	e_a = 180
	a_r=40

	arc((center_x, center_y), a_r, a_r, degrees_to_radians(s_a), degrees_to_radians(e_a))

	save(f'output_aa_.png')

	l_r = 40
	d_x, d_y = delta_coords(0, l_r)
	s_x = float(center_x) + d_x
	s_y = float(center_y) + d_y

	for x in range(s_a+1, e_a, 1):

		d_x, d_y = delta_coords(x, l_r)

		e_x = d_x + center_x
		e_y = d_y + center_y

		line((s_x, s_y), (e_x, e_y))

		s_x = e_x
		s_y = e_y

	save(f'output_ll_.png')
	# print(curr_radius)


	# save(f'output_{seed_num}_{l}_.png')

	# circle((center_x, center_y), 50)
	# every_degrees = 60
	# for degrees in range(0, 359, every_degrees):
	#
	# 	starting_arc = Arc(degrees, 75, end_degrees=degrees+1000)
	# 	x, y, mydegrees, dist = starting_arc.make()
	#
	# 	v = MVector(x, y, mydegrees, dist)
	# 	return_vectors.append(v)
	#
	# for v in return_vectors:
	# 	n_x, n_y = v.next_coords()
	# 	line((v.x, v.y), (n_x, n_y))



	no_loop()
	# save(f'output_{seed_num}_.png')
	# exit(1)

	#####



run()
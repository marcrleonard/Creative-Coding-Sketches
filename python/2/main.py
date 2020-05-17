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


class Lovers(TypeBase):
	def __init__(self, start_angle, end_angle, additional_radius=0):
		self.start_angle = start_angle
		self.end_angle = end_angle
		self.start_radius = random.randint(270,290) + additional_radius
		self.end_radius = self.start_radius

	def draw(self):

		n_off = 10

		noise_amplitude = 30

		# r_f = random.random()
		# n_speed = remap(r_f, (0, 1), (.010, .18))

		n_speed = .039

		opposite = []

		curr_raidus = self.start_radius

		no_fill()
		begin_shape()
		for d in range(self.start_angle, self.end_angle):
			_noiseness = noise(0, n_off)
			noiseness = remap(_noiseness, (0, 1), (-noise_amplitude, noise_amplitude))

			wave_radius = 10
			wave_distance = 12
			angle_radians = d*wave_distance * math.pi / 180
			wave_offset = math.cos(angle_radians) * wave_radius

			final_distance = curr_raidus+wave_offset+noiseness
			final_distance_inverse = curr_raidus-wave_offset-noiseness
			d_x, d_y = delta_coords(d, final_distance)

			x = center_x + d_x
			y = center_y + d_y

			vertex(x, y)

			d_x, d_y = delta_coords(d, final_distance_inverse)
			x = center_x + d_x
			y = center_y + d_y
			opposite.append((x,y))

			n_off += n_speed

			curr_raidus += .23

		end_shape()

		# this will not use a certain part of the 'begining' of the curves

		start = len(opposite) - int(.91*len(opposite))
		opposite = opposite[start:]

		begin_shape()
		for p in opposite:
			x = p[0]
			y=p[1]
			vertex(x,y)
		end_shape()



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

		no_fill()
		begin_shape()
		for d in range(self.start_angle, self.end_angle):
			_noiseness = noise(0, n_off)
			noiseness = remap(_noiseness, (0, 1), (-noise_amplitude, noise_amplitude))

			final_distance = curr_raidus+noiseness
			d_x, d_y = delta_coords(d, final_distance)

			x = center_x + d_x
			y = center_y + d_y

			vertex(x, y)


			n_off += n_speed

			curr_raidus += .01

		end_shape()


class Growers(TypeBase):
	def __init__(self, start_angle, end_angle, additional_radius=0):
		self.start_angle = start_angle

		if 300 > self.start_angle - end_angle:
			end_angle = self.start_angle+300

		self.end_angle = end_angle
		self.start_radius = random.randint(150,210) + additional_radius
		self.end_radius = self.start_radius

	def draw(self):

		n_off = 40
		noise_amplitude = 40

		n_speed = .1

		curr_raidus = self.start_radius

		no_fill()
		begin_shape()
		for d in range(self.start_angle, self.end_angle):
			_total = self.end_angle - self.start_angle
			_cur = d - self.start_angle

			noise_usage = 1.0
			thresh = .75*_total
			if _cur > thresh:
				p = (_cur - thresh)/(_total - thresh)
				noise_usage = 1.0-p

			_noiseness = noise(0, n_off)
			noiseness = remap(_noiseness, (0, 1), (-noise_amplitude, noise_amplitude))

			noiseness = noiseness  * noise_usage

			final_distance = curr_raidus+noiseness
			d_x, d_y = delta_coords(d, final_distance)

			x = center_x + d_x
			y = center_y + d_y

			# curve_vertex(x,y)
			vertex(x, y)


			n_off += n_speed

			curr_raidus += .4

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




# class Tweaks:
# 	def __init__(self):
# 		pass
#
# 	def run(self):
# 		self.master = Tk()
# 		w = Scale(self.master, from_=0, to=200, orient=HORIZONTAL)
# 		w.pack()
# 		mainloop()
#
# import threading
#
# tt = Tweaks()
# t = threading.Thread(target=tt.run)
# t.start()
#
def setup():
	size(window_w, window_h)
	background(255)



end_vectors = []



def draw():

	faves = [6, 11, 13, 29, 60, 62, 76, 85, 88, 92, 120, 133, 159, 165, 192]
	faves = [6]
	# faves = [n for n in range(120, 200, 1)]

	for seed in faves:

		#### SINGLE ONE
		noise_seed(seed)
		background(255)
		# ellipse_mode('RADIUS')
		stroke_weight(1.2)

		object_types = [
			# class, loops, expand-ness
			(Mothers, 3, 15),
			(Lovers, 2, 6),
			(Growers, 1, 0),
		]

		for class_type, revs, rad_expand in object_types:

			for l in range(1, revs+1):

				# print(class_type)

				start_angle = random.randint(0,360)

				end_angle = random.randint(180, 360) + start_angle
				# end_angle_low = start_angle+300
				# end_angle_high = start_angle + 320
				# end_angle_pre = random.randint(end_angle_low,end_angle_high)
				# end_angle = get_end_angle_in_bounds(end_angle_pre)
				d = l*rad_expand

				m = class_type(start_angle, end_angle, d)
				m.draw()

		svg_name = f'output_{seed}.svg'
		save_svg(svg_name, window_w, window_h)
		clean_svg(svg_name)
		save(f'output_{seed}_.png')


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



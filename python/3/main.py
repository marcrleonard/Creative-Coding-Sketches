# import p5 as p
from p5 import *
import math
import random

random.seed(100)
import copy
import time

a3_ratio = (1.0, 1.468)

# 1920/1080
window_h = 1080
window_w = 1080
center_x = window_w / 2
center_y = window_h / 2
rad_inc = .07
seed_num = 60
loops = 100


# 38, 44, 52, 60
##################

# 3840/2180
# window_h = 2160
# window_w = window_h*a3_ratio[1]
# center_x = window_w/2
# center_y = window_h/2
# rad_inc = .075
# seed_num = 60
# 38, 44, 52, 60
##################


# each arc segment has end distance, start angle, end angle


class MVector:
	def __init__(self, x, y, d, speed):
		self.x = x
		self.y = y
		self.degrees = d
		self._speed = speed
		self.speed = self._speed * 20

	def next_coords(self):
		angle_radians = self.degrees * math.pi / 180
		d_x = math.cos(angle_radians) * self.speed
		d_y = math.sin(angle_radians) * self.speed

		x = d_x + self.x
		y = d_y + self.y

		return x, y


def degrees_to_radians(d):
	return d * math.pi / 180


def delta_coords(degrees, distance):
	angle_radians = degrees * math.pi / 180
	x = math.cos(angle_radians) * distance
	y = math.sin(angle_radians) * distance
	return x, y


height = 700
width = 1200

lowest_y = height
yoff = 10
resolution = 150
noise_inc = .007
points = []
amplitude = 700

class Point:
	def __init__(self,x,y):
		self.x = x
		self.y = y


for n in range(resolution):
	y = noise(0, yoff) * amplitude
	x = width / resolution * n
	points.append((x,y))

	yoff += noise_inc



def setup():
	noise_seed(5)
	background(55)
	size(width, height)


def draw():

	no_fill()


	s_x, s_y = points.pop(0)

	for e_x,e_y in points:
		line((s_x, s_y), (e_x, e_y))
		s_x = e_x
		s_y = e_y


	no_loop()

	# save(f'output_{seed_num}_.png')
	# exit(1)


run()
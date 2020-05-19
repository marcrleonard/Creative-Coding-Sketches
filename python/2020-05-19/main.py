from MyCollection import *
import math
import random
random.seed(100)
import copy

a3_ratio = (1.0,1.468)

#1920/1080
window_h = 1080
window_w = window_h*a3_ratio[1]
center_x = window_w/2
center_y = window_h/2
rad_inc = .075
seed_num = 60
loops = 100

##################
# 38, 44, 52, 60 #
##################

#3840/2180
window_h = 2160
window_w = window_h*a3_ratio[1]
center_x = window_w/2
center_y = window_h/2



def setup():
	size(window_w	, window_h)





def draw():

	background(255)
	ellipse_mode('RADIUS')
	noise_seed(seed_num)
	stroke_weight(1.2)




	# save_svg('/Users/marcleonard/Desktop/test.svg', window_w, window_h)
	# save(f'/Users/marcleonard/Desktop//output_{seed_num}_.png')
	# exit(1)
	no_loop()

	#####



run()
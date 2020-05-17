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
seed_num = 60
loops = 100

##################
# 38, 44, 52, 60 #
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


	def make(self):
		pass

	def delta_coords(self, degrees, distance):
		angle_radians = degrees * math.pi / 180
		x = math.cos(angle_radians) * distance
		y = math.sin(angle_radians) * distance
		return x, y

class Mothers(ArcSegment):
	def __init__(self, start_degrees, start_radius, end_degrees=None):
		self.start_degrees = start_degrees
		self.end_degrees = end_degrees
		self.start_radius = start_radius
		self.end_radius = self.start_radius

	def draw(self):

		n_off = 30
		
		noise_amplitude = 100

		n_speed = .009

		no_fill()
		begin_shape()
		for d in range(self.start_degrees, self.end_degrees):
			_noiseness = noise(0, n_off)
			noiseness = remap(_noiseness, (0, 1), (-noise_amplitude, noise_amplitude))

			final_distance = self.start_radius+noiseness
			d_x, d_y = delta_coords(d, final_distance)

			x = center_x + d_x
			y = center_y + d_y

			vertex(x, y)


			n_off += n_speed

		end_shape()


class ZigZag(ArcSegment):
	def __init__(self, start_degrees, start_radius, end_degrees=None):
		super(ZigZag, self).__init__()

		self.start_degrees = start_degrees
		self.end_degrees = random.randint(self.start_degrees + 20, self.start_degrees+80)

		# self.rad_inc = .2
		self.start_radius = start_radius


	def make(self):

		zz_width = 3
		zz_height = 5

		d_x, d_y = self.delta_coords(self.start_degrees, self.start_radius+zz_height)
		s_x = float(center_x) + d_x
		s_y = float(center_y) + d_y

		z_in=False

		no_fill()
		begin_shape('LINES')

		for x in range(self.start_degrees+zz_width, self.end_degrees, zz_width):
			distance = self.start_radius


			if not z_in:
				distance = distance - zz_height
				z_in = True
			else:
				distance = distance + zz_height
				z_in = False

			d_x, d_y = self.delta_coords(x, distance)

			e_x = d_x + center_x
			e_y = d_y + center_y


			vertex(s_x, s_y)
			vertex(e_x, e_y)

			# line((s_x, s_y), (e_x, e_y))

			s_x = e_x
			s_y = e_y

		# pass
		end_shape()

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

		curr_radius = self.start_radius


		no_fill()
		# arc((center_x, center_y), curr_radius+1, self.start_radius+1, degrees_to_radians(self.start_degrees), degrees_to_radians(self.end_degrees))
		begin_shape()
		for x in range(self.start_degrees+1, self.end_degrees, angle_distance):


			d_x, d_y = self.delta_coords(x, curr_radius)

			e_x = d_x + center_x
			e_y = d_y + center_y

			vertex(s_x, s_y)
			vertex(e_x, e_y)
			# line((s_x, s_y), (e_x, e_y))

			s_x = e_x
			s_y = e_y




		end_shape()

		# print(curr_radius)



class Dashes(ArcSegment):
	def __init__(self, start_degrees, start_radius, end_degrees=None):
		super(Dashes, self).__init__()

		self.start_degrees = start_degrees
		self.end_degrees = random.randint(start_degrees+10, start_degrees+30)

		self.start_radius = start_radius

		scaler = 450.0 / self.start_radius
		spacing = int(3 * scaler)  # 3
		# print(spacing)

		self.spacing = spacing

	def make(self):

		line_size = 3
		#
		# if any([
		# 	self.spacing == 0,
		# 	]):
		# 	self.spacing = 1


		for angle in range(self.start_degrees, self.end_degrees, self.spacing):

			d_x1,d_y1 = self.delta_coords(angle, self.start_radius)
			x1 = d_x1 + center_x
			y1 = d_y1 + center_y

			new_angle = angle+line_size

			if new_angle >= self.end_degrees:
				break

			d_x2, d_y2 = self.delta_coords(new_angle, self.start_radius)
			x2 = d_x2 + center_x
			y2 = d_y2 + center_y



			line((x1, y1), (x2, y2))




def setup():
	size(window_w	, window_h)





def draw():

	background(255)
	ellipse_mode('RADIUS')
	noise_seed(seed_num)
	stroke_weight(1.2)

	loops = 20

	possible_objects = [
		Arc,
		ZigZag,
		Dashes,
		Mothers
	]

	radius = 80
	arc_spacing = 20
	for num in range(1, loops, 1):

		arc_radius = radius + (arc_spacing * num)

		obj_un_i = copy.deepcopy(random.choice(possible_objects))

		#start_degrees, start_radius, end_degrees=None
		start_degrees = random.randint(0,360)
		end_degrees = random.randint(0,180) + start_degrees
		obj = obj_un_i(start_degrees, arc_radius, end_degrees=end_degrees)

		print(obj)

		obj.make()




	# save_svg('/Users/marcleonard/Desktop/test.svg', window_w, window_h)

	# save(f'/Users/marcleonard/Desktop//output_{seed_num}_.png')
	no_loop()
	# exit(1)

	#####



run()
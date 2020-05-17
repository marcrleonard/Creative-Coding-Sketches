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
rad_inc = .075
seed_num = 60

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

			self.start_radius += self.rad_inc

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



			curr_radius += self.rad_inc

		end_shape()

		# print(curr_radius)


class MultiArc(ArcSegment):
	def __init__(self, start_degrees, start_radius, end_degrees=None):
		super(MultiArc, self).__init__()

		self.start_degrees = start_degrees
		self.end_degrees = random.randint(start_degrees + 15, start_degrees + 140)

		arc_delta = self.end_degrees - self.start_degrees
		# print(f'{arc_delta} - ({self.start_degrees}, {self.end_degrees})')

		self.start_radius = start_radius

	def make(self):
		how_many_arc = random.choice([1,2,3])
		which_arcs = random.sample(range(1, 4), how_many_arc)

		distance_apart = 7

		if 1 in which_arcs:
			a1 = Arc(self.start_degrees+5, start_radius=self.start_radius+distance_apart, end_degrees=random.randint(self.end_degrees-5, self.end_degrees))
			a1.make()

		if 2 in which_arcs:
			a1 = Arc(self.start_degrees + 5, start_radius=self.start_radius - distance_apart, end_degrees=random.randint(self.end_degrees-5, self.end_degrees))
			a1.make()

		if 3 in which_arcs:
			a1 = Arc(self.start_degrees, start_radius=self.start_radius, end_degrees=random.randint(self.end_degrees-5, self.end_degrees))
			a1.make()


class Barbells(ArcSegment):
	def __init__(self, start_degrees, start_radius, end_degrees=None):
		super(Barbells, self).__init__()

		self.start_degrees = start_degrees
		self.end_degrees = random.randint(start_degrees+10, start_degrees+30)

		self.start_radius = start_radius

		scaler  = 388.0/self.start_radius
		spacing = int(3 *scaler) # 3
		# print(spacing)
		self.spacing = spacing


	def make(self):


		for angle in range(self.start_degrees + 1, self.end_degrees, self.spacing):
			barbell_height = 14

			x1,y1 = self.delta_coords(angle, self.start_radius  - (barbell_height/2))
			x2,y2 = self.delta_coords(angle, self.start_radius + (barbell_height/2))

			x1 = x1+center_x
			y1 = y1+center_y
			x2 = x2 + center_x
			y2 = y2 + center_y

			line((x1, y1), (x2, y2))
			circle((x1, y1), 3)
			circle((x2, y2), 3)


class Dots(ArcSegment):
	def __init__(self, start_degrees, start_radius, end_degrees=None):
		super(Dots, self).__init__()

		self.start_degrees = start_degrees
		self.end_degrees = random.randint(start_degrees+10, start_degrees+50)

		self.start_radius = start_radius

		scaler = 388.0 / self.start_radius
		spacing = int(3 * scaler)  # 3
		# print(spacing)
		self.spacing = spacing



	def make(self):


		for angle in range(self.start_degrees, self.end_degrees, self.spacing):

			d_x1,d_y1 = self.delta_coords(angle, self.start_radius)
			x1 = d_x1 + center_x
			y1 = d_y1 + center_y

			circle((x1, y1), 3)


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

class Verts(ArcSegment):
	def __init__(self, start_degrees, start_radius, end_degrees=None):
		super(Verts, self).__init__()

		self.start_degrees = start_degrees
		self.end_degrees = random.randint(start_degrees+10, start_degrees+30)

		self.start_radius = start_radius

		scaler = 450.0 / self.start_radius
		spacing = int(3 * scaler)  # 3
		# print(spacing)

		self.spacing = spacing

	def make(self):

		line_size = 16.0


		for angle in range(self.start_degrees, self.end_degrees, self.spacing):

			d_x1,d_y1 = self.delta_coords(angle, self.start_radius - line_size/2.0)
			x1 = d_x1 + center_x
			y1 = d_y1 + center_y

			d_x2, d_y2 = self.delta_coords(angle, self.start_radius + line_size/2.0)
			x2 = d_x2 + center_x
			y2 = d_y2 + center_y



			line((x1, y1), (x2, y2))



class SegmentJog(ArcSegment):
	def __init__(self, start_degrees, start_radius, end_degrees=None):
		super(SegmentJog, self).__init__()

		self.start_degrees = start_degrees
		self.end_degrees = start_degrees

		self.start_radius = start_radius

		self.line_height = 18

		# self.rad_inc = self.line_height/2


	def make(self):

		line_scaler = 6

		x,y = self.delta_coords(self.start_degrees, self.start_radius)


		i_point_x = 0
		i_point_y = 0
		o_point_x = 0
		o_point_y = i_point_y - self.line_height
		i_point = (i_point_x, i_point_y)
		o_point = (o_point_x, o_point_y)

		push_style()

		translate(x+center_x,y+center_y)
		rotate((self.start_degrees+90) * math.pi / 180)

		line(i_point, o_point)

		i_point = (i_point_x / 2 + line_scaler, i_point_y)
		o_point = (o_point_x * 1.5 - line_scaler, i_point_y)
		line(i_point, o_point)

		i_point = (i_point_x / 2 + line_scaler, o_point_y)
		o_point = (o_point_x * 1.5 - line_scaler, o_point_y)
		line(i_point, o_point)

		pop_style()








def setup():
	size(window_w	, window_h)





def draw():

	background(255)
	ellipse_mode('RADIUS')
	noise_seed(seed_num)
	stroke_weight(1.2)

	loops = 220

	possible_objects = [
		Arc,
		Barbells,
		# SegmentJog,
		ZigZag,
		MultiArc,
		Dots,
		Dashes,
		Verts
	]

	starting_arc = Arc(90, 75)
	starting_arc.make()
	end_degrees = starting_arc.end_degrees
	ending_radius = starting_arc.end_radius

	last_obj = starting_arc



	for num in range(loops):

		# DO NOT PUT ZIGZAG AND BARBELLS NEXT TO EACH OTHER...

		# start_degrees, start_radius

		spacing_scaler = (360 / end_degrees )
		arc_seperation = int(8.0 * spacing_scaler)

		obj_un_i = copy.deepcopy(random.choice(possible_objects))
		obj = obj_un_i(end_degrees + arc_seperation, ending_radius)

		if any([
			isinstance(last_obj, ZigZag),
			isinstance(last_obj, Barbells),
			isinstance(last_obj, Dots),
			isinstance(last_obj, Verts),
			]):

			while any([
				isinstance(obj, ZigZag),
				isinstance(obj, Barbells),
				isinstance(obj, Dots),
				isinstance(obj, Verts)
			]) :
				obj_un_i = copy.deepcopy(random.choice(possible_objects))
				obj = obj_un_i(end_degrees + 5, ending_radius)



		obj.make()
		last_obj = obj

		end_degrees = obj.end_degrees
		ending_radius = obj.end_radius


	#create vericals
	spacing = 10
	x_offset = 300

	v_random_amt = 100

	offset_1 = random.randint(-v_random_amt, v_random_amt)
	offset_2 = random.randint(-v_random_amt, v_random_amt)

	v1 = (x_offset , window_h*.12 + offset_1)
	v2 = (x_offset , window_h*.88+ offset_2)
	line(v1, v2)

	offset_1 = random.randint(-v_random_amt, v_random_amt)
	offset_2 = random.randint(-v_random_amt, v_random_amt)
	v1 = (x_offset+spacing, window_h * .12 + offset_1)
	v2 = (x_offset+spacing, window_h * .88+ offset_2)
	line(v1, v2)
	line(v1, v2)

	offset_1 = random.randint(-v_random_amt, v_random_amt)
	offset_2 = random.randint(-v_random_amt, v_random_amt)
	v1 = (x_offset + spacing*2, window_h * .12 + offset_1)
	v2 = (x_offset + spacing*2, window_h * .88+ offset_2)
	line(v1, v2)
	line(v1, v2)


	#####
	offset_1 = random.randint(-v_random_amt, v_random_amt)
	offset_2 = random.randint(-v_random_amt, v_random_amt)
	v1 = (window_w - x_offset, window_h*.12 + offset_1)
	v2 = (window_w - x_offset, window_h*.88 + offset_2)
	line(v1, v2)

	offset_1 = random.randint(-v_random_amt, v_random_amt)
	offset_2 = random.randint(-v_random_amt, v_random_amt)
	v1 = (window_w - x_offset+spacing, window_h * .12 + offset_1)
	v2 = (window_w - x_offset+spacing, window_h * .88 + offset_2)
	line(v1, v2)
	line(v1, v2)

	offset_1 = random.randint(-20, 20)
	offset_2 = random.randint(-20, 20)
	v1 = (window_w - x_offset + spacing*2, window_h * .12 + offset_1)
	v2 = (window_w - x_offset + spacing*2, window_h * .88 + offset_2)
	line(v1, v2)
	line(v1, v2)


	save_svg('/Users/marcleonard/Desktop/test.svg', window_w, window_h)

	save(f'/Users/marcleonard/Desktop//output_{seed_num}_.png')
	exit(1)

	#####



run()
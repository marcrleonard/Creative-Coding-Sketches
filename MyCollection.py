
import math
import random
import pathlib
import drawSvg
from p5 import *
import sys

def save_svg(output_path, window_w, window_h):
	dq = p5.renderer.draw_queue

	# why is this different from the the specified canvas size? is there a transform/scaler soemwhere?
	# print(p5.sketch.size)

	svg_canvas = drawSvg.Drawing(window_w, window_h, origin=(0,0), displayInline=False)

	# There may be a better way to do this through the init above, but I found it confusing.
	# it was much easier to just hardcode it.
	svg_canvas.viewBox = (0, 0, window_w, window_h)

	for geo, meta in dq:


		if geo == 'lines':

			vertices, edges, stroke, stroke_weight, stroke_cap, stroke_join = meta

			verts = vertices.tolist()
			if verts == [[0.0, 0.0, 0.0]]:
				# print(f'verts contains one item of {[[0.0, 0.0, 0.0]]} ... continuing.')
				continue

			start_l = verts.pop(0)
			start_x = start_l[0]

			# the lib wants to always make Y coods negative. This is likely because of the assumption
			# the moving physically down on the Y axis puts an object in the correct region.
			# Basically, negative Y is 'viewable' where as in P5, positive Y is viewable.
			start_y = -start_l[1]

			other_verts = []
			for o_v in verts:
				x=o_v[0]

				# See note above about negative Y values.
				y=-o_v[1]

				z=o_v[2]
				other_verts.append(x)
				other_verts.append(y)

			svg_obj = drawSvg.Lines(start_x, start_y, *other_verts, fill='none', stroke='black', stroke_width=stroke_weight, close=False)



		elif geo == 'triangles':
			vertices, idx, fill = meta

			verts = vertices.tolist()

			start_l = verts.pop(0)
			start_x = start_l[0]

			# See note above about negative Y values.
			start_y = -start_l[1]

			other_verts = []
			for o_v in verts:
				x = o_v[0]

				# See note above about negative Y values.
				y = -o_v[1]

				z = o_v[2]
				other_verts.extend([x,y])

			svg_obj = drawSvg.Lines(start_x, start_y, *other_verts, fill='none', stroke='black', stroke_width=2,
									 close=False)

		else:
			# A good example is 'Points"
			# elif geo == 'points':
			# 	vertices, idx, stroke = meta
			# 	raise NotImplemented()

			raise NotImplemented("This geometry is not implemented yet.")


		svg_canvas.append(svg_obj)

	svg_canvas.saveSvg(output_path)

	del svg_canvas



def degrees_to_radians(d):
	return d * math.pi / 180

def delta_coords(degrees, distance):
	angle_radians = degrees * math.pi / 180
	x = math.cos(angle_radians) * distance
	y = math.sin(angle_radians) * distance
	return x, y


def get_end_angle_in_bounds(angle_in, low_bounds=20, high_bounds=90):
	#end between 20 and 90
	# low_bounds = 20
	# high_bounds = 90

	to_add_back = 0
	while True:

		while angle_in > 360:
			angle_in = angle_in - 360
			to_add_back +=360

		if low_bounds <= angle_in <= high_bounds:
			break

		angle_in = angle_in + 1

	# this is the LOW bound.
	angle_in = angle_in + to_add_back
	# add a random amount on top.
	amt_extra = random.randint(0, high_bounds-low_bounds)
	random_end_angle = angle_in + amt_extra

	return random_end_angle


from svgsort import main as svg_sort

def clean_svg(svg_path_in):
	i_file = pathlib.Path(svg_path_in)
	# svg_path_in = str(i_file.absolute())
	# folder = pathlib.Path(svg_path_in).parents[0]

	out = f'{i_file.stem}_cleaned.svg'

	dim = f'14x11'

	sys.argv.extend([f'{svg_path_in}', f'{out}', '--no-sort', '--no-split', '--no-adjust', '--pad-abs', '--pad=200', f'--dim={dim}'])

	svg_sort()


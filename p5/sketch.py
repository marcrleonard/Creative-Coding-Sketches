from p5_git.p5 import *

def setup():
    size(1920, 1080, density=2)
    no_stroke()
    background(204)



def draw():
    if mouse_is_pressed:
        fill(random_uniform(255), random_uniform(127), random_uniform(51), 127)
    else:
        fill(255, 15)

    circle_size = random_uniform(low=10, high=80)
    # print(frame_rate)
    circle((mouse_x, mouse_y), circle_size)

def key_pressed(event):
    background(204)

run(frame_rate=60)

import p5 as p

def setup():
    p.size(640, 360)
    p.no_stroke()
    p.background(204)

def draw():
    if p.mouse_is_pressed:
        p.fill(p.random_uniform(255), p.random_uniform(127), p.random_uniform(51), 127)
    else:
        p.fill(255, 15)

    circle_size = p.random_uniform(low=10, high=80)

    p.circle((p.mouse_x, p.mouse_y), circle_size)

def key_pressed(event):
    p.background(204)

p.run()
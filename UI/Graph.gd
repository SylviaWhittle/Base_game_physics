extends Panel


onready var x_resolution = 40
onready var y_resolution = 16
onready var line_colour = Color(150, 70, 90);
onready var points = []
onready var x_spacing = rect_size.x / x_resolution
onready var y_spacing = rect_size.y / y_resolution




# Called when the node enters the scene tree for the first time.
func _ready():
	$line.global_position = Vector2(0, 0)
	
	for i in range(x_resolution):
		points.append(0)
	for i in range(x_resolution-1):
		$line.add_point(Vector2(100, 100));

func addpoint(value):
	points.pop_front();
	points.append(value);

func updategraph():
	for point_index in range(x_resolution):
		$line.set_point_position(point_index, Vector2(self.rect_global_position.x + point_index * x_spacing, rect_global_position.y - points[point_index] * y_spacing + rect_size.y - 5))

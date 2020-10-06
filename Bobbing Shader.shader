shader_type canvas_item;

void vertex() {
	VERTEX.y += 1.5 * sin(TIME);
}
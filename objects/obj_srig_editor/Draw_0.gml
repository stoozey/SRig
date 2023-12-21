var _gridSize = 64;
var _cellSize = 32;
var _gridEnd = (_gridSize * _cellSize);
for (var _gridX = 0; _gridX < _gridSize; _gridX++)
{
	var _x = (_gridX * _cellSize);
	draw_line(_x, 0, _x, _gridEnd);

	for (var _gridY = 0; _gridY < _gridSize; _gridY++)
	{
		var _y = (_gridY * _cellSize);
		draw_line(0, _y, _gridEnd, _y);
	}
}

horse.draw(0, 0, 0, 0, 0, 0, 1, 1, 1, pr_trianglelist);
gizmoAxis.draw(0, 0, 0, 0, 0, 0, 1, 1, 1, pr_trianglelist);
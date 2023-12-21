camera = camera_create();
camera_set_view_size(camera, window_get_width(), window_get_height());

gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);

//gizmoAxis = new SRig().from_file("gizmo_axis.srig");

horse = new SRig().from_file("horse.srig");

var _createArrow = function(_subImg)
{
	return new SRigMesh()
		.set_vertex_buffer_from_file("editor/models/arrow.vbuff")
		.set_texture_sprite_name("spr_srig_editor_tx_gizmo", _subImg);
}

var _xArrow = _createArrow(0)
	.set_name("x")
	.set_anchor_rotation(0, 0, 90);

var _yArrow = _createArrow(1)
	.set_name("y")
	.set_anchor_rotation(0, 0, 0);

var _zArrow = _createArrow(2)
	.set_name("z")
	.set_anchor_rotation(-90, 0, 0);

gizmoAxis = new SRig()
	.add_mesh(_xArrow)
	.add_mesh(_yArrow)
	.add_mesh(_zArrow)
	.to_file("gizmo_axis.srig");
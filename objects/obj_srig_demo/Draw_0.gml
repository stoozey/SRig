shader_set(shd_3d);

	var _anchorRotationX = 0;
	var _anchorRotationY = 45 * dsin(current_time / 2);
	var _anchorRotationZ = 0;
	var _legFrontLeft = rig.get_mesh("leg_front_left")
		.set_anchor_rotation(_anchorRotationX, _anchorRotationY, _anchorRotationZ);
	var _legFrontRight = rig.get_mesh("leg_back_left")
		.set_anchor_rotation(_anchorRotationX, _anchorRotationY, _anchorRotationZ);
	var _legBackLeft = rig.get_mesh("leg_front_right")
		.set_anchor_rotation(_anchorRotationX, -_anchorRotationY, _anchorRotationZ);
	var _legBackRight = rig.get_mesh("leg_back_right")
		.set_anchor_rotation(_anchorRotationX, -_anchorRotationY, _anchorRotationZ);

	var _anchorPositionX = 0;
	var _anchorPositionY = 0;
	var _anchorPositionZ = 2 *dcos(current_time / 2);
	var _head = rig.get_mesh("head")
		.set_anchor_position(_anchorPositionX, _anchorPositionY, _anchorPositionZ);

	var _x = 0;
	var _y = 0;
	var _z = 0;
	var _xRotation = 0;
	var _yRotation = 0;
	var _zRotation = 0;//current_time / 25;
	var _xScale = 1;
	var _yScale = 1;
	var _zScale = 1;
	var _primitiveType = pr_trianglelist;
	rig.draw(_x, _y, _z, _xRotation, _yRotation, _zRotation, _xScale, _yScale, _zScale, _primitiveType);
shader_reset();
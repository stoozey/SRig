camera = camera_create();
camera_set_view_size(camera, 1024, 720);

gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);



rig = new SRig().from_file("horse.srig");



//vertexFormat = new __srig_class_vertex_format()
//		.add_position_3d()
//	    .add_normal()
//	    .add_texcoord()
//	    .add_colour()
//		.generate();

//rig = new SRig(vertexFormat);


//var _vbuffFileToSRigMesh = function(_filename, _name)
//{
//	var _buffer = buffer_load(_filename);
//	var _vertexBuffer = vertex_create_buffer_from_buffer(_buffer, vertexFormat.get_descriptor());
//	buffer_delete(_buffer);
	
//	var _mesh = new SRigMesh()
//		.set_name(_name)
//		.set_vertex_buffer(_vertexBuffer)
//		.set_texture_sprite_name("spr_tx_horse");
	
//	rig.add_mesh(_mesh);
//	return _mesh;
//}

//_vbuffFileToSRigMesh("loose/horse-body.vbuff", "body");

//_vbuffFileToSRigMesh("loose/horse-head.vbuff", "head")
//	.set_origin_offset(48.617, 0, 25.1893);
		
//_vbuffFileToSRigMesh("loose/horse-fl.vbuff", "leg_front_left")
//	.set_origin_offset(29.79, 0, -33.615);

//_vbuffFileToSRigMesh("loose/horse-fr.vbuff", "leg_front_right")
//	.set_origin_offset(29.79, 0, -33.615);

//_vbuffFileToSRigMesh("loose/horse-bl.vbuff", "leg_back_left")
//	.set_origin_offset(-30.934, 0, -39.943);

//_vbuffFileToSRigMesh("loose/horse-br.vbuff", "leg_back_right")
//	.set_origin_offset(-30.934, 0, -39.943);
	
//rig.to_file("horse.srig");
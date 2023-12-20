var _xFrom = (64);
var _yFrom = (64);
var _zFrom = (92);

var _xTo = (0);
var _yTo = (0);
var _zTo = (0);

var _viewMat = matrix_build_lookat(_xFrom, _yFrom, _zFrom, _xTo, _yTo, _zTo, 0, 0, 1);
var _projMat = matrix_build_projection_perspective_fov(-60, -window_get_width() / window_get_height(), 1, 10_000);
camera_set_view_mat(camera, _viewMat);
camera_set_proj_mat(camera, _projMat);
camera_apply(camera);

draw_clear(c_black);

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
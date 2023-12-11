function SRigModel() constructor
{
    static destroy = function()
    {
        var i = 0;
        repeat (ds_list_size(__meshes))
        {
            var _mesh = __meshes[| i++];
            _mesh.destroy();
        }
        
        ds_list_destroy(__meshes);
    }
    
    static __draw_mesh = function(_mesh, _x, _y, _z, _xRotation, _yRotation, _zRotation, _xScale, _yScale, _zScale, _primitiveType)
    {
        // TEMP VALUES
        var _meshX = _x;
        var _meshY = _y;
        var _meshZ = _z;
        var _meshXRotation = _xRotation;
        var _meshYRotation = _yRotation;
        var _meshZRotation = _zRotation;
        var _meshXScale = _xScale;
        var _meshYScale = _yScale;
        var _meshZScale = _zScale;
        _mesh.draw(_meshX, _meshY, _meshZ, _meshXRotation, _meshYRotation, _meshZRotation, _meshXScale, _meshYScale, _meshZScale, _primitiveType);
    }
    
    static draw_general = function(_x, _y, _z, _xRotation, _yRotation, _zRotation, _xScale, _yScale, _zScale, _primitiveType)
    {
        var i = 0;
        repeat (ds_list_size(__meshes))
        {
            var _mesh = __meshes[| i++];
            __draw_mesh(_mesh, _x, _y, _z, _xRotation, _yRotation, _zRotation, _xScale, _yScale, _zScale, _primitiveType);
        }
    }
    
    __originPosition = new __srig_class_vector3();
    __meshes = ds_list_create();
}
function SRig(_defaultVertexFormat = undefined) constructor
{
    static destroy = function()
    {
        var i = 0;
        var _names = variable_struct_get_names(__meshes);
        repeat (array_length(_names))
        {
            var _name = _names[i++];
            var _mesh = __meshes[$ _name];
            _mesh.destroy();
        }
        
        delete __meshes;
    }
    
    static get_mesh = function(_name)
    {
        return ((variable_struct_exists(__meshes, _name)) ? __meshes[$ _name] : undefined);
    }
    
    static mesh_exists = function(_name)
    {
        return (get_mesh(_name) != undefined);
    }
    
    static add_mesh = function(_mesh, _applyDefaultVertexFormat = true)
    {
        var _duplicateIndex = 0;
        var _originalName = _mesh.get_name();
        var _name = _originalName;
        while (mesh_exists(_name))
            _name = (_originalName + "_" + string(_duplicateIndex++));
        
		 if (_applyDefaultVertexFormat)
            _mesh.set_vertex_format(__defaultVertexFormat);
		
        _mesh.set_name(_name);
        __meshes[$ _name] = _mesh;
    }
    
	static add_mesh_from_file = function(_filename, _applyDefaultVertexFormat = true)
    {
        var _buffer = buffer_load(_filename);
        var _mesh = new __srig_class_mesh();
    }
	
    static draw_general = function(_x, _y, _z, _xRotation, _yRotation, _zRotation, _xScale, _yScale, _zScale, _primitiveType)
    {
        var i = 0;
        var _names = variable_struct_get_names(__meshes);
        repeat (array_length(_names))
        {
            var _name = _names[i++];
            var _mesh = __meshes[$ _name];
            _mesh.draw(_x, _y, _z, _xRotation, _yRotation, _zRotation, _xScale, _yScale, _zScale, _primitiveType);
        }
        
        matrix_set(matrix_world, global.__srig_identity_matrix);
    }
    
	__defaultVertexFormat = (_defaultVertexFormat ?? global.__srig_default_vertex_format);
    
    __originPosition = new __srig_class_vector3();
    __meshes = { };
}
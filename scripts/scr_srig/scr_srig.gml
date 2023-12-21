function SRig(_defaultDescriptor = undefined) constructor
{
	static to_buffer = function()
	{
		var _buffer = buffer_create(1024, buffer_grow, 1);
		var i = 0;
        var _names = variable_struct_get_names(__meshes);
        var _totalNames = array_length(_names);
		buffer_write(_buffer, buffer_u64, _totalNames);
		repeat (_totalNames)
        {
            var _name = _names[i++];
            var _mesh = __meshes[$ _name];
			_mesh.write_to_buffer(_buffer);
		}
		
		return _buffer;
	}
	
	static to_file = function(_filename)
	{
		var _buffer = to_buffer();
		buffer_save(_buffer, _filename);
		buffer_delete(_buffer);
		
		return self;
	}
	
	static from_buffer = function(_buffer, _deleteBuffer = true)
	{
		clear_meshes();
		
		var _totalNames = buffer_read(_buffer, buffer_u64);
		repeat (_totalNames)
		{
			var _mesh = new SRigMesh()
				.read_from_buffer(_buffer);
			add_mesh(_mesh);
		}
		
		if (_deleteBuffer)
			buffer_delete(_buffer);
		
		return self;
	}
	
	static from_file = function(_filename)
	{
		var _buffer = buffer_load(_filename);
		from_buffer(_buffer, true);
		
		return self;
	}
	
	static clear_meshes = function()
	{
		var i = 0;
        var _names = variable_struct_get_names(__meshes);
        repeat (array_length(_names))
        {
            var _name = _names[i++];
            var _mesh = __meshes[$ _name];
            _mesh.destroy();
        }
        
        __meshes = { };
	}
	
    static destroy = function()
    {
        clear_meshes();
		delete __meshes;
    }
    
	static get_default_descriptor = function()
	{
		return __defaultDescriptor;
	}
	
    static get_mesh = function(_name)
    {
        return ((variable_struct_exists(__meshes, _name)) ? __meshes[$ _name] : undefined);
    }
    
    static mesh_exists = function(_name)
    {
        return (get_mesh(_name) != undefined);
    }
    
    static add_mesh = function(_mesh, _applyDefaultDescriptor = true)
    {
        var _duplicateIndex = 0;
        var _originalName = _mesh.get_name();
        var _name = _originalName;
        while (mesh_exists(_name))
            _name = (_originalName + "_" + string(_duplicateIndex++));
        
		 if (_applyDefaultDescriptor)
            _mesh.set_descriptor(__defaultDescriptor);
		
        _mesh.set_name(_name);
        __meshes[$ _name] = _mesh;
		return self;
    }
	
    static draw = function(_x, _y, _z, _xRotation, _yRotation, _zRotation, _xScale, _yScale, _zScale, _primitiveType)
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
    
	__defaultDescriptor = (_defaultDescriptor ?? global.__srig_default_descriptor);
    
    __originPosition = new __srig_class_vector3();
    __meshes = { };
}
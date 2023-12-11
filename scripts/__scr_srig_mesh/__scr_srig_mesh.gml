function __srig_class_mesh() constructor
{
    #region setters
    
    static set_name = function(_name)
    {
        __name = _name;
        return self;
    }
    
    static set_origin_offset = function(_originOffset)
    {
        __originOffset = _originOffset;
        return self;
    }
    
    static set_scale = function(_scale)
    {
        __scale = _scale;
        return self;
    }
    
    static set_vertex_buffer = function(_vertexBuffer)
    {
        __vertexBuffer = _vertexBuffer;
        return self;
    }
    
    static set_vertex_format = function(_vertexFormat)
    {
        __vertexFormat = _vertexFormat;
        return self;
    }
    
    #endregion
    
    #region getters
    
    static get_name = function(_name)
    {
        return __name;
    }
    
    static get_origin_offset = function(_originOffset)
    {
        return __originOffset;
    }
    
    static get_scale = function(_scale)
    {
        return __scale;
    }
    
    static get_vertex_buffer = function(_vertexBuffer)
    {
        return __vertexBuffer;
    }
    
    static get_vertex_format = function(_vertexFormat)
    {
        return __vertexFormat;
    }
    
    #endregion
    
    static to_buffer = function()
    {
        var _buffer = buffer_create(1024, buffer_grow, 1);
        buffer_write(_buffer, buffer_string, __name);
        __originOffset.write_to_buffer(_buffer);
        __scale.write_to_buffer(_buffer);
        __vertexFormat.write_to_buffer(_buffer);
        
        var _vertexBuffer = buffer_create_from_vertex_buffer(__vertexBuffer, buffer_fixed, 1);
        var _vertexBufferSize = buffer_get_size(_vertexBuffer);
        var _vertexBufferEncoded = buffer_base64_encode(_vertexBuffer, 0, _vertexBufferSize);
        buffer_delete(_vertexBuffer);
        buffer_write(_buffer, buffer_string, _vertexBufferEncoded);
    }
    
    static from_buffer = function(_buffer, _deleteBuffer = true)
    {
        __name = buffer_read(_buffer, buffer_string);
        __originOffset.read_from_buffer(_buffer);
        __scale.read_from_buffer(_buffer);
        __vertexFormat.read_from_buffer(_buffer);
        
        var _vertexBufferEncoded = buffer_read(_buffer, buffer_string);
        var _vertexBuffer = buffer_base64_decode(_vertexBufferEncoded);
        var _vertexFormat = __vertexFormat.generate();
        __vertexBuffer = vertex_create_buffer_from_buffer(_vertexBuffer, _vertexFormat);
        buffer_delete(_vertexBuffer);
    }
    
    static draw = function(_x, _y, _z, _xRotation, _yRotation, _zRotation, _xScale, _yScale, _zScale, _texture = -1, _primitiveType = pr_trianglelist)
    {
        matrix_set(matrix_world, matrix_build(_x, _y, _z, _xRotation, _yRotation, _zRotation, _xScale, _yScale, _zScale));
            vertex_submit(__vertexBuffer, _primitiveType, _texture);
        matrix_set(matrix_world, matrix_build_identity());
    }
    
    __name = "";
    __originOffset = new __srig_class_vector3();
    __scale = new __srig_class_vector3();
    __vertexFormat = new __srig_class_vertex_format();
    __vertexBuffer = -1;
}
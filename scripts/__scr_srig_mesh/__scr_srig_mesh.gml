function __srig_class_mesh() constructor
{
    #region setters
    
    static set_name = function(_name)
    {
        __name = _name;
        return self;
    }
    
    static set_texture_sprite_name = function(_textureSpriteName)
    {
        __textureSpriteName = _textureSpriteName;
        
        var _spriteIndex = asset_get_index(_textureSpriteName);
        __texture = ((_spriteIndex == -1) ? -1 : sprite_get_texture(_spriteIndex, 0));
        
        return self;
    }
    
    static set_anchor_point = function(_anchorPoint)
    {
        __anchorPoint = _anchorPoint;
        build_anchor_matrix();
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
        if (__vertexBuffer != -1)
            vertex_delete_buffer(__vertexBuffer);
        
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
    
    static get_name = function()
    {
        return __name;
    }
    
    static set_texture_sprite_name = function()
    {
        return __textureSpriteName;
    }
    
    static get_anchor_point = function()
    {
        return __anchorPoint;
    }
    
    static get_origin_offset = function()
    {
        return __originOffset;
    }
    
    static get_scale = function()
    {
        return __scale;
    }
    
    static get_vertex_buffer = function()
    {
        return __vertexBuffer;
    }
    
    static get_vertex_format = function()
    {
        return __vertexFormat;
    }
    
    #endregion
    
    static build_anchor_matrix = function()
    {
        __anchorMatrix = matrix_build(__anchorPoint.x, __anchorPoint.y, __anchorPoint.z, 0, 0, 0, 1, 1, 1);
    }
    
    static destroy = function()
    {
        __vertexFormat.destroy();
        
        if (__vertexBuffer != -1)
            vertex_delete_buffer(__vertexBuffer);
    }
    
    static write_to_buffer = function()
    {
        buffer_write(_buffer, buffer_string, __name);
        buffer_write(_buffer, buffer_string, __textureSpriteName);
        __anchorPoint.write_to_buffer(_buffer);
        __originOffset.write_to_buffer(_buffer);
        __scale.write_to_buffer(_buffer);
        __vertexFormat.write_to_buffer(_buffer);
        
        var _vertexBuffer = buffer_create_from_vertex_buffer(__vertexBuffer, buffer_fixed, 1);
        var _vertexBufferSize = buffer_get_size(_vertexBuffer);
        var _vertexBufferEncoded = buffer_base64_encode(_vertexBuffer, 0, _vertexBufferSize);
        buffer_delete(_vertexBuffer);
        buffer_write(_buffer, buffer_string, _vertexBufferEncoded);
    }
    
    static read_from_buffer = function(_buffer)
    {
        set_name(buffer_read(_buffer, buffer_string));
        set_texture_sprite_name(buffer_read(_buffer, buffer_string));
        __anchorPoint.read_from_buffer(_buffer);
        __originOffset.read_from_buffer(_buffer);
        __scale.read_from_buffer(_buffer);
        __vertexFormat.read_from_buffer(_buffer);
        
        var _vertexBufferEncoded = buffer_read(_buffer, buffer_string);
        var _vertexBuffer = buffer_base64_decode(_vertexBufferEncoded);
        var _vertexFormat = __vertexFormat.get_vertex_format();
        set_vertex_buffer(vertex_create_buffer_from_buffer(_vertexBuffer, _vertexFormat));
        buffer_delete(_vertexBuffer);
    }
    
    static draw = function(_x, _y, _z, _xRotation, _yRotation, _zRotation, _xScale, _yScale, _zScale, _primitiveType)
    {
        var _positionMatrix = matrix_build((_x + __originOffset.x), (_y + __originOffset.y), (_z + __originOffset.z), 0, 0, 0, 1, 1 ,1);
        var _rotationMatrix = matrix_build(0, 0, 0, _xRotation, _yRotation, _zRotation, 1, 1, 1);
        var _scaleMatrix = matrix_build(0, 0, 0, 0, 0, 0, _xScale, _yScale, _zScale);
        var _matrix = matrix_multiply(matrix_multiply(matrix_multiply(__anchorMatrix, _positionMatrix), _rotationMatrix), _scaleMatrix);
        matrix_set(matrix_world, _matrix);
        vertex_submit(__vertexBuffer, _primitiveType, __texture);
    }

    __name = "";
    __textureSpriteName = "";
    __anchorPoint = new __srig_class_vector3();
    __originOffset = new __srig_class_vector3();
    __scale = new __srig_class_vector3();
    __vertexFormat = new __srig_class_vertex_format();
    __vertexBuffer = -1;
    
    __texture = -1;
    __anchorMatrix = global.__srig_identity_matrix;
}
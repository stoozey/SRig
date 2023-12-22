function SRigMesh() constructor
{
    #region setters
    
    static set_name = function(_name)
    {
        __name = _name;
        return self;
    }
    
    static set_texture_sprite_name = function(_textureSpriteName, _subImg = 0)
    {
        __textureSpriteName = _textureSpriteName;
		__textureSpriteSubImg = _subImg;
		
        var _spriteIndex = asset_get_index(__textureSpriteName);
        __texture = ((_spriteIndex == -1) ? -1 : sprite_get_texture(_spriteIndex, _subImg));
		
        return self;
    }
    
    static set_anchor_position = function(_anchorPositionX, _anchorPositionY, _anchorPositionZ)
    {
        __anchorPosition.x = _anchorPositionX;
		__anchorPosition.y = _anchorPositionY;
		__anchorPosition.z = _anchorPositionZ;
        build_anchor_matrices();
        return self;
    }
    
    static set_anchor_rotation = function(_anchorRotationX, _anchorRotationY, _anchorRotationZ)
    {
        __anchorRotation.x = _anchorRotationX;
		__anchorRotation.y = _anchorRotationY;
		__anchorRotation.z = _anchorRotationZ;
        build_anchor_matrices();
        return self;
    }
    
    static set_anchor_scale = function(_anchorScaleX, _anchorScaleY, _anchorScaleZ)
    {
        __anchorScale.x = _anchorScaleX;
		__anchorScale.y = _anchorScaleY;
		__anchorScale.z = _anchorScaleZ;
        build_anchor_matrices();
        return self;
    }
    
    static set_origin_offset = function(_originX, _originY, _originZ)
    {
        __originOffset.x = _originX;
		__originOffset.y = _originY;
		__originOffset.z = _originZ;
        return self;
    }
    
    static set_scale = function(_scaleX, _scaleY, _scaleZ)
    {
        __scale.x = _scaleX;
		__scale.y = _scaleY;
		__scale.z = _scaleZ;
        return self;
    }
    
    static set_vertex_buffer = function(_vertexBuffer)
    {
        if (__vertexBuffer != -1)
            vertex_delete_buffer(__vertexBuffer);
        
        __vertexBuffer = _vertexBuffer;
        return self;
    }
    
	static set_vertex_buffer_from_file = function(_filename)
	{
		var _buffer = buffer_load(_filename);
		var _vertexBuffer = vertex_create_buffer_from_buffer(_buffer, __descriptor.get_vertex_format());
		buffer_delete(_buffer);
		set_vertex_buffer(_vertexBuffer);
		return self;
	}
	
    static set_descriptor = function(_descriptor)
    {
        __descriptor = _descriptor;
        return self;
    }
    
    #endregion
    
    #region getters
    
    static get_name = function()
    {
        return __name;
    }
    
    static get_texture_sprite_name = function()
    {
        return __textureSpriteName;
    }
    
    static get_anchor_position = function()
    {
        return __anchorPosition;
    }
	
    static get_anchor_rotation = function()
    {
        return __anchorRotation;
    }
	
    static get_anchor_scale = function()
    {
        return __anchorScale;
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
    
    static get_descriptor = function()
    {
        return __descriptor;
    }
    
    #endregion
    
	
    static build_anchor_matrices = function()
    {
        var _anchorPositionMatrix = matrix_build(__anchorPosition.x, __anchorPosition.y, __anchorPosition.z, 0, 0, 0, 1, 1, 1);
        var _anchorRotationMatrix = matrix_build(0, 0, 0, __anchorRotation.x, __anchorRotation.y, __anchorRotation.z, 1, 1, 1);
        var _anchorScaleMatrix = matrix_build(0, 0, 0, 0, 0, 0, __anchorScale.x, __anchorScale.y, __anchorScale.z);
		__anchorMatrix = matrix_multiply(matrix_multiply(_anchorPositionMatrix, _anchorRotationMatrix), _anchorScaleMatrix);
    }
    
    static destroy = function()
    {
        __descriptor.destroy();
        
        if (__vertexBuffer != -1)
            vertex_delete_buffer(__vertexBuffer);
    }
    
    static write_to_buffer = function(_buffer)
    {
        buffer_write(_buffer, buffer_string, __name);
        buffer_write(_buffer, buffer_string, __textureSpriteName);
        buffer_write(_buffer, buffer_u16, __textureSpriteSubImg);
        __anchorPosition.write_to_buffer(_buffer);
        __anchorRotation.write_to_buffer(_buffer);
        __anchorScale.write_to_buffer(_buffer);
        __originOffset.write_to_buffer(_buffer);
        __scale.write_to_buffer(_buffer);
        __descriptor.write_to_buffer(_buffer);
        
        var _vertexBuffer = buffer_create_from_vertex_buffer(__vertexBuffer, buffer_fixed, 1);
        var _vertexBufferSize = buffer_get_size(_vertexBuffer);
        var _vertexBufferEncoded = buffer_base64_encode(_vertexBuffer, 0, _vertexBufferSize);
        buffer_delete(_vertexBuffer);
        buffer_write(_buffer, buffer_string, _vertexBufferEncoded);
		
		return self;
    }
    
    static read_from_buffer = function(_inBuffer)
    {
		var _name = buffer_read(_inBuffer, buffer_string);
        set_name(_name);
		var _textureSpriteName = buffer_read(_inBuffer, buffer_string);
		var _textureSpriteSubImg = buffer_read(_inBuffer, buffer_u16);
        set_texture_sprite_name(_textureSpriteName, _textureSpriteSubImg);
        __anchorPosition.read_from_buffer(_inBuffer);
        __anchorRotation.read_from_buffer(_inBuffer);
        __anchorScale.read_from_buffer(_inBuffer);
		build_anchor_matrices();
        __originOffset.read_from_buffer(_inBuffer);
        __scale.read_from_buffer(_inBuffer);
        __descriptor.read_from_buffer(_inBuffer);
		
		//show_message(json_stringify(self, true));
        var _bufferEncoded = buffer_read(_inBuffer, buffer_string);
        var _buffer = buffer_base64_decode(_bufferEncoded);
        var _vertexFormat = __descriptor.get_vertex_format();
		var _vertexBuffer = vertex_create_buffer_from_buffer(_buffer, _vertexFormat);
        set_vertex_buffer(_vertexBuffer);
        buffer_delete(_buffer);
		
		return self;
    }
    
    static draw = function(_x, _y, _z, _xRotation, _yRotation, _zRotation, _xScale, _yScale, _zScale, _primitiveType)
    {
        var _positionMatrix = matrix_build((_x + __originOffset.x), (_y + __originOffset.y), (_z + __originOffset.z), 0, 0, 0, 1, 1 ,1);
        var _rotationMatrix = matrix_build(0, 0, 0, _xRotation, _yRotation, _zRotation, 1, 1, 1);
        var _scaleMatrix = matrix_build(0, 0, 0, 0, 0, 0, _xScale, _yScale, _zScale);
		var _drawMatrix = matrix_multiply(matrix_multiply(_positionMatrix, _rotationMatrix), _scaleMatrix);
		var _matrix = matrix_multiply(__anchorMatrix, _drawMatrix);
        matrix_set(matrix_world, _matrix);
        vertex_submit(__vertexBuffer, _primitiveType, __texture);
    }

    __name = "";
    __textureSpriteName = "";
	__textureSpriteSubImg = 0;
    __anchorPosition = new __srig_class_vector3();
    __anchorRotation = new __srig_class_vector3();
    __anchorScale = new __srig_class_vector3(1, 1, 1);
    __originOffset = new __srig_class_vector3();
    __scale = new __srig_class_vector3();
    __descriptor = srig_descriptor_build_default();
    __vertexBuffer = -1;
    
    __texture = -1;
    __anchorMatrix = global.__srig_identity_matrix;
}
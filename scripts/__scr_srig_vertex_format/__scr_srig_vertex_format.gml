function __srig_class_vertex_format() constructor
{
    static destroy = function()
    {
        ds_list_destroy(__values);
        
        if (__vertexFormat != -1)
            vertex_format_delete(__vertexFormat);
    }
    
    static add_colour = function()
    {
        var _value = new __srig_class_vertex_format_value(__SRIG_VERTEX_FORMAT_TYPE.COLOUR);
        __add_value(_value);
        return self;
    }
    
    static add_normal = function()
    {
        var _value = new __srig_class_vertex_format_value(__SRIG_VERTEX_FORMAT_TYPE.NORMAL);
        __add_value(_value);
        return self;
    }
    
    static add_position = function()
    {
        var _value = new __srig_class_vertex_format_value(__SRIG_VERTEX_FORMAT_TYPE.POSITION);
        __add_value(_value);
        return self;
    }
    
    static add_position_3d = function()
    {
        var _value = new __srig_class_vertex_format_value(__SRIG_VERTEX_FORMAT_TYPE.POSITION_3D);
        __add_value(_value);
        return self;
    }
    
    static add_texcoord = function()
    {
        var _value = new __srig_class_vertex_format_value(__SRIG_VERTEX_FORMAT_TYPE.TEXCOORD);
        __add_value(_value);
        return self;
    }
    
    static add_custom = function(_customType, _customUsage)
    {
        var _value = new __srig_class_vertex_format_value(__SRIG_VERTEX_FORMAT_TYPE.CUSTOM, _customType, _customUsage);
        __add_value(_value);
        return self;
    }
    
    static get_vertex_format = function()
    {
        return __vertexFormat;
    }
    
    static generate = function()
    {
        if (__vertexFormat != -1)
            vertex_format_delete(__vertexFormat);
        
        vertex_format_begin();
            var i = 0;
            repeat (ds_list_size(__values))
            {
                var _value = __values[| i++];
                _value.add();
            }
        __vertexFormat = vertex_format_end();
    }
    
    static write_to_buffer = function(_buffer)
    {
        var _totalValues = ds_list_size(__values);
        buffer_write(_buffer, buffer_u8, _totalValues);
        
        var i = 0;
        repeat (_totalValues)
        {
            var _value = __values[| i++];
            _value.write_to_buffer(_buffer);
        }
    }
    
    static read_from_buffer = function(_buffer)
    {
        ds_list_clear(__values);
        
        var _totalValues = buffer_read(_buffer, buffer_u8);
        repeat (_totalValues)
        {
            var _value = new __srig_class_vertex_format_value();
            _value.read_from_buffer(_buffer);
               
            __add_value(_value);
        }
    }
    
    static __add_value = function(_value)
    {
        ds_list_add(__values, _value);
    }
    
    __values = ds_list_create();
    __vertexFormat = -1;
}
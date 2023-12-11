function __srig_class_vertex_format() constructor
{
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
    
    static write_to_buffer = function(_buffer)
    {
        var _totalValues = array_length(__values);
        buffer_write(_buffer, buffer_u8, _totalValues);
        
        var i = 0;
        repeat (_totalValues)
            __values[i++].write_to_buffer(_buffer);
    }
    
    static read_from_buffer = function(_buffer)
    {
        __values = [];
        
        var i = 0;
        var _totalValues = buffer_read(_buffer, buffer_u8);
        repeat (_totalValues)
        {
            var _value = new __srig_class_vertex_format_value();
            _value.read_from_buffer(_buffer);
               
            __add_value(_value);
        }
    }
    
    static generate = function()
    {
        vertex_format_begin();
        var i = 0;
        repeat (array_length(__values))
            __values[i++].add();
        
        return vertex_format_end();
    }
    
    static __add_value = function(_value)
    {
        var _index = array_length(__values);
        __values[_index] = _value;
    }
    
    __values = [];
}
enum __SRIG_VERTEX_FORMAT_TYPE {
    COLOUR,
    NORMAL,
    POSITION,
    POSITION_3D,
    TEXCOORD,
    CUSTOM
}

function __srig_class_vertex_format_value(_formatType = -1, _customType = -1, _customUsage = -1) constructor
{
    static add = function()
    {
        switch (__formatType)
        {
            case __SRIG_VERTEX_FORMAT_TYPE.COLOUR:
                vertex_format_add_color();
                break;
        
            case __SRIG_VERTEX_FORMAT_TYPE.NORMAL:
                vertex_format_add_normal();
                break;
        
            case __SRIG_VERTEX_FORMAT_TYPE.POSITION:
                vertex_format_add_position();
                break;
        
            case __SRIG_VERTEX_FORMAT_TYPE.POSITION_3D:
                vertex_format_add_position_3d();
                break;
        
            case __SRIG_VERTEX_FORMAT_TYPE.TEXCOORD:
                vertex_format_add_texcoord();
                break;
        
            case __SRIG_VERTEX_FORMAT_TYPE.CUSTOM:
                vertex_format_add_custom(__customType, __customUsage);
                break;
        }
    }
    
    static write_to_buffer = function(_buffer)
    {
        buffer_write(_buffer, buffer_u8, __formatType);
        
        if (__formatType == __SRIG_VERTEX_FORMAT_TYPE.CUSTOM)
        {
            buffer_write(_buffer, buffer_u8, __customType);
            buffer_write(_buffer, buffer_u8, __customUsage);
        }
    }
    
    static read_from_buffer = function(_buffer)
    {
        __formatType = buffer_read(_buffer, buffer_u8);
        
        if (__formatType == __SRIG_VERTEX_FORMAT_TYPE.CUSTOM)
        {
            __customType = buffer_read(_buffer, buffer_u8);
            __customUsage = buffer_read(_buffer, buffer_u8);
        }
    }
    
    __formatType = _formatType;
    __customType = _customType;
    __customUsage = _customUsage;
}
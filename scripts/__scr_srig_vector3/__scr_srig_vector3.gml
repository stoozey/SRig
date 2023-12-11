function __srig_class_vector3(_x = 0, _y = 0, _z = 0) constructor
{
    static write_to_buffer = function(_buffer)
    {
        buffer_write(_buffer, buffer_f64, x);
        buffer_write(_buffer, buffer_f64, y);
        buffer_write(_buffer, buffer_f64, z);
    }
    
    static read_from_buffer = function(_buffer)
    {
        x = buffer_read(_buffer, buffer_f64);
        y = buffer_read(_buffer, buffer_f64);
        z = buffer_read(_buffer, buffer_f64);
    }
    
    x = _x;
    y = _y;
    z = _y;
}
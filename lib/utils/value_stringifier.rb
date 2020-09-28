def stringify(value)
  if value.nil? || value == true || value == 'true'
    't'
  elsif value == false || value == 'false'
    'f'
  else
    value
  end
end

def unstringify(value)
  if value == 't' || value == 'true'
    true
  elsif value == 'f' || value == 'false' || value == nil
    false
  else
    value
  end
end

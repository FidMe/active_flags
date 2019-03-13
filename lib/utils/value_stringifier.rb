def stringify(value)
  if value.nil? || value == true
    't'
  elsif value == false
    'f'
  else
    value
  end
end

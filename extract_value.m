function val = extract_value(color, idx)
s = color(idx);
s = char(s);
s = strsplit(s, ':');
s = s(2);
val = str2double(s);
end
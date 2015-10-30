function val = extract_value(color, attr)
val = -1;
for c = color
    attribute = strsplit(char(c), ':');
    if strcmp(char(attribute(1)), attr)
        s = attribute(2);
        val = str2double(s);
    end
end
end
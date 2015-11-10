% Helper function to extract the value of a
% specific attribute in a cell array of strings
% representing the color of a token.

% The order of the colors (attributes) in the array
% does not matter because we search for the given
% attribute independent of the index.

% Given the colors c = {'at:2', 'unit_id:3', 'total:19', job_id:7'}
% and
% val = extract_value(c, 'total')
% 'val' would be equal to 19.
function val = extract_value(color, attr)
val = -1;
for c = color
    % Split the color on ':' and store the two
    % resulting values in a variable.
    attribute = strsplit(char(c), ':');
    % Compare the attribute name for the current
    % color with the attribute name given in as
    % a parameter.
    if strcmp(char(attribute(1)), attr)
	% The value of the attribute is the second element
	% in the tuple. Convert it to a number before we return.
        s = attribute(2);
        val = str2double(s);
    end
end
end

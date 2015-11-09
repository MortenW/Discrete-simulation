function jid = job_id(color)
c = {char(color(1)), char(color(2)), char(color(3)), char(color(4))};
jid = extract_value(c, 'job_id');
end
function x = fal(e, alpha, delta)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
if abs(e) <= delta
    x = e / (delta ^ (alpha - 1));
else
    x = abs(e) ^ alpha * sign(e);
end
end


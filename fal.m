function x = fal(e, alpha, delta)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if abs(e) <= delta
    x = e / (delta ^ (alpha - 1));
else
    x = abs(e) ^ alpha * sign(e);
end
end


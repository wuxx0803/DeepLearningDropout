function net = feedForward_nn(net, x, opt, epochNum)

	numLayers = length(net.layers); % total number of layers
	net.layers{1}.a = x;
    ido = opt.input_do_rate(epochNum);
    hdo = opt.hidden_do_rate(epochNum);
    if opt.gaussian
        net.layers{1}.ga = normrnd(1, sqrt((1-ido)/ido), size(net.layers{1}.a));
        net.layers{1}.a = net.layers{1}.a .* net.layers{1}.ga;
    end
    if opt.dropout
        net.layers{1}.do = rand(size(net.layers{1}.a)) <= ido;
        net.layers{1}.a = net.layers{1}.a .* net.layers{1}.do;
    end

	for l = 2 : numLayers
		net.layers{l}.a = sigmoid(bsxfun(@plus, net.layers{l}.w * net.layers{l - 1}.a, net.layers{l}.b));
        if l < numLayers && opt.gaussian
            net.layers{l}.ga = normrnd(1, sqrt((1-hdo)/hdo), size(net.layers{l}.a));
            net.layers{l}.a = net.layers{l}.a .* net.layers{l}.ga;
        end
        if l < numLayers && opt.dropout
            net.layers{l}.do = rand(size(net.layers{l}.a)) <= hdo;
            net.layers{l}.a = net.layers{l}.a .* net.layers{l}.do;
        end
	end
end
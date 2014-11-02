function output = test_nn(opt);

    %%
    %load ../data/letterrecognition.mat
    %load ../data/mnist_uint8.mat
    load ../data/gisette.mat
    % load ../data/magic04.mat
    %% 

    rand('state',0)

    nn.layers = {
        struct('type', 'I') %input layer
        %struct('type', 'F', 'n', 1024) %fully connected layer
        %struct('type', 'F', 'n', 1024) %fully connected layer
        %struct('type', 'F', 'n', 256) %fully connected layer
        struct('type', 'F', 'n', 64) %fully connected layer
        struct('type', 'F', 'n', 16) %fully connected layer
        struct('type', 'F', 'n', 4) %fully connected layer
        struct('type', 'O') %output layer
    };

    nn.errors = zeros(opt.numEpochs,1);

    train_x = reshape(train_x, size(train_x,1), size(train_x,3));
    test_x = reshape(test_x, size(test_x,1), size(test_x,3));
    % train_x = double(train_x');
    % test_x = double(test_x');
    % train_y = double(train_y');
    % test_y = double(test_y');
    % alpha = 0.3;
    % batchSize = 25;
    % numEpochs = 40;
    nn = setup_nn(nn, train_x, train_y);
    nn = train_nn(nn, train_x, train_y, test_x, test_y, opt);

    % testing

    %[er, bad] = testerror(nn, test_x, test_y);

    output = nn;%.errors;

end


function [ a_opt, Yhat, Q, Q_TS, Q_TS_learn ] = TS_run_divided( X, Y, c, m, max_step, div_rate )
[X_learn, Y_learn, X_test, Y_test] = divide_into_learn_and_test(X, Y, div_rate);
[ a_opt, V, Q, Q_TS_learn ] = TS_run(X_learn, Y_learn, c, m, max_step);
dist = DistL2(X_learn);
U = FCM.gen_U(V, X_test, m, dist);
Yhat = TS_test(X_test, U, a_opt);
U_learn = FCM.gen_U(V, X_learn, m, dist);
Yhat_learn = TS_test(X_learn, U_learn, a_opt);
Q_TS = sqrt(sum((Y_test-Yhat).^2)/size(Y_test,1));

plot(Y_learn, Yhat_learn, 'black.', Y_test, Yhat, 'red.');
maks = max(max(max(Y_learn),max(Yhat_learn)),max(max(Y_test),max(Yhat)));
axis([0 maks 0 maks]);
end

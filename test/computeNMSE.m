function nmse = computeNMSE(Y, Yhat)
nmse = 10*log10(norm(Y(:)-Yhat(:))^2 / norm(Y(:))^2);
end
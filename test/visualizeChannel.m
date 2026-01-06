function visualizeChannel(Y, Yhat)
figure;
subplot(1,2,1); imagesc(abs(Y)); title('True');
subplot(1,2,2); imagesc(abs(Yhat)); title('Predicted');
end
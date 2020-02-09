% scatter(meas(:,1),meas(:,2),c,'filled');
% hold on
% scatter(meas(:,3),meas(:,4),c,'filled');
% hold off
load fisheriris
DiscrModel = fitcdiscr(meas,species);
DiscrModel.Mu
DiscrModel.Coeffs

X = [meas(:,3) meas(:,4)];
DiscrModelPetal = fitcdiscr(X,species);
% Now To represent the distribution on the scatter plot
gscatter(meas(:,3),meas(:,4),species,'rgb','osd');
% to find coefficients of the linear boundary between the setosa and
% versicolor classes (first and second class) in thAT order
Const12 = DiscrModelPetal.Coeffs(1,2).Const
Linear12 = DiscrModelPetal.Coeffs(1,2).Linear;
% Now we plot a curve that separates the first and second classes
hold on
Bound12 = @(x1,x2)Const12 + Linear12(1)*x1 + Linear12(2)*x2;
B12 = ezplot(Bound12,[0 7.2 0 2.8]);
B12.Color = 'r';
B12.LineWidth = 2;
% Now to retrieve the coefficients of the linear boundary
% between  second and third class in that order.
Const23 = DiscrModelPetal.Coeffs(2,3).Const;
Linear23 = DiscrModelPetal.Coeffs(2,3).Linear;
% CUrve that separates the first and second classes
Bound23 = @(x1,x2)Const23 + Linear23(1)*x1+Linear23(2)*x2;
B23 = ezplot(Bound23,[0 7.2 0 2.8]);
B23.Color = 'b';
B23.LineWidth = 2;
% Now we set The access label and title
xlabel('Petal Lenght')
ylabel('Petal Width')
title('{\bf Linear Classification By Discriminant Analysis}');
% boundaries are shown / drawn within the species. To investigate The
% correct functioning of the algorithm by classifying 3 new Points in the
% figure falling in the 3 floral type origin areas

% Now to introduce the new Points
NewPointsX  = [2 5 6];
NewPointsY = [0.5 1.5 2];
% TO predict the classes of the new data. Use the predict function which
% return a vector of predicted class labels for the predicted data provided
% based on the trained discriminant analysis classification model
LabelsNewPoints = predict(DiscrModelPetal,[NewPointsX' NewPointsY'])

% Now to plot the pointa on the scatter plot with boundaries to verify
% correct classification
plot(NewPointsX,NewPointsY,'*')
% The points are clearly indicated on the scatter plot with * symbol
% indicated on them. 
% Thew Model that has been classified is good but some values tend to fall
% in the boundary of the two class
% To improve the models accuracy set the discrim type Name Value Pair to Pseudo
 %to pseudo linear. Or Pseudo quadratic
 
 % To test the perfomance of the model. we find the resubstitution error
 DiscrModelResubErr = resubLoss(DiscrModel);
 %The result indicates that 2% of the observations are misclassified. By
 %the Linear discriminant function.  To understand how the errors are
 %distributed. We can find the confusion Matrix
 % first we collect the models Prediction for the Available Data.
 
 PredictedValue = predict(DiscrModel,meas);
 ConfMat = confusionmat(species,PredictedValue)
 % The result shows that their are are only 3errors 2% of the available
 % values refering to two versicolor and  virginica species
 % to identify which one they are, we draw X through the misclassified
 % Points.
 Error = ~strcmp(PredictedValue,species); % finds the incorrect values by comparing two strings and returns one which is true if the two are identical
 % and zero if false otherwise.
 gscatter(meas(:,3),meas(:,4),species,'rgb','osd')
 hold on;
 plot(meas(Error,3),meas(Error,4),'kx')
 xlabel('Petal Length')
 ylabel('Petal Width')
 
 
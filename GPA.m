%% GPA AND CGPA CALCULATOR

clc;
fprintf('    GPA AND CGPA CALCULATOR\n');

%% Enter number of semesters
studentName=input('Enter student name:','s');   
numSemesters= input('Enter number of semesters: ');

totalWeightedPoints= 0;
totalCreditUnits= 0;

semesterGPA= zeros(numSemesters,1);

%% Enter information for each semester
for s=1:numSemesters
    fprintf('\n----- SEMESTER %d -----\n', s);
    numCourses= input('Enter number of courses: ');

    weightedPoints= 0;
    creditUnits= 0;
    
    for c= 1:numCourses

        fprintf('\nCourse %d\n',c);

        CU= input('Enter credit units: ');
        GP= input('Enter grade points: ');

        weightedPoints= weightedPoints+(CU*GP);
        creditUnits= creditUnits+CU;

    end

    % Calculate semester GPA
    semesterGPA(s)= weightedPoints/creditUnits;

    %Add semester totals to CGPA totals
    totalWeightedPoints= totalWeightedPoints+weightedPoints;
    totalCreditUnits=totalCreditUnits+creditUnits;

    fprintf('\nGPA for Semester %d= %.2f\n' ...
        , semesterGPA(s));
end

%% Calculate CGPA
CGPA= totalWeightedPoints /totalCreditUnits;

%% Display results
fprintf('     RESULTS\n');

for s= 1:numSemesters
    fprintf(' Semester %d GPA= %.2f\n',...
        s, semesterGPA(s));
end

fprintf('\nCGPA= %.2f\n', CGPA);
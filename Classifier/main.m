fileName = 'IMD008.txt';
fileID = fopen(fileName);
values = textscan(fileID,'%10.2f %10.2f %10.2f');
fclose(fileID);

border = values{1};
nMDiameter = values{2};
nMAsymmetry = values{3};

nMRegularBorder = uint8(abs(border - (nMDiameter * pi)));

%nonMelanomaClass = regularBorder + diameter + asymmetry;

folder = 'C:\Users\raulmacintosh\Documents\Projeto\Results\';
newDataName = [folder fileName];
resultFile = fopen(newDataName, 'w');

fprintf(resultFile, 'Ben�gno\n');
fclose(resultFile);



fileName = 'IMD001.txt';
fileID = fopen(fileName);
values = textscan(fileID,'%10.2f %10.2f %10.2f');
fclose(fileID);

border = values{1};
mDiameter = values{2};
mAsymmetry = values{3};

mRegularBorder = uint8(abs(border - (mDiameter * pi)));

%melanomaClass = regularBorder + diameter + asymmetry;

newDataName = [folder fileName];
resultFile = fopen(newDataName, 'w');

fprintf(resultFile, 'Mal�gno\n');
fclose(resultFile);

for i = 2:7
    fileName = ['IMD00' int2str(i) '.txt'];
	fileID = fopen(fileName);
	values = textscan(fileID,'%10.2f %10.2f %10.2f');
	fclose(fileID);

	border = values{1};
	diameter = values{2};
	asymmetry = values{3};
    
    regularBorder = uint8(abs(border - (diameter * pi)));

    borderDistanceNM = double(regularBorder - nMRegularBorder).^2;
    borderDistanceM = double(regularBorder - mRegularBorder).^2;
    diameterDistanceNM = double(diameter - nMDiameter).^2;
    diameterDistanceM = double(diameter - mDiameter).^2;
    asymmetryDistanceNM = double(asymmetry - nMAsymmetry).^2;
    asymmetryDistanceM = double(asymmetry - mAsymmetry).^2;
    
    distanceNM = sqrt(double(borderDistanceNM + diameterDistanceNM + asymmetryDistanceNM));
    distanceM = sqrt(double(borderDistanceM + diameterDistanceM + asymmetryDistanceM));
    
    if (sqrt(borderDistanceM) < sqrt(borderDistanceNM))
        newDataName = [folder fileName];
        resultFile = fopen(newDataName, 'w');
        fprintf(resultFile, 'Mal�gno\n');
        fclose(resultFile);
        
        mRegularBorder = (mRegularBorder + regularBorder)/2;
    else
        if (sqrt(diameterDistanceM) < sqrt(diameterDistanceNM))
            newDataName = [folder fileName];
            resultFile = fopen(newDataName, 'w');
            fprintf(resultFile, 'Mal�gno\n');
            fclose(resultFile);

            mDiameter = (mDiameter + diameter)/2;
        else
            
            if (sqrt(asymmetryDistanceM) < sqrt(asymmetryDistanceNM))
                newDataName = [folder fileName];
                resultFile = fopen(newDataName, 'w');
                fprintf(resultFile, 'Mal�gno\n');
                fclose(resultFile);

                mAsymmetry = (mAsymmetry + asymmetry)/2;
            else
                newDataName = [folder fileName];
                resultFile = fopen(newDataName, 'w');
                fprintf(resultFile, 'Ben�gno\n');
                fclose(resultFile);

                nMRegularBorder = (nMRegularBorder + regularBorder)/2;
                nMAsymmetry = (nMAsymmetry + asymmetry)/2;
                nMDiameter = (nMDiameter + diameter)/2;
            end
        end
    end
    
    
    
    
    %if (distanceM < distanceM)
    %    newDataName = [folder fileName];
    %    resultFile = fopen(newDataName, 'w');
    %    fprintf(resultFile, 'Mal�gno\n');
    %    fclose(resultFile);
        
    %    mRegularBorder = (mRegularBorder + regularBorder)/2;
    %    mDiameter = (mDiameter + diameter)/2;
    %    mAsymmetry = (mAsymmetry + asymmetry)/2;
        %melanomaClass = (melanomaClass + tumor)/2;
    %else
    %    newDataName = [folder fileName];
    %    resultFile = fopen(newDataName, 'w');
    %    fprintf(resultFile, 'Ben�gno\n');
    %    fclose(resultFile);
        
    %    nMRegularBorder = (nMRegularBorder + regularBorder)/2;
    %    nMDiameter = (nMDiameter + diameter)/2;
    %    nMAsymmetry = (nMAsymmetry + asymmetry)/2;
        %nonMelanomaClass = (nonMelanomaClass + tumor)/2;
    %end
end
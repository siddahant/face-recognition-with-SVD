
load Faces.mat 

allPersonsimg = zeros(n*6,m*6); % dummy array 
count = 1;
for j=1:6
    for I=1:6
        allPersonsimg(1+(j-1)*n:j*n,1+(I-1)*m:I*m) ...
            =reshape(faces(:,1+sum(nfaces(1:count-1))),n,m);
        count = count + 1;    
    end
end
figure(1), axes('position',[0 0 1 1])
axis off
%%  All faces in gray scale 
imagesc(allPersonsimg), colormap gray
%%  Extract 8th face from DATA

image(allPersonsimg([192*1:192*2],[168*1:168*2])), colormap gray 
%% Show 24th face

image(allPersonsimg([192*3:192*4],[168*5:168*6])), colormap gray 
%%
for p = 1:length(nfaces)
    Sum_faces = faces(:,1+sum(nfaces(1:p-1)):sum(nfaces(1:p)));
    all_Faces = zeros(n*8,m*8);
    
    count = 1;
    for j=1:8
        for I=1:8
            if(count<=nfaces(p)) 
                all_Faces(1+(j-1)*n:j*n,1+(I-1)*m:I*m) ...
                    = reshape(Sum_faces(:,count),n,m);
                count = count + 1;
            end
        end
    end
    figure(2), axes('position',[0 0 1 1])
    axis off
    imagesc(all_Faces), colormap gray    
end
%%
train_faces = faces(:,1:sum(nfaces(1:36)));
avgface = mean(train_faces,2); 


%% SVD

ST = train_faces-avgface*ones(1,size(train_faces,2));
[U Sum_faces V] = svd(ST,"econ");
%% Ploting Avrage faces
figure(1)
imagesc(reshape(avgface,n,m)); 
%% 
%% Printing first colume of U
figure(2)
imagesc(reshape(U(:,1),n,m))
figure(3)
imagesc(reshape(U(:,24),n,m))
%% 
%% test for 37th face
figure(4)
testface = faces(:,1+sum(nfaces(1:36)));

subplot(2,4,1)
imagesc(reshape(testface,n,m)), colormap gray
axis off
count = 1;
Tdiff = testface - avgface;
for J=[25 50 100 200 400 800 1600]
    count = count+1;
    subplot(2,4,count)
    reconFace = avgface + (U(:,1:J)*(U(:,1:J)'*Tdiff));
    imagesc(reshape(reconFace,n,m)), colormap gray 
    title(['r=',num2str(J)])
    axis off
end
%% Test for 38th face
figure(5)
testface = faces(:,2+sum(nfaces(1:36)));
subplot(2,4,1)
imagesc(reshape(testface,n,m)), colormap gray
axis off
count = 1;
Tdiff = testface - avgface;
for J=[25 50 100 200 400 800 1600]
    count = count+1;
    subplot(2,4,count)
    reconFace = avgface + (U(:,1:J)*(U(:,1:J)'*Tdiff));
    imagesc(reshape(reconFace,n,m)), colormap gray 
    title(['r=',num2str(J)])
    axis off
end
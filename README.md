# Vascular-SNT-Trace-Analysis
All code used to analyze vascular metrics after tracing image files using ImageJ Neuroanatomy SNT

Step 1
Run XYZ_SNT_script.py from the Neuroanatomy SNT plugin to convert traces files into .csv with XYZ coordinates.
To ensure the script runs correctly use the following labels in ImageJ SNT by utilizing the Path Manager Window: Tag -> Type selections
  
  Superficial = (Basal) Dendrite
  
  SI Region = Custom
  
  Intermediate = Apical Dendrite
  
  ID Region = Soma
  
  Two single points at the bottom of the GCL and top of ONL = Undefined
  
When saving these files use the .traces format. I included SNT in my file names which is reflected in the output file names. Feel free to include SNT in the save file name or edit out its mention in the allVascularAnalysis code.

Step 2
Download all files

This will include 5 functions:

  distanceBetweenEndPoints
  
  distanceBetweenPoints
  
  distanceByPathLabel
  
  lengthOfPath
  
  sumDistanceByZ
  
And 2 analysis files:

  allVascularAnalysis can be used to batch process multiple files
  
  allVascularAnalysis_onefile can be used for a single file
  

The results of this code should be .csv files from step 1 and .xlsx from step 2. One of each will be generated for every individual .traces file

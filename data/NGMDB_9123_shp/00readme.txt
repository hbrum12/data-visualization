00readme.txt UNIX ASCII file that describes the digital data for U.S. Geological Survey Miscellaneous Investigations Series Map I-1300, 6/15/2001, pd

Mudge, M.R., Earhart, R.L., Whipple, J.W., Harrison, J.E., Munts, S.R., and Silkwood, J.T., 2001, Geologic and structure map of the Choteau 1o x 2o quadrangle, western Montana: a digital database:  U.S. Geological Survey Miscellaneous Investigations Series Map I-1300, version 1.0, 38 p., 1 digital plate, scale 1:250,000.  Rec'd Director's Approval May 18, 2001.
URL = http://geopubs.wr.usgs.gov/i-map/i1300/ 
  

This report describes the contents of a digital data set which consists of ArcInfo exchange-format files and associated macro programs.  A page-sized, color version of the digital geologic map is included in the report.  The data set also includes macro programs and complete plot files for creating a paper copy of the map at a scale of 1:250,000.  The data set is available on the World Wide Web at http://geopubs.wr.usgs.gov/i-map/i1300/.  It is also available via anonymous FTP from: geopubs.wr.usgs.gov, in the directory: pub/i-map/i1300.

Requirements:  A networked computer system is required to copy the data set from the host computer across the Internet.  A geographic information system (GIS) capable of importing ArcInfo exchange-format files is required for access to the digital files.  The plot files are stored in HPGL2 format (chot250k.hp), encapsulated PostScript format (chot250k.eps), and Adobe portable document format (chot-map.pdf).  The digital data files are in UNIX ASCII format.

***************************************************
Explanation of digital data files:

The GIS for the Choteau quadrangle is available as one UNIX compressed TAR file, chot250k.tar.Z, which includes the report text (chot250k.pdf) in an Adobe Acrobat Portable Document File (PDF) format.

To download the GIS data files, create a new workspace in a UNIX working environment and copy the chot250k.tar.Z file to your new workspace. Use the command 'uncompress -v chot250k.tar.Z' to uncompress the file. Then use the command 'tar -xvf chot250k.tar' to extract the files from the TAR file. And finally, to import the ArcInfo exchange-format files (*e00) into your workspace, open ArcInfo on your workstation and enter '&run importfile' at the Arc prompt.

Your working directory should contain the following files:
00readme.txt - this file in UNIX ASCII format
0readme.txt - this file in DOS ASCII format
importfile.aml -  ArcInfo program to import ArcInfo interchange-format files into the user's workspace.
chot250k.pdf - Open-File Report text in Adobe Acrobat Portable Document File (PDF) format. 

Primary ArcInfo exchange-format files (*.e00) and metadata (*.met) include:

chot250k.e00 - principal line and polygon geologic map coverage
chot250kp.e00 - point GIS for structural symbols
chot250k.met - metadata file

Additional ArcInfo exchange-format files (*.e00) necessary to re-create the digital geologic map:

c250box.e00 - quadrangle boundary
fnt037.e00 - font 37
geol_sfo.lin.e00 - lineset
plotter.lin.e00 - lineset
plotter.mrk.e00 - markerset
geoscamp2.mrk.e00 - markerset
wpgcmyk.shd.e00 - shadeset

ArcInfo AML, graphics, key, and text files necessary to re-create the geologic map:

chot250k.aml  - program to create graphics file of the geologic map
importfile.aml - program to import e00 files
scale2a.aml - program to plot scale bar

indexmap.gra - index map graphic file
usgslogo.gra - USGS visual identity

chotlin2.key - lineset symbol values and descriptive text for lines on the map sheet
chotpoly.key - shadeset symbol values and descriptive text for geologic map units on the map sheet

geo.prj - a text file used to identify real-world (geographic) coordinates - for use in adding latitude and longitude notation around the margins of the map.
trans.prj - a text file to identify Universal Transverse Mercator map projection - for use in adding latitude and longitude notation around the margins of the map.
chotcrd.txt - text file listing map credits
chotdisc.txt - text file for USGS disclaimer
chotref.txt - text file listing map references

Plotter calibration file:
cal.dat - the color calibration file used in the ArcInfo 'HPGL2' command to create plot files of the plates for plotting on the USGS HP650C in the Spokane Field Office.  This file is a custom file for this particular plotter.  Other plotters will require their own custom color calibration file.

ArcInfo graphics (*.gra), HPGL2 (*.hp), encapsulated PostScript (*.eps), and Adobe portable document format (*.pdf) plot files for the digital geologic map (scale 1:250,000):
chot250k.gra
chot250k.hp 
chot250k.eps
chot-map.pdf


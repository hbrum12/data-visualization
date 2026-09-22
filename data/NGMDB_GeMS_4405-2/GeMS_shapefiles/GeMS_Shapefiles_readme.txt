The files in this directory were created from feature classes and tables in Choteau_1x2degree.gdb

Because of limitations in DBF files, only a subset of fields - OBJECTID, Type, Label, MapUnit, Symbol, Azimuth, and Inclination - in feature classes were exported to the shapefiles, if they were present. Azimuth and Inclination were renamed Axi and Inc, respectively. All fields with all content were exported to a CSV file that can be joined to the shapefile in a GIS through the common field OBJECTID. All non-spatial tables were exported as CSV files.

Because of the limitations of the open-source library used for the conversion (GDAL/OGR), rasters in the original gdb are not converted.

The metadata record found in this folder (if conversion proceeded correctly) is a copy of the metadata submitted with the database and may describe the shapefiles found here incompletely. Definitions for all GeMS tables and fields can be found in the GeMS documentation (https://pubs.er.usgs.gov/publication/tm11B10). Definitions for all non-GeMS tables and fields should be in the metadata written for the database. Contact the database author(s) if they are not.

Descriptions of all MapUnit values should be in a DescriptionOfMapUnits table in this folder.
Definitions of values found in fields ending in "Type", "Confidence", and "Method" should be in a Glossary table in this folder.
Definitions of values in all DataSourceID fields should be in a DataSources table in this folder. 

Automated log of conversion process:
GDB source -> shapefile and/or CSV
	ContactsAndFaults -> ContactsAndFaults.shp
	ContactsAndFaults -> ContactsAndFaults.csv
	GeologicLines -> GeologicLines.shp
	GeologicLines -> GeologicLines.csv
	DataSources -> DataSources.csv
	DataSourcePolys -> DataSourcePolys.shp
	DataSourcePolys -> DataSourcePolys.csv
	Glossary -> Glossary.csv
	MapUnitPolys -> MapUnitPolys.shp
	MapUnitPolys -> MapUnitPolys.csv
	DescriptionOfMapUnits -> DescriptionOfMapUnits.csv
	GeoMaterialDict -> GeoMaterialDict.csv

Metadata
	Choteau_1x2degree-metadata.xml

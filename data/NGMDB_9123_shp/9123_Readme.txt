NOTE: This file contains transcribers notes to accompany the original README file (00readme.txt).

This data is a conversion product and should not serve as the primary source for the complete geologic information for this area. To obtain complete information, please go to https://pubs.usgs.gov/imap/i1300/   This information may be found as referenced below:

Publisher:  	U.S. Geological Survey
Title:  	Geologic and Structure Map of the Choteau 1 x 2 degree Quadrangle, Western Montana: A Digital Database
Author(s): 	M.R. Mudge, R.L. Earhart, J.W. Whipple, J.E. Harrison, S.R. Munts, and J.T. Silkwood
Original NGMDB identifier:  9123

Purpose: This file set is intended to make outdated Arc/INFO e00 files available as open-format shapefiles. No modification to files has been made. Projection was not changed. 

Process: e00 files were imported to coverage, then converted to shapefile using the ArcMap commands “Import from e00 (conversion)” and “Feature Class to Shapefile” respectively. Related tables were preserved by opening in ArcMap and exporting to txt.   

E00 files convert to:
	chot250k.e00 (principal line and polygon geologic map) = 
		chot250k_arc.shp
		chot250k_polygon.shp
		chot250k.con.txt
		chot250k.lgu.txt
		chot250k.ref.txt
		chot250k.ru.txt
		chot250k.st2.txt
	chot250p.e00 (structural point data for plunging folds) =
		chot250p_point.shp
		chot250p.ref.txt
		chot250p.sym.txt

Explanation of files, extracted from original metadata (chot250k.met)
      This GIS consists of two major Arc/Info datasets, a line
      and polygon file (chot250k) containing geologic contact
      and structures (lines) and geologic map rock units
      (polygons), and a point file (chot250kp) containing
      structural point data for plunging folds. 

      The 'Geologic and structure map of the Choteau 1 x 2 degree
      quadrangle, Montana: a digital database' report (chot250k.pdf)
      contains a detailed description of each attribute code and a
      reference to the associated map symbols on the map source
      materials.  The GIS includes a geologic line work arc attribute
      table, chot250k.aat, that relates to the chot250k.con (contact
      look-up table), chot250k.st2 (structure look-up table),
      chot250k.lgu (linear geologic units table), and the chot250k.ref
      (source reference look-up table) files; and a rock unit polygon
      attribute table, chot250k.pat, that relates to the chot250k.ru
      (rock unit look-up table) and chot250k.ref (source reference
      look-up table) files; and a point attribute table, chot250kp.pat,
      that relates to the chot250p.sym (symbol description look-up
      table) and the chot250p.ref (source reference look-up table).

Original files included:
	chot250k.met = metadata
	00readme.txt = readme
	chotlin2.key
	chotpoly.key


Modified: 23 August, 2023 by Karen Morgan, USGS contractor 




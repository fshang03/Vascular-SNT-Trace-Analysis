#@Context context
#@DatasetService ds
#@DisplayService display
#@ImageJ ij
#@LegacyService ls
#@LogService log
#@LUTService lut
#@SNTService snt
#@UIService ui


"""
file:    
version: 
info:    
"""

from sc.fiji.snt import Path, PathAndFillManager, SNT, SNTUI, Tree
from sc.fiji.snt.analysis import *
from sc.fiji.snt.analysis.graph import DirectedWeightedGraph
from sc.fiji.snt.analysis.sholl.parsers import TreeParser
from sc.fiji.snt.annotation import AllenCompartment, AllenUtils, VFBUtils, ZBAtlasUtils
from sc.fiji.snt.io import FlyCircuitLoader, MouseLightLoader, NeuroMorphoLoader
from sc.fiji.snt.plugin import SkeletonizerCmd, StrahlerCmd
from sc.fiji.snt.util import BoundingBox, PointInImage, SNTColor, SWCPoint
from sc.fiji.snt.viewer import Annotation3D, OBJMesh, MultiViewer2D, Viewer2D, Viewer3D
import time


#@File traces_file
#@LogService log
#@UIService ui

from sc.fiji.snt import Tree
from sc.fiji.snt.analysis import SNTTable

# load traces file: since file may contain one or more rooted structures
# (trees), we'll use a convenience method that handles multiple trees in
# a single file (or directory). For details:
# https://javadoc.scijava.org/Fiji/sc/fiji/snt/Tree.html
trees = Tree.listFromFile(str(traces_file))
table = SNTTable()
if not trees:
	ui.showDialog("Could not retrieve coordinates. Not a valid file?")
else:
	for tree in trees:
	# now print all nodes in the tree
		for node in tree.getNodes():
			table.appendRow()
			table.appendToLastRow("X", node.getX())
			table.appendToLastRow("Y", node.getY())
			table.appendToLastRow("Z", node.getZ())
			x=str(node.getPath())
			i=x.split(")")
			hold=str(i[0])
			p=hold.split("(")
			if i[1]==" [(basal":
				i[1]="Superficial"
			elif i[1]==" [apical dendrite]":
				i[1]="Intermediate"
			elif i[1]==" [axon]":
				i[1]="Deep"
			elif i[1]==" [custom]":
				i[1]="Diving1"
			elif i[1]==" [soma]":
				i[1]="Diving2"
			else:
				i[1]="CellRescalePoint"
			table.appendToLastRow("Path", p[1])
			table.appendToLastRow("Category", i[1])
		# display and save table
        table.save('%s.csv' % str(traces_file))
					
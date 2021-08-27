SuperStrict

'	TRANSPILER FOR BLITZMAX
'	(c) Copyright Si Dunford, August 2021, All Rights Reserved
'	V0.2

Rem
bbdoc: bmx.transpiler
about: 
End Rem
Module bmx.transpiler

ModuleInfo "Copyright:	Si Dunford, July 2021, All Rights Reserved"
ModuleInfo "Author:		Si Dunford"
ModuleInfo "Version:	0.2"
ModuleInfo "License:	MIT"

ModuleInfo "History:	V0.1, 21 JUL 21"
ModuleInfo "History:	Initial version "
'
ModuleInfo "History:	V0.2, 27 AUG 21"
ModuleInfo "History:	Converted into a module"

'Import BRL.LinkedList
'Import BRL.Map
'Import BRL.Reflection
'Import BRL.Random
'Import BRL.Retro
'Import Text.Regex

Import bmx.blitzmaxparser

'	CORE COMPONENTS
Include "src/TTranspiler.bmx"

'	LANGUAGE SPECIFIC COMPONENTS
Include "src/TTranspileBlitzMax.bmx"	' BlitzMax NG
Include "src/TTranspileCPP.bmx"			' C++
Include "src/TTranspileJava.bmx"		' Java
'Include "src/TTranspileJavaScript.bmx"	' HTML/JavaScript


SuperStrict

'	TRANSPILE BLITZMAX INTO C++
'	(c) Copyright Si Dunford, August 2021, All Rights Reserved
'	V1.0

Import bmx.blitzmaxparser
Import bmx.transpiler

Include "loadfile().bmx"

Const FILENAME:String = "TestFile.bmx"

Local source:String
Local lexer:TLexer
Local parser:TParser

Local start:Int, finish:Int

Local ast:TASTNode

Local transpile:String = StripExt( FILENAME ) + ".cpp"

Try		
	' 	Load the source code
	source = loadFile( FILENAME )
	
	'	Next we load and parse BlitzMax
	Print "STARTING BLITZMAX PARSER:"
	lexer  = New TBlitzMaxLexer( source )
	parser = New TBlitzMaxParser( lexer )
	start  = MilliSecs()
	ast    = parser.parse_ast()
	finish = MilliSecs()
	Print( "BLITZMAX LEXER+PARSE TIME: "+(finish-start)+"ms" )

	If Not ast
		Print "Cannot transpile until syntax corrected"
		End
	End If

	'	SHOW AST STRUCTURE
'	Print "~nAST STRUCTURE:"
'	Print "------------------------------------------------------------"
'	Print ast.reveal()
'	Print "------------------------------------------------------------"

	'	TRANSPILE INTO C++
	Print "~nTRANSPILE AST TO C++:"
	
	Local cpp:TTranspileCPP = New TTranspileCPP( ast )
	source = cpp.run()
'	Print "------------------------------------------------------------"
'	Print source
'	Print "------------------------------------------------------------"

	'	WRITE TRANSPILED CODE TO DISK
	If FileType( transpile ) ; DeleteFile( transpile )
	Local file:TStream = WriteFile( transpile )
	If Not file Then RuntimeError "failed to open "+transpile
	file.WriteString( source )
	CloseStream file
	
Catch e:Object
	Local exception:TException = TException( e )
	Local blitzexception:TBlitzException = TBlitzException( e )
	Local runtime:TRuntimeException = TRuntimeException( e )
	Local text:String = String( e )
	Local typ:TTypeId = TTypeId.ForObject( e )
	If exception Print "## Exception: "+exception.toString()+" ##"
	If blitzexception Print "## BLITZ Exception: "+blitzexception.toString()+" ##"
	If runtime Print "## Exception: "+runtime.toString()+" ##"
	If text Print "## Exception: '"+text+"' ##"
	Print "TYPE: "+typ.name
	Return False
End Try


import os
import re

path = '.\\client\\src\\arcplanner\\lib'
exclude = set(['ui'])

fileList = []
# r=root, d=directories, f = files
for root, dirs, files in os.walk(path, topdown=True):
    dirs[:] = [d for d in dirs if d not in exclude]
    for file in files:
        fileList.append(os.path.join(root, file))

documentation = open("./docs/FlutterDocumentation.md","w+")
documentation.write("""
This page describes all non-ui files within the flutter section of the project  
\nAll documentation is generated with 'documentGeneratorFlutter.py' which can
be found in the docs folder

This page is sectioned by file. The following files can be found:
""")
for filePath in fileList:
    documentation.write(f"- [{os.path.basename(filePath)}]({os.path.basename(filePath).replace('.','')})  \n")

documentation = open("./docs/FlutterDocumentation.md","a")

for filePath in fileList:
    documentation.write("<br/><br/><br/><br/>\n")
    documentation.write("# " + os.path.basename(filePath) + "\n")
    file = open(filePath,"r")
    fileLines = file.readlines()

    headerPrinted = False
    inFunctionComment = False
    i = 10
    while i < len(fileLines):
        parameters = []
        definition = []
        returnLine = ""
        #fileLines[i] = fileLines[i].lstrip
        if headerPrinted == False:
            if fileLines[i].startswith(" * "):
                documentation.write(fileLines[i][2:])
            elif fileLines[i].startswith(" */"):
                documentation.write("\n")
                headerPrinted = True
        
        if not inFunctionComment and fileLines[i].lstrip().startswith("///"):
            inFunctionComment = True
            commentBlock = [fileLines[i]]
        elif inFunctionComment and fileLines[i].lstrip().startswith("///"):
            commentBlock.append(fileLines[i])
        elif inFunctionComment and not fileLines[i].lstrip().startswith("///"):
            inFunctionComment = False
            functionHeader = re.split(r'[(]',fileLines[i])

            # Parse comment block
            k = 0
            while k < len(commentBlock):
                j = 1
                if commentBlock[k].lstrip().startswith("/// @param"):
                    parameterLine = commentBlock[k].lstrip()[11:]
                    while (k + j) < len(commentBlock) and commentBlock[k + j].lstrip().startswith("///   "):
                        parameterLine = parameterLine.rstrip() + commentBlock[k + j].rstrip()[6:]
                        j += 1
                    parameters.append(parameterLine)
                elif commentBlock[k].lstrip().startswith("/// @returns"):
                    returnLine = commentBlock[k].lstrip()[12:]
                    while (k + j) < len(commentBlock) and commentBlock[k + j].lstrip().startswith("///   "):
                        returnLine = returnLine.rstrip() + commentBlock[k + j].rstrip()[6:]
                        j += 1              
                elif commentBlock[k].lstrip().startswith("/// "):
                    definition.append(commentBlock[k].lstrip()[4:])
                k += 1

            if " " in functionHeader[0].lstrip():
                functionHeader = functionHeader[0].lstrip().split(" ")
                returnType = functionHeader[0]
                functionName = functionHeader[1]
            else:
                functionName = functionHeader
                returnType = "void"
            documentation.write(f"### _{functionName} Function_\n")
            documentation.write(f"{' '.join(definition)} \n")
            if len(parameters) != 0:
                documentation.write("**Parameters**   \n\n | Parameter | Definition | \n|-|-|\n")
                for param in parameters:
                    param = param.split(" ", 1)
                    documentation.write(f"| {param[0]} | {param[1].rstrip()} |\n")
            if returnLine != "":
                documentation.write(f"**return type**: {returnType}  ")
                documentation.write(f"\n**return**: {returnLine}\n")
            
            #function return type is functionHeader[2]
        i += 1


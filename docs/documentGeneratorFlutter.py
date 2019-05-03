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
\n All documentation is generated with 'documentGeneratorFlutter.py' which can
be found in the docs folder

""")

documentation = open("./docs/FlutterDocumentation.md","a")

for filePath in fileList:
    documentation.write("# " + os.path.basename(filePath) + "\n")
    file = open(filePath,"r")
    fileLines = file.readlines()

    headerPrinted = False
    inFunctionComment = False
    i = 10
    parameters = []
    definition = []
    returnLine = ""
    while i < len(fileLines):
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
            functionHeader = re.split(r'[ (]',fileLines[i])
            #print("getting here")
            # Parse comment block
            for line in commentBlock:
                if line.lstrip().startswith("/// @param"):
                    parameters.append(line.lstrip()[11:])
                elif line.lstrip().startswith("/// @returns"):
                    returnLine = line.lstrip()[12:]
                else:
                    definition.append(line.lstrip()[4:])


            documentation.write(f"## {functionHeader[3]} Function\n")
            documentation.write(f"{' '.join(definition)} \n")
            if len(parameters) != 0:
                documentation.write("### Parameters\n | Parameter | Definition | \n|-|-|\n")
                for param in parameters:
                    param = param.split(" ", 1)
                    documentation.write(f"| {param[0]} | {param[1].rstrip()} |\n")
            if returnLine != "":
                documentation.write("### Return\n")
                documentation.write(f"**return type**: {functionHeader[2]}  ")
                documentation.write(f"\n**return**: {returnLine}")
            
            #function return type is functionHeader[2]
        
        i += 1


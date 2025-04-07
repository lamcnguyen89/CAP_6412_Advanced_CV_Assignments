import os
from pathlib import Path
import re

files = []
folders = []


Input_Directory = 'input/Input_Images'
Path(Input_Directory).mkdir(parents=True, exist_ok=True)

for (path, dirnames, filenames) in os.walk(Input_Directory):
    folders.extend(os.path.join(path, name) for name in dirnames)
    files.extend(os.path.join(path, name) for name in filenames)

print(files)
print (folders)


# Get file name
for filepath in files:
    print("Original File Path: ", filepath)
    splitFileName = re.split('/|\.', filepath)
    print("File Name: ", splitFileName )



 
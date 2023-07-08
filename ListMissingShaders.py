import os

folderList = ['shader_dat',
              'shader2_dat',
              'shadereff_dat']

for folder in folderList:
    pixelShaders = os.listdir(f'{folder}/ps/')
    vertexShaders = os.listdir(f'{folder}/vs/')
    f = open(f'{folder}/missing.txt', 'w')
    for fshFile in pixelShaders:
        size = os.path.getsize(f'{folder}/ps/{fshFile}')
        if size == 0:            
            f.write(f'PS: {fshFile} ({size} bytes)\n')
    for vshFile in vertexShaders:
        size = os.path.getsize(f'{folder}/vs/{vshFile}')
        if size == 0:            
            f.write(f'VS: {vshFile} ({size} bytes)\n')
    f.close()

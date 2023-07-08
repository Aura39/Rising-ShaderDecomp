# Metal Gear Rising: Revengeance Shader Decompilation

## What is this?

This is a project of decompiling `.pso` and `.vso` files from MGRR

This is made for fun, and for finally modding shaders, the thing no one has ever done on such scale.

## Progress

Remember, this, is not deobfuscation progress, this is file count

![shader.dat progress](https://progress-bar.dev/90?title=shader.dat)
![shader2.dat progress](https://progress-bar.dev/98?title=shader2.dat)
![shadereff.dat progress](https://progress-bar.dev/98?title=shadereff.dat)

## Usage

If you ever want to use it for your mod you have to edit the `.fx` shader, and then recompile it, then you have to repack the `.pso` or `.vso` file into `shader.dat`/`shader2.dat`/`shadereff.dat` in MGRR's `GameData` directory

## Dependencies

- Microsoft DirectX9 SDK (I use June 2010) or any DX9 Shader Model 3.0 Compiler
- Metal Gear Rising Tools for repacking `shader.dat`/`shader2.dat`/`shadereff.dat`

## Contributing

You can contribute to this project either by:

- Helping to deobfuscate `.fx` files
- Adding more shaders (not every shader is decompiled, some cause compilation error)

To contribute you need to clone this repository, make changes, and then do a pull request.

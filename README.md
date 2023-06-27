# Metal Gear Rising: Revengeance Shader Decompilation

## What is this?

This is a project of decompiling `.pso` and `.vso` files from MGRR

## Why?

This is made for fun, and for finally modding shaders, the thing no one has ever done on such scale.

## Usage

If you ever want to use it for your mod you have to edit the `.fx` shader, and then recompile it, then you have to repack the `.pso` or `.vso` file into `shader.dat` in MGRR's `GameData` directory

## Dependencies

- Microsoft DirectX9 SDK (I use June 2010) or any DX9 Shader Model 3.0 Compiler
- Metal Gear Rising Tools for repacking shader.dat

## Contributing

You can contribute to this project either by:

- Helping to deobfuscate `.fx` files
- Adding more shaders (not every shader is decompiled, some cause compilation error)

To contribute you need to clone this repository, make changes, and then do a pull request.

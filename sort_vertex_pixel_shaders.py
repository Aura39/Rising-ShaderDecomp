import os
import re
import shutil

shader_dir = "./shader_dat"

# Define regular expressions for vertex and pixel shaders
vertex_regex = re.compile(r"VS_OUT\s+main", flags=re.MULTILINE)
pixel_regex = re.compile(r"float4\s+main", flags=re.MULTILINE)

# Create directories for vertex and pixel shaders if they don't exist
vertex_dir = os.path.join(shader_dir, "VertexShaders")
if not os.path.exists(vertex_dir):
    os.makedirs(vertex_dir)

pixel_dir = os.path.join(shader_dir, "PixelShaders")
if not os.path.exists(pixel_dir):
    os.makedirs(pixel_dir)

# Loop through all files in the shader directory and check for shader type
for filename in os.listdir(shader_dir):
    filepath = os.path.join(shader_dir, filename)
    if os.path.isfile(filepath):
        with open(filepath, "r") as f:
            contents = f.read()
            if vertex_regex.search(contents):
                # Move file to VertexShaders directory
                shutil.move(filepath, os.path.join(vertex_dir, filename))
            elif pixel_regex.search(contents):
                # Move file to PixelShaders directory
                shutil.move(filepath, os.path.join(pixel_dir, filename))
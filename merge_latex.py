import os
import re
import subprocess

def extract_input_path(latex_content):
    r"""Extract the input path defined by \def\input@path{}."""
    input_path_pattern = re.compile(r'\\def\\input@path\{\{(.+?)\}\}')
    if match := input_path_pattern.search(latex_content):
        return match.group(1)
    return ""

def expand_inputs(latex_content, base_path, input_path):
    r"""Expand all \input{} commands in the LaTeX content."""
    input_pattern = re.compile(r'\\input\{(.+?)\}')
    while True:
        match = input_pattern.search(latex_content)
        if not match:
            break
        input_file = match.group(1)
        # Check if the file already has a .tex extension
        if not input_file.endswith('.tex'):
            input_file += '.tex'
        input_file_path = os.path.join(base_path, input_path, input_file)
        if not os.path.isfile(input_file_path):
            raise FileNotFoundError(f"File {input_file_path} not found.")
        with open(input_file_path, 'r', encoding='utf-8') as f:
            input_content = f.read()
        latex_content = latex_content[:match.start()] + input_content + latex_content[match.end():]
    return latex_content

def run_latex_and_biber(main_tex_path):
    """Run pdflatex and biber to generate the .bbl file."""
    commands = [
        ['pdflatex', '-interaction=nonstopmode', main_tex_path],
        ['biber', os.path.splitext(main_tex_path)[0]],
        ['pdflatex', '-interaction=nonstopmode', main_tex_path],
        ['pdflatex', '-interaction=nonstopmode', main_tex_path]
    ]
    for command in commands:
        result = subprocess.run(command, capture_output=True, text=True)
        if result.returncode != 0:
            print(result.stdout)
            print(result.stderr)
            raise RuntimeError(f"Command {' '.join(command)} failed.")

def replace_bibliography(latex_content, bbl_file_path):
    r"""Replace \printbibliography with contents of the .bbl file."""
    if not os.path.isfile(bbl_file_path):
        raise FileNotFoundError(f"File {bbl_file_path} not found.")
    
    with open(bbl_file_path, 'r', encoding='utf-8') as f:
        bbl_content = f.read()
    
    bbl_content_escaped = re.escape(bbl_content)
    latex_content = re.sub(r'\\printbibliography', bbl_content_escaped, latex_content)
    return latex_content

def process_latex_file(main_tex_path):
    """Process the main LaTeX file by expanding inputs and replacing bibliography."""
    base_path = os.path.dirname(main_tex_path)
    with open(main_tex_path, 'r', encoding='utf-8') as f:
        latex_content = f.read()

    input_path = extract_input_path(latex_content)
    latex_content = expand_inputs(latex_content, base_path, input_path)

    # Write the expanded content to a temporary file
    temp_tex_path = f'{os.path.splitext(main_tex_path)[0]}_expanded.tex'
    with open(temp_tex_path, 'w', encoding='utf-8') as f:
        f.write(latex_content)

    # Run pdflatex and biber to generate the .bbl file
    # run_latex_and_biber(temp_tex_path)

    # # Replace \printbibliography with contents of the .bbl file
    # bbl_file_path = os.path.splitext(temp_tex_path)[0] + '.bbl'
    # latex_content = replace_bibliography(latex_content, bbl_file_path)

    # # Write the final expanded content to a new file
    # output_path = os.path.splitext(main_tex_path)[0] + '_expanded.tex'
    # with open(output_path, 'w', encoding='utf-8') as f:
    #     f.write(latex_content)

    print(f"Expanded LaTeX content has been written to {temp_tex_path}")

if __name__ == "__main__":
    main_tex_path = 'main.tex'  # Path to your main LaTeX file
    
    process_latex_file(main_tex_path)

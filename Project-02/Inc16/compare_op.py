# compare_outputs

with open('Inc16.cmp', 'r') as cmp_file, open('Inc16.out', 'r') as out_file:
    cmp_lines = cmp_file.readlines()
    out_lines = out_file.readlines()
    
    if len(cmp_lines) == len(out_lines):
        for i in range(len(cmp_lines)):
            if cmp_lines[i] != out_lines[i]:
                print(f"Mismatch at line {i+1}:")
                print(f"  Inc16.cmp: {cmp_lines[i].strip()}")
                print(f"  Inc16.out: {out_lines[i].strip()}")
        print("Files match!")
    else:
        print("Files have different number of lines.")
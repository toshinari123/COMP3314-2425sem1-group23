# COMP3314 2024-25 sem 1 group 23

# How to run

## prerequisite

Python 3.12 and Jupyter notebook / lab installed

## with nix flakes

```
nix develop
jl
```

## with jupyter 

1. Open cloned location in jupyter lab
2. Preferably create venv
3. If does not work with default kernel, may need to create jupyter kernel (remember to select it)
```
pip install ipykernel
python -m ipykernel install --user --name=playground
```

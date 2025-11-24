# COMP3314 2024-25 sem 1 group 23

# Paper details

- Title: Visualizing Data using t-SNE
- Authors: Laurens van der Maaten, Geoffrey Hinton
- Venue: Journal of Machine Learning Research 9 (2008) 

https://www.jmlr.org/papers/volume9/vandermaaten08a/vandermaaten08a.pdf

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

# Reproduced figures

All figures but the 2 regarding random walk variation of t-SNE are reproduced. (one of them is simply an explanation diagram and does not need algorithm output)

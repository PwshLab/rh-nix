# Riemann Hypothesis Nix Flake
A Nix flake to build the Lean proof of the Riemann Hypothesis released by Levent Alpöge.

## Building the proof
This command downloads the source and builds it.
It may take several hours.
```sh
nix build github:PwshLab/rh-nix
```

## Source
Links to the original source can be found [here](https://alpo.ge/remark.pdf).
It was published as an archive split into 14 parts:
```
https://alpo.ge/lean.tar.gz.part01
...
https://alpo.ge/lean.tar.gz.part14
```
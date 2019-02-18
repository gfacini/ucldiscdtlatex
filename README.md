# ucldiscdtlatex
University College London (UCL) Centre for Doctoral Training (CDT) in Data Intensive Sciences (DIS) Group Project Report Template = UCLDISCDTLATEX

This package will provide a basic latex environment for Group Project Reports. The following gives instructions for downloading and setting up the package.

# Installing


## Getting the Source

```
mkdir reportdir && cd $_
```

Then clone the source

```
git clone https://github.com/gfacini/ucldiscdtlatex
```

If you have [ssh-keys set up](https://help.github.com/articles/generating-ssh-keys/), then you can clone over SSH instead of HTTPS:

```
git clone git@github.com:gfacini/ucldiscdtlatex
```

At this point, you have the FULL state of the code. You can run ``git log`` to view the recent changes (no more ChangeLog!).

### Checking out a specific tag

You can run ``git tag`` to view all current tags. You can checkout a specific tag (in a detached head state):

```
  cd ucldiscdtlatex
  git checkout tags/XX-YY-ZZ
  cd ../
```

or you can use:

```
  cd ucldiscdtlatex
  git checkout -b XX-YY-ZZ tags/XX-YY-ZZ
  cd ../
```

which switches you from master to a branch of the given version.

# Setup


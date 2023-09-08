I was able to follow the directions here to get VisIt to work:

https://visit-sphinx-github-user-manual.readthedocs.io/en/develop/building_visit/Spack.html#building-visit-with-the-development-version-of-spack

Rough outline:
- Use Spack develop branch
- Patch 3 separate Spack packages
- `spack install` with settings on the website. ~ easily takes more than an hour!
- Start NoMachine
- `spack load visit`
- `visit`

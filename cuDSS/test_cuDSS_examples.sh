#!/bin/bash

# Submit job or request interactive session then run this script.

echo Running cuDSS Example Tests

module load PrgEnv-nvidia

ctest --test-dir build --output-on-failure --verbose


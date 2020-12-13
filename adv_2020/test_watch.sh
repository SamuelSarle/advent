#!/bin/sh

git ls-files **/*.ex* | entr -cdp mix test --stale

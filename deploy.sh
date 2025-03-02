#!/bin/bash

# Script to deploy a Jekyll site to GitHub Pages

# Variables
PUBLIC_REPO="git@github.com:x-pwn3d/x-pwn3d.github.io"  
BUILD_DIR="_site"

echo "🛠️  Building Jekyll site..."
jekyll build

# Check if the build was successful
if [ $? -ne 0 ]; then
  echo "❌ Error: Jekyll build failed."
  exit 1
fi

echo "🚀 Deploying site to GitHub Pages..."

# Going to build directory
cd "$BUILD_DIR"

# Initialize Git if not already done
if [ ! -d ".git" ]; then
  git init
  git remote add origin $PUBLIC_REPO
fi

# Check if the branch "main" exists
if git rev-parse --verify main >/dev/null 2>&1; then
  git checkout main
else
  git checkout -b main
fi

# Adding files
git add .
git commit -m "Deploy: $(date '+%Y-%m-%d %H:%M:%S')"

# Force push to GitHub Pages repository
git push -f origin main

echo "✅ Deployment complete."

# Going back to previous directory
cd ..

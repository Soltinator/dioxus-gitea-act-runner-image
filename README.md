# dioxus-gitea-act-runner-image
dockerfile for an act runner image for gitea to be able to automatically build and package dioxus projects


> replacing the base image in the first line should give you an image based on other systems (ie. github) 
> ```dockerfile
> FROM gitea/runner-images:ubuntu-latest AS setup
> ```


and im planning to write a build script for github to build and deploy the image to dockerhub later.

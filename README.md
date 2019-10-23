my_alpine

Desc: my_alpine for runing develop docker or k8s at the clean execute enviorment.
===
![downloads](https://img.shields.io/github/downloads/atom/atom/total.svg)
![build](https://img.shields.io/appveyor/ci/:user/:repo.svg)
![chat](https://img.shields.io/discord/:serverId.svg)

## Table of Contents

[TOC]

## Setup for enviorment

# Step.1 Configure the variables.env
---
```gherkin=
cp -f variables.env_example variables.env
vim variables.env
```

# Step.2 Run
---
```gherkin=
./start_docker.sh
```

# Step.3 Login
---
```gherkin=
./login_docker.sh
```

# Step.4 Create EKS cluster
---
```gherkin=
./eks_control.sh create
```

# Step.5 Test EKS cluster
---
```gherkin=
./eks_control.sh test
```
## Do what u want to develop

## Clear the old enviorment
# Step.6 Delete EKS cluster
---
```gherkin=
./eks_control.sh delete
```

# --- END --- #

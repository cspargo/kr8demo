This demo uses clusters created using Kubernetes In Docker https://kind.sigs.k8s.io/ (kind version 0.2.0)

setup
```
kind create cluster --name cluster1 --image kindest/node:v1.13.4 
kind create cluster --name cluster2 --image kindest/node:v1.13.4 
kind create cluster --name cluster3 --image kindest/node:v1.13.4 
```

modify the kubconfig files with your username. And set KUBECONFIG

```
for cluster in cluster1 cluster2 cluster3; do sed -i bak -e 's/kubernetes-admin/'$USER'@'$cluster/ -e 's/kubernetes-admin@/'$USER'@/' ~/.kube/kind-config-$cluster; done
export KUBECONFIG="$(kind get kubeconfig-path --name="cluster1"):$(kind get kubeconfig-path --name="cluster2"):$(kind get kubeconfig-path --name="cluster3")"
```

clone the repo, and set KR8_BASE environment variable to the base of the repo

```
cd kr8demo
export KR8_BASE=$PWD
PATH=$PATH:$PWD/bin
```

generate all config

```
task
```

deploy to each cluster

```
task cluster1_deploy
task cluster2_deploy
task cluster3_deploy
```

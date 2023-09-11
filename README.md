# helm-kubectl-oc-node Docker hub image

[![ci](https://github.com/psimona/helm-kubectl-oc-node/actions/workflows/image-build-push.yaml/badge.svg)](https://github.com/psimona/helm-kubectl-oc-node/actions/workflows/image-build-push.yaml)
[![Docker Stars](https://img.shields.io/docker/stars/psimona/helm-kubectl-oc-node.svg?style=flat)](https://hub.docker.com/r/psimona/helm-kubectl-oc-node/)
[![Docker Pulls](https://img.shields.io/docker/pulls/psimona/helm-kubectl-oc-node.svg?style=flat)](https://hub.docker.com/r/psimona/helm-kubectl-oc-node/)

Supported tags and release links

| tag   | helm   | kubectl | oc      | node | yq     | alpine |
|-------|--------|---------|---------|-----|--------|--------|
| 1.0.0 | 3.12.3 | 1.27.4  | 4.13.10 | 18  | 4.34.2 | 3.18.3 |

## Overview

This lightweight alpine docker image provides oc (openshift cli) kubectl, helm binaries for working with a Kubernetes
cluster. A local configured kubectl is a prerequisite to use helm
per [helm documentation](https://github.com/kubernetes/helm/blob/master/docs/quickstart.md). This image is useful for
general helm administration such as deploying helm charts and managing releases. It is also perfect for any automated
deployment pipeline needing to use helm which supports docker images such
as [Concourse CI](https://concourse.ci), [Jenkins on Kubernetes](https://kubeapps.com/charts/stable/jenkins), [Travis CI](https://docs.travis-ci.com/user/docker/),
and [Circle CI](https://circleci.com/integrations/docker/). Having bash installed allows for better support for
troubleshooting by being able to exec / terminal in and run desired shell scripts. Git installed allows installation
of [helm plugins](https://github.com/kubernetes/helm/blob/master/docs/plugins.md).

If it is desired to only use kubectl and have kubectl as the entry command (versus this image as bash entry command), I
recommend checking out this image instead:
[lachlanevenson/kubectl](https://hub.docker.com/r/lachlanevenson/k8s-kubectl/)

If you do not need the openshift cli `oc` tool I recommend the image [dtzar/helm-kubectl](https://hub.docker.com/r/dtzar/helm-kubectl)
from which this repo has been forked.

## Run

Example to just run helm on entry:  
`docker run --rm psimona/helm-kubectl-oc-node helm-node`  
By default, kubectl will try to use /root/.kube/config file for connection to the kubernetes cluster, but does not exist
by default in the image.

Example for use with personal administration or troubleshooting with volume mount for kubeconfig files:  
`docker run -it -v ~/.kube:/root/.kube psimona/helm-kubectl-oc-node`  
The -v maps your host docker machine Kubernetes configuration directory (~/.kube) to the container's Kubernetes
configuration directory (root/.kube).

## Build

For doing a manual local build of the image:  
`make docker_build`

#!/usr/bin/env sh

set -x -eou pipefail

main(){
  OC_VERSION=$1
  TARGETOS=$2
  TARGETARCH=$3

  case "$TARGETARCH" in
    amd64)
      echo "https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${OC_VERSION}/openshift-client-${TARGETOS}.tar.gz"
      ;;
    *)
      echo "https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${OC_VERSION}/openshift-client-${TARGETOS}-${TARGETARCH}.tar.gz"
      ;;
  esac
}

main "$@"
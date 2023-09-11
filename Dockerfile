ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION}

ARG TARGETOS
ARG TARGETARCH

ARG HELM_VERSION
ARG KUBE_VERSION
ARG OC_VERSION
ARG YQ_VERSION

COPY generate-oc-download-url.sh /tmp/generate-oc-download-url.sh

RUN apk -U upgrade \
    && apk add --no-cache gcompat ca-certificates bash git openssh curl gettext jq nodejs npm \
    && wget -q https://get.helm.sh/helm-v${HELM_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz -O - | tar -xzO ${TARGETOS}-${TARGETARCH}/helm > /usr/local/bin/helm \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl -O /usr/local/bin/kubectl \
    && wget -q "$(/tmp/generate-oc-download-url.sh $OC_VERSION $TARGETOS $TARGETARCH)" -O - | tar -xzO oc  > /usr/local/bin/oc \
    && wget -q https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_${TARGETOS}_${TARGETARCH} -O /usr/local/bin/yq \
    && chmod +x /usr/local/bin/helm /usr/local/bin/kubectl /usr/local/bin/yq /usr/local/bin/oc \
    && mkdir /config \
    && chmod g+rwx /config /root \
    && helm repo add "stable" "https://charts.helm.sh/stable" --force-update \
    && helm version \
    && kubectl version --client \
    && oc version --client \
    && yq --version \
    && node --version \
    && npm --version

WORKDIR /config

CMD bash
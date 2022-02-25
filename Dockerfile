FROM alpine:3.15.0

ARG KUBERNETES_VERSION=

# Do NOT update the next line manually, please use ./scripts/update-aws-iam-authenticator.sh instead
ARG AWS_IAM_AUTHENTICATOR_VERSION=v0.4.0

RUN set -x && \
    apk update && \
    apk add --no-cache curl jq && \
    # Download and install kubectl
    [ -z "$KUBERNETES_VERSION" ] && KUBERNETES_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt) ||: && \
    curl -s -LO https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    kubectl version --client && \
    rm -rf /var/cache/apk/* 

RUN mkdir -p /opt/resource
COPY assets/* /opt/resource/

FROM gitlab/gitlab-runner:v18.0.1

# Install kubectl (latest stable)
RUN curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl

# Install Helm (latest release)
RUN HELM_VERSION=$(curl -s https://api.github.com/repos/helm/helm/releases/latest | grep tag_name | cut -d '"' -f4 | sed 's/^v//') && \
    curl -LO "https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz" \
    && tar -xzvf helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -rf linux-amd64 helm-v${HELM_VERSION}-linux-amd64.tar.gz

# Install yq (latest release)
RUN YQ_VERSION=$(curl -s "https://api.github.com/repos/mikefarah/yq/releases/latest" | grep tag_name | cut -d '"' -f4) && \
    wget "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64" -O /usr/local/bin/yq \
    && chmod +x /usr/local/bin/yq

# Install kustomize (latest release)
RUN KUSTOMIZE_VERSION=$(curl -s "https://api.github.com/repos/kubernetes-sigs/kustomize/releases/latest" | grep tag_name | cut -d '"' -f4 | sed 's/^kustomize\///') && \
    curl -LO "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" \
    && tar -xzvf kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
    && mv kustomize /usr/local/bin/ \
    && rm kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz

# Show versions (for debugging)
RUN kubectl version --client && helm version && yq --version && kustomize version
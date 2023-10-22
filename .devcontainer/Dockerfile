ARG JULIA_VARIANT="latest"
FROM julia:${JULIA_VARIANT} as builder

# ARG CUDA_VARIANT="12.1.1-cudnn8-runtime-ubuntu22.04"
# FROM nvidia/cuda:${CUDA_VARIANT}
FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

ARG JULIA_PATH="/usr/local/julia"
COPY --from=builder ${JULIA_PATH} ${JULIA_PATH}
ENV PATH ${JULIA_PATH}/bin:${PATH}

ENV DEBIAN_FRONTEND=noninteractive

# RUN echo "deb https://ppa.launchpadcontent.net/deadsnakes/ppa/ubuntu jammy main" >> /etc/apt/sources.list \
#     && echo "deb-src https://ppa.launchpadcontent.net/deadsnakes/ppa/ubuntu jammy main" >> /etc/apt/sources.list \
RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    curl \
    fish \
    git \
    htop \
    python3.11 \
    python3.11-dev \
    python3.11-venv \
    sudo \
    tmux \
    wget \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

# install poetry
ENV POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1 

RUN curl -sSL https://install.python-poetry.org | python3.11 -

# user
ARG USERNAME="vscode"
ARG USER_UID="1000"
ARG USER_GID=${USER_UID}

RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
    && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

CMD ["/bin/bash"]
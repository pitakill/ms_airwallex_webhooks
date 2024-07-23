# Find eligible builder and runner images on Docker Hub. We use Ubuntu/Debian
# instead of Alpine to avoid DNS resolution issues in production.
#
# https://hub.docker.com/r/hexpm/elixir/tags?page=1&name=ubuntu
# https://hub.docker.com/_/ubuntu?tab=tags
#
# This file is based on these images:
#
#   - https://hub.docker.com/r/hexpm/elixir/tags - for the build image
#   - https://hub.docker.com/_/debian?tab=tags&page=1&name=bullseye-20240701-slim - for the release image
#   - https://pkgs.org/ - resource for finding needed packages
#   - Ex: hexpm/elixir:1.17.1-erlang-27.0-debian-bullseye-20240701-slim
#
ARG ELIXIR_VERSION=1.17.1
ARG OTP_VERSION=27.0
ARG DEBIAN_VERSION=bullseye-20240701-slim

ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"

FROM ${BUILDER_IMAGE}

# Install netcat for healthcheck
RUN apt-get update -y && apt-get install -y netcat && apt-get clean

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Create and set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Copy the entrypoint script into the container at /entrypoint.sh
COPY ./entrypoint.sh /entrypoint.sh

# Give execution rights to the entrypoint script
RUN chmod +x /entrypoint.sh

# Set the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]

# Provide a default command to run when starting the container
CMD ["mix", "phx.server"]

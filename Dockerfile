ARG flux_version=1.19.0
FROM fluxcd/flux:${flux_version}
COPY ./ytt /usr/local/bin/
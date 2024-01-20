# syntax=docker/dockerfile:1
FROM alpine:edge AS base
WORKDIR /root
SHELL ["/bin/sh", "-c"]

RUN apk add git neovim man-pages alpine-sdk zsh curl --update

# install deps needed by neovim
RUN apk add wget gzip neovim-doc ripgrep nodejs npm --update

# pre-download lazy.nvim
RUN git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable /root/.local/share/nvim/lazy/lazy.nvim

COPY nvim .config/nvim

FROM base
SHELL ["/bin/zsh", "-c"]
WORKDIR /root
RUN nvim --headless +"Lazy! sync" +qa
CMD ["/bin/zsh"]

# shodocker

`shodocker` is a Docker image that includes the [`shodo`](https://pypi.org/project/shodo/) package provided by ZenProducts Inc.

## Installation

```bash
$ docker pull nnsnodnb/shodo:latest
```

Or, pull from GitHub Container Registry

```bash
$ docker pull ghcr.io/nnsnodnb/shodo:latest
```

## Usage

[Shodo](https://shodo.ink) account is required to use the `shodo` command.

### Authorization

1. How to pass `SHODO_API_ROOT` and `SHODO_API_TOKEN` as environment variables.
2. Mount the local `~/.config/shodo/credentials` to `/shodo/credentials` in the container.

```bash
$ docker run -it \
  -v ~/.config/shodo/credentials:/shodo/credentials \
  nnsnodnb/shodo:latest lint
```

### Lint Japanese

1. Input japanese

To finish input and request proofreading, press `Ctrl + Z` on Windows or `Ctrl + D` on Mac and Linux.

```bash
$ docker run -it \
  -e SHODO_API_ROOT=my-shodo-api-root \
  -e SHODO_API_TOKEN=my-shodo-api-token \
  nnsnodnb/shodo:latest lint
飛行機の欠便があり、運行状況が変わった。 # Your input text
Linting...
39:11 もしかして：変換ミス
     飛行機の欠便があり、運行（→ 運航）状況が変わった。
```

2. Input file

Mount the text file under the `/shodo` directory and specify the file after the `lint` command.

```bash
$ docker run -t \
  -e SHODO_API_ROOT=my-shodo-api-root \
  -e SHODO_API_TOKEN=my-shodo-api-token \
  -v $(pwd)/README.md:/shodo/README.md \
  nnsnodnb/shodo:latest lint /shodo/README.md
Linting...
39:11 もしかして：変換ミス
     飛行機の欠便があり、運行（→ 運航）状況が変わった。
```

### Download files

Specify the directory where you want to save the downloaded files.  
Unless otherwise specified, files will be downloaded to `/shodo/docs` in the container.

```bash
$ docker run \
  -e SHODO_API_ROOT=my-shodo-api-root \
  -e SHODO_API_TOKEN=my-shodo-api-token \
  -v $(pwd):/shodo/docs \
  nnsnodnb/shodo:latest download
```

## License

This software is licensed under the MIT License. (See [LICENSE](./LICENSE))

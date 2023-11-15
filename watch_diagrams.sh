#!/bin/bash
# docker run -p 8001:8000 -d yuzutech/kroki
if [ ! -f "~/.local/bin/watchexec" ]; then
    curl -sS https://webinstall.dev/watchexec | bash
fi
export PATH=$PATH:~/.local/bin
watchexec --exts ".dsl" -- docker run -it --rm -v $(pwd):/usr/local/structurizr structurizr/cli export --workspace diagrams/system_context/global_arch.dsl --output docs/diagrams/export/ -f plantuml
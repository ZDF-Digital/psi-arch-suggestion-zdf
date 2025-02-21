#!/usr/bin/env fish

# Check if watchexec is installed
if not test -f ~/.local/bin/watchexec
    curl -sS https://webinstall.dev/watchexec | bash
end

# Add watchexec to the PATH
set -x PATH $PATH ~/.local/bin

# Run watchexec with the specified parameters
watchexec --exts ".dsl" -- docker run -t --rm -v $(pwd):/usr/local/structurizr structurizr/cli export --workspace diagrams/system_context/global_arch.dsl --output docs/diagrams/export/ -f plantuml

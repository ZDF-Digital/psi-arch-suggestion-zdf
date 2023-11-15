# How to setup this project locally

## General setup
### Setup venv
```
python -m venv .venv
source .venv/bin/activate.<your_shell>
```

### Setup packages
```
pip install -r requirements.txt
```

### Make sure you have plantuml installed
```
yay -Sy plantuml
```

### Run mkdocs
```
mkdocs serve
```

### Watch the diagrams
```
bash watch_diagrams.sh
```
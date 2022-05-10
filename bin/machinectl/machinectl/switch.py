import typer
import subprocess

app = typer.Typer()


@app.command(help="OS rebuild and switch configuration")
def switch():
    subprocess.run("sudo nixos-rebuild switch --flake path:.#define7")

    link = subprocess.run(
        "nix build './#darwinConfigurations.LF2107010038.system' --no-out-link"
    )
    switch = "{link}/bin/darwin-rebuild switch --flake ./".format(link=link)
    subprocess.run(switch)

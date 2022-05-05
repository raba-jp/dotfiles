import typer
import subprocess

app = typer.Typer()


@app.command(help="OS rebuild and switch configuration")
def switch():
    subprocess.run("sudo nixos-rebuild switch --flake path:.#define7")

    subprocess.run("nix build './#darwinConfigurations.LF2107010038.system'")
    subprocess.run("./result/sw/bin/darwin-rebuild switch --flake ./")

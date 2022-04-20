import typer

app = typer.Typer()


@app.command(
    help="builds an initial configuration",
)
def bootstrap():
    return


if __name__ == "__main__":
    app()

import typer

import benchmark

app = typer.Typer()
app.add_typer(benchmark.app, name="benchmark")


@app.command(
    help="builds an initial configuration",
)
def bootstrap():
    return


if __name__ == "__main__":
    app()

import typer
from machinectl import benchmark

app = typer.Typer()
app.add_typer(benchmark.app, name="benchmark")


@app.command(
    help="builds an initial configuration",
)
def bootstrap():
    return


def main():
    app()


if __name__ == "__main__":
    main()

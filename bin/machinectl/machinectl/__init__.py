import typer
from machinectl import benchmark as bm

app = typer.Typer()


@app.command(help="builds an initial configuration")
def bootstrap():
    return


@app.command(help="run benchmark")
def benchmark():
    bm.run()


def main():
    app()


if __name__ == "__main__":
    main()

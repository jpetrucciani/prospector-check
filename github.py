"""
quick script to write prospector errors to github comments
"""
import json
import sys


def error(
    file: str, line: int = 0, col: int = 0, message: str = "error", warn: bool = False
) -> None:
    """write an error to stdout"""
    kind = "warning" if warn else "error"
    print(f"::{kind} file={file},line={line},col={col}::{message}")


def main(file_path: str) -> None:
    """read the given file, and print errors"""
    data = {}
    with open(file_path, "r") as file:
        data = json.loads(file.read())

    for msg in data["messages"]:
        loc = msg["location"]
        error_message = "prospector[{}:{}]: {}".format(
            msg["source"], msg["code"], msg["message"]
        )
        error(
            loc["path"], line=loc["line"], col=loc["character"], message=error_message,
        )


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("you must specify a json file path!")
        sys.exit(1)
    file_path = sys.argv[1]
    main(file_path)

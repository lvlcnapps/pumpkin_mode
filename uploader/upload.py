import os
import sys
import argparse
import zipfile
import tempfile
from pathlib import Path
from exaroton_expanded.exaroton_expanded import *

token = ""

with open("token.secret", "r") as file:
    token = file.read().strip()

with open("serverid", "r") as file:
    SERVER_ID = file.read().strip()

exa = Exaroton(token)
DATAPACKS_PATH = "world/datapacks"


def upload_as_zip(local_folder: Path, verbose: bool = False):
    """Pack the folder into a zip and upload it as a single file."""
    folder_name = local_folder.name
    server_zip_path = f"{DATAPACKS_PATH}/{folder_name}.zip"
    print(f"Uploading '{folder_name}' as zip → {server_zip_path}")

    with tempfile.NamedTemporaryFile(suffix='.zip', delete=False) as tmp:
        temp_zip_path = tmp.name

    try:
        with zipfile.ZipFile(temp_zip_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
            for root, dirs, files in os.walk(local_folder):
                for file in files:
                    file_path = Path(root) / file
                    zipf.write(file_path, file_path.relative_to(local_folder))

        with open(temp_zip_path, 'rb') as f:
            response = exa.write_file_data(id=SERVER_ID, path=server_zip_path, data=f.read())
            if verbose:
                print(f"  API response: {response}")

        print(f"Done: {server_zip_path}")
    finally:
        if os.path.exists(temp_zip_path):
            os.unlink(temp_zip_path)


def upload_as_folder(local_folder: Path, verbose: bool = False):
    """Traverse the folder recursively and upload each file individually."""
    folder_name = local_folder.name
    base_path = f"{DATAPACKS_PATH}/{folder_name}"
    print(f"Uploading '{folder_name}' as folder → {base_path}/")

    all_files = [p for p in local_folder.rglob('*') if p.is_file()]
    total = len(all_files)

    # Collect all unique directories that need to exist
    dirs_to_create = {base_path}
    for file_path in all_files:
        parts = file_path.relative_to(local_folder).parent.parts
        for i in range(len(parts)):
            dirs_to_create.add(f"{base_path}/{'/'.join(parts[:i+1])}")

    # Create directories first (sorted so parents come before children)
    for dir_path in sorted(dirs_to_create):
        print(f"  mkdir {dir_path}")
        response = exa.create_directory(id=SERVER_ID, path=dir_path)
        if verbose:
            print(f"    API response: {response}")

    # Upload files
    for i, file_path in enumerate(all_files, 1):
        relative_path = file_path.relative_to(local_folder)
        server_path = f"{base_path}/{relative_path}"
        print(f"  [{i}/{total}] {relative_path}")
        with open(file_path, 'rb') as f:
            response = exa.write_file_data(id=SERVER_ID, path=server_path, data=f.read())
            if verbose:
                print(f"    API response: {response}")

    print(f"Done: uploaded {total} file(s).")


def main():
    parser = argparse.ArgumentParser(description="Upload a datapack folder to exaroton server.")
    parser.add_argument("folder", help="Path to the local datapack folder")
    parser.add_argument("--folder", dest="as_folder", action="store_true",
                        help="Upload files individually instead of as a zip archive")
    parser.add_argument("-v", "--verbose", action="store_true",
                        help="Print API call outputs")
    args = parser.parse_args()

    local_folder = Path(args.folder)

    if not local_folder.exists():
        print(f"Error: path does not exist: {local_folder}")
        sys.exit(1)
    if not local_folder.is_dir():
        print(f"Error: not a directory: {local_folder}")
        sys.exit(1)

    try:
        if args.as_folder:
            upload_as_folder(local_folder, verbose=args.verbose)
        else:
            upload_as_zip(local_folder, verbose=args.verbose)
        print("Upload completed successfully!")
    except Exception as e:
        print(f"Error during upload: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
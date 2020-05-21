import sys
import argparse
import tarfile
import os


def extract_all(archives, extract_path):

    tf = tarfile.open(archives)
    tf.extractall(extract_path)

    if os.path.exists(archives):
        os.remove(archives)


def main():
    parser = argparse.ArgumentParser(
        description="extract python src tar.xz"
    )

    parser.add_argument("--file", dest="filename", help="archive filename")
    parser.add_argument("--dest", dest="extract_path", help="extract destination")
    args = parser.parse_args()


    extract_all(args.filename, args.extract_path)
    

if __name__ == "__main__":
    sys.exit(main())
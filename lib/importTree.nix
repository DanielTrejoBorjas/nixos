# Every .nix file under `dir`, so a new module is picked up by just adding the file.
lib: dir: lib.filter (lib.hasSuffix ".nix") (lib.filesystem.listFilesRecursive dir)

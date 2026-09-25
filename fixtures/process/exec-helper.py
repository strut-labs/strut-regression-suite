import os
from pathlib import Path
import sys

if len(sys.argv) > 1 and sys.argv[1] == "inherit":
    print("inherited")
    raise SystemExit(0)

print(sys.argv[1] + "|" + sys.argv[2])
print(os.environ.get("STRUT_CHILD_ENV", "missing"))
print(Path.cwd().resolve() == Path(os.environ["EXPECTED_CWD"]).resolve())
print("helper-error", file=sys.stderr)
raise SystemExit(7)

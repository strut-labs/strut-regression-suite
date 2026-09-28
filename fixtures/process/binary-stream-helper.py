import sys

sys.stdout.buffer.write(sys.stdin.buffer.read())
sys.stdout.buffer.flush()

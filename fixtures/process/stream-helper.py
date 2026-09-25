import sys
line=sys.stdin.readline().rstrip('\n')
print('OUT:'+line)
print('ERR:'+line, file=sys.stderr)

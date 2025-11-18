import hashlib
import binascii

# Extracted from your hash file
full_hash = "$pbkdf2-sha256$600000$AMtzteQIG7yAbZIa$0673ad90a0b4afb19d662336f0fce3a9edd0b7b19193717be28ce4d66c887133"

# Parse fields
_, alg, iterations, salt, hashval = full_hash.split('$')
iterations = int(iterations)
salt = salt.encode()
target_hash = bytes.fromhex(hashval)

# Path to wordlist
wordlist = "/usr/share/wordlists/rockyou.txt"

with open(wordlist, "r", encoding="utf-8", errors="ignore") as f:
    for line in f:
        password = line.strip().encode()
        derived_key = hashlib.pbkdf2_hmac('sha256', password, salt, iterations)
        if derived_key == target_hash:
            print(f"[+] Password found: {password.decode()}")
            break
    else:
        print("[-] Password not found.")

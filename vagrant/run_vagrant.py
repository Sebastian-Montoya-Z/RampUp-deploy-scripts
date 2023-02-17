import vagrant

v = vagrant.Vagrant(quiet_stdout=False)

try:
    v.up("todos")
except Exception as e:
    print(e)

try:
    v.up("auth")
except Exception as e:
    print(e)

try:
    v.up("web")
except Exception as e:
    print(e)

print(v.status())
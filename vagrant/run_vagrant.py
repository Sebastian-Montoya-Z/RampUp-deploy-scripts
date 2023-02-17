import vagrant

v = vagrant.Vagrant(quiet_stdout=False)

try:
    v.up("todos")
except:
    print("temamaste todos")

try:
    v.up("auth")
except:
    print("temamaste auth")

try:
    v.up("web")
except:
    print("temamaste web")

print(v.status())
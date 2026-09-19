#!/usr/bin/env python3
import json,pathlib,subprocess
root=pathlib.Path(__file__).resolve().parent
cases=[("summary",["-i","payload=chapters/01-a-functional-language/order.json","-f","chapters/01-a-functional-language/02_summary.dwl"],"chapters/01-a-functional-language/02_summary.out"),("capstone",["-i","payload=chapters/16-a-real-transform/feed.xml","--path=chapters/16-a-real-transform","-f","chapters/16-a-real-transform/04_final.dwl"],"chapters/16-a-real-transform/04_final.out")]
for name,args,golden in cases:
    result=subprocess.run([str(root/"dw.sh"),"run","-s",*args],capture_output=True,text=True,cwd=root)
    assert result.returncode==0,(name,result.stderr)
    expected=(root/golden).read_text().rsplit("exit=",1)[0].strip()
    assert json.loads(result.stdout)==json.loads(expected),(name,result.stdout)
    print("PASS",name)
print("Two complete application golden checks passed; chapter experiments remain independently runnable.")

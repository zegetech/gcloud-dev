echo '#! /bin/sh'                >> /bin/k
echo 'kubectl $@' >> /bin/k
chmod u+x /bin/k


echo '#! /bin/sh'                >> /bin/ka
echo 'kubectl apply -f $@' >> /bin/ka
chmod u+x /bin/ka


echo '#! /bin/sh'                >> /bin/kg
echo 'kubectl get $@' >> /bin/kg
chmod u+x /bin/kg


echo '#! /bin/sh'                >> /bin/kgn
echo 'kubectl get nodes' >> /bin/kgn
chmod u+x /bin/kgn


echo '#! /bin/sh'                >> /bin/kgnw
echo 'kubectl get nodes -o wide' >> /bin/kgnw
chmod u+x /bin/kgnw


echo '#! /bin/sh'                >> /bin/kgnl
echo 'kubectl get nodes --show-labels' >> /bin/kgnl
chmod u+x /bin/kgnl


echo '#! /bin/sh'                >> /bin/kgp
echo 'kubectl get pods' >> /bin/kgp
chmod u+x /bin/kgp


echo '#! /bin/sh'                >> /bin/kgs
echo 'kubectl get svc' >> /bin/kgs
chmod u+x /bin/kgs


echo '#! /bin/sh'                >> /bin/kgd
echo 'kubectl get deployments' >> /bin/kgd
chmod u+x /bin/kgd


echo '#! /bin/sh'                >> /bin/kcf
echo 'kubectl create -f ' >> /bin/kcf
chmod u+x /bin/kcf


echo '#! /bin/sh'                >> /bin/kd
echo 'kubectl delete $@' >> /bin/kd
chmod u+x /bin/kd

echo '#! /bin/sh'                >> /bin/kdes
echo 'kubectl describe $@' >> /bin/kdes
chmod u+x /bin/kdes


echo '#! /bin/sh'                >> /bin/kdf
echo 'kubectl delete -f $@' >> /bin/kdf
chmod u+x /bin/kdf


echo '#! /bin/sh'                >> /bin/kaf
echo 'kubectl apply -f $@' >> /bin/kaf
chmod u+x /bin/kaf


echo '#! /bin/sh'                >> /bin/kgpa
echo 'kubectl get pods --all-namespaces' >> /bin/kgpa
chmod u+x /bin/kgpa


echo '#! /bin/sh'                >> /bin/kssh
echo 'kubectl exec -it $@ -- /bin/sh ' >> /bin/kssh
chmod u+x /bin/kssh

echo '#! /bin/sh'                >> /bin/kbash
echo 'kubectl exec -it $@ -- /bin/bash ' >> /bin/kbash
chmod u+x /bin/kbash


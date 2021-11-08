#!/usr/bin/fish

function kubedel -d "delete pods in the namespace"
    argparse --name=kubedel 'h/help' 'n/namespace=' 'p/pod=' -- $argv
    or return

    set -l namespace $_flag_namespace
    set -l pod $_flag_pod
    if test -z "$namespace"
        set namespace $K8S_NAMESPACE
    end

    if test -z "$namespace"
        echo "missing flag -n or env K8S_NAMESPACE"
        return
    end

    if test -z "$pod"
        echo "missing flag -p"
        return
    end

    kubectl get pods -n $namespace | ag $pod | cut -d " " -f 1 | xargs kubectl delete pods -n $namespace
end

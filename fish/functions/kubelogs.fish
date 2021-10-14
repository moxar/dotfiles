function kubelogs -d "display the logs of the pod in the namespace"
    set -l options (fish_opt -s p -l pod --required-val)
    set options $options (fish_opt -s n -l namespace --required-val)
    argparse $options -- $argv
    kubectl get pods -n $_flag_namespace | ag $_flag_pod | cut -d " " -f 1 | xargs kubectl logs -f -n $_flag_namespace
end

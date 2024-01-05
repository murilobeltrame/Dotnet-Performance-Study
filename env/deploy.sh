if [ -z "$1" ]; then
    echo "Resource Group Name is empty"
else 

    # VARIABLES
    aksClusterName="aks$1"
    location='westus2'
    kubernetesVersion='1.28'

    nodePoolNameAmd='amdpool'
    nodePoolSizeAmd='Standard_D2as_v5' # AMD EPYC 7763v, 8 GiB RAM (can be Intel Xeon)
    nodePoolNameArm='armpool'
    nodepoolSizeArm='Standard_D2ps_v5' # Ampere Altra, 8GiB RAM

    # CREATE RG
    az group create --name $1 --location $location

    # CREATE AKS CLUSTER
    az aks create \
        --resource-group $1 \
        --name $aksClusterName \
        --location $location \
        --generate-ssh-keys \
        --kubernetes-version $kubernetesVersion \
        --nodepool-name $nodePoolNameArm \
        --node-vm-size $nodepoolSizeArm \
        --node-count 1 

    az aks nodepool add \
        --resource-group $1 \
        --cluster-name $aksClusterName \
        --name $nodePoolNameAmd \
        --node-vm-size $nodePoolSizeAmd \
        --node-count 1 \

    # UPDATE .kubeconfig
    az aks get-credentials --resource-group $1 --name $aksClusterName

fi
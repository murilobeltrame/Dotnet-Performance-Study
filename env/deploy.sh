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

    sqlServerName="sql$1"
    sqlServerDataBaseName6="Todo6"
    sqlServerDataBaseName7="Todo7"
    sqlServerDataBaseName8="Todo8"

    # CREATE RG
    az group create --name $1 --location $location

    ## CREATE A KV
    az keyvault create \
        -n "kv$1" \
        -g $1 \
        -l $location \
        --enable-rbac-authorization

    # CREATE AKS CLUSTER
    az aks create \
        --resource-group $1 \
        --name $aksClusterName \
        --location $location \
        --enable-addons azure-keyvault-secrets-provider \
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

    # CREATE DB SERVER
    az sql server create \
        --resource-group $1 \
        --name $sqlServerName \
        --admin-user $SQL_ADMIN_USR \
        --admin-password $SQL_ADMIN_PWD \
        --location $location

    # CREATE DATABASES
    az sql db create \
        --resource-group $1 \
        --server $sqlServerName \
        --name $sqlServerDataBaseName6 \
        --edition Hyperscale \
        --compute-model Serverless \
        --family Gen5 \
        --capacity 2

    az sql db create \
        --resource-group $1 \
        --server $sqlServerName \
        --name $sqlServerDataBaseName7 \
        --edition Hyperscale \
        --compute-model Serverless \
        --family Gen5 \
        --capacity 2

    az sql db create \
        --resource-group $1 \
        --server $sqlServerName \
        --name $sqlServerDataBaseName8 \
        --edition Hyperscale \
        --compute-model Serverless \
        --family Gen5 \
        --capacity 2
fi
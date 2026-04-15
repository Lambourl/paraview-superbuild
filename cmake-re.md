
```bash
docker run -it nilurova68440/tipi-ubuntu2404-paraview-superbuild@sha256:e509721dffe5015aacd2024cebea9a587e4976320ba8d982be6448e26b7c37ca /bin/bash
git clone https://github.com/Lambourl/paraview-superbuild && cd paraview-superbuild
git submodule init
git submodule update
export TIPI_DISABLE_AR_RANLIB_DRIVER=ON 
export TIPI_CACHE_CONSUME_ONLY=ON 
export TIPI_CACHE_FORCE_ENABLE=OFF
cmake-re -S . -B ./build -DCMAKE_TOOLCHAIN_FILE=toolchains/environments/linux.cmake --host -vvv -j24
cmake-re --build ./build --host -vvv -j24
```

```bash
docker run -v <path-to-engflow-creds>:/home/tipi/engflow-mTLS -it nilurova68440/tipi-ubuntu2404-paraview-superbuild@sha256:e509721dffe5015aacd2024cebea9a587e4976320ba8d982be6448e26b7c37ca /bin/bash
git clone https://github.com/Lambourl/paraview-superbuild && cd paraview-superbuild
git submodule init
git submodule update
export RBE_service="<cluster>:443"
export RBE_tls_client_auth_key=/home/tipi/engflow-mTLS/engflow.key
export RBE_tls_client_auth_cert=/home/tipi/engflow-mTLS/engflow.crt
export TIPI_DISABLE_AR_RANLIB_DRIVER=ON 
export TIPI_CACHE_CONSUME_ONLY=ON 
export TIPI_CACHE_FORCE_ENABLE=OFF

#If you want to use the local machine for the builds too, you can specify the
# following 3 variables (will use 30% of local CPUs):
export RBE_local_resource_fraction="0.3"
export RBE_exec_strategy="racing"
export RBE_racing_bias="5"
cmake-re -S . -B ./build -DCMAKE_TOOLCHAIN_FILE=toolchains/environments/linux.cmake --host -vvv  --distributed
cmake-re --build ./build --host --distributed -vvv -j500
```


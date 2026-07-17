# To load into local Docker daemon (Single platform only)
docker buildx build --platform linux/amd64 -t aura-ecosystem:fadk-s4xv --load .
# Test just AMD64
docker buildx build --platform linux/amd64 -t test-build .
# Triggers dependencies verification, updates the Go proxy layers, and compiles daemon targets
make all

# Executes integration suites validating internal sandboxing structures
make test

# Installs the generated engine binaries into standard Unix /usr/bin runtime paths
make install

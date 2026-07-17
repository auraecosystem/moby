# To load into local Docker daemon (Single platform only)
docker buildx build --platform linux/amd64 -t aura-ecosystem:fadk-s4xv --load .
# Test just AMD64
docker buildx build --platform linux/amd64 -t test-build .

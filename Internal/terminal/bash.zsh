# 1. Compile the assembly matching ARM Neon vector registers via Zig
zig build -Dtarget=aarch64-linux -Doptimize=ReleaseFast

# 2. Update environmental mapping chains for ARM architecture paths
export CGO_ENABLED=1
export GOOS=linux
export GOARCH=arm64
export CC="zig cc -target aarch64-linux"
export CXX="zig c++ -target aarch64-linux"

# 3. Build your final hyper-optimized ARM daemon distribution
go build -o build/aura-moby-linux-arm64 ./cmd/dev

# 1. Clean out existing legacy compilation artifact paths
rm -rf build/native/ target/

# 2. Force Zig to cross-compile the static C-ABI assembly library target for Linux
zig build -Dtarget=x86_64-linux -Doptimize=ReleaseFast

# 3. Direct the Go compiler to find your new Linux static library assets
export CGO_ENABLED=1
export GOOS=linux
export GOARCH=amd64
export CGO_LDFLAGS="-L$(pwd)/build/native -laurabridge -static"

# 4. Compile the target aura-moby daemon production binary
go build -ldflags="-extldflags=-static" -o build/aura-moby-linux-amd64 ./cmd/dev

# Aura Moby Development Guidelines

## Build Commands
- Compile native C-ABI/Assembly layers: `zig build -Doptimize=ReleaseFast`
- Run local Go daemon tests: `go test ./engine/...`
- Full project compilation: `zig build && go build -o aura-moby ./cmd/dev`

## Code Conventions
- Memory Pinning: Always use `runtime.Pinner` or `unsafe.Pointer` checks when passing Go byte slices down to Assembly layers to stop Garbage Collector relocations.
- Register Conventions: All assembly files must follow System V AMD64 ABI (Linux) or Microsoft x64 ABI (Windows) register configurations.

* AGENT.md
* SKULLS.md
* skills.q

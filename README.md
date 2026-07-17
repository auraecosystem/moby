# S4x
```svg
                    +-----------------------+
                    | CLI / API Clients     |
                    +-----------+-----------+
                                |
                        REST / gRPC API
                                |
                    +-----------v-----------+
                    |     API Server        |
                    +-----------+-----------+
                                |
          +---------------------+----------------------+
          |                     |                      |
          v                     v                      v
 +----------------+    +----------------+    +----------------+
 | Container Mgmt |    | Image Manager  |    | Volume Manager |
 +----------------+    +----------------+    +----------------+
          |                     |                      |
          +----------+----------+----------------------+
                     |
              +------v------+
              | Daemon Core |
              +------+------+
                     |
      +--------------+--------------+
      |              |              |
      v              v              v
 Containerd     BuildKit      Network Stack
      |              |              |
      +--------------+--------------+
                     |
                OCI Runtime
                 (runc/crun)
                     |
               Linux Kernel



Aura Moby
│
├── api/
├── engine/
├── build/
│   ├── buildkit/
│   ├── aura-builder/
│   └── build.sock
├── runtime/
├── networking/
├── storage/
├── security/
│   ├── policy/
│   ├── attestations/
│   └── sandbox/
├── plugins/
├── web4/
├── paperweb/
├── qubuhub/
├── ai/
│   ├── scheduler/
│   ├── optimizer/
│   └── telemetry/
└── cli/

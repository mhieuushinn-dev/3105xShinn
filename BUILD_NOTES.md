# Build notes

This branch is a safe UI-only build preparation.

- Kernel exploit and native privilege-escalation sources are excluded.
- `KernelExploit` and `ContainerStore` are non-functional stubs.
- GitHub Actions creates an unsigned IPA artifact when compilation succeeds.
- An unsigned IPA still requires a legitimate signing/install method; it is not directly installable on a normal iPhone.

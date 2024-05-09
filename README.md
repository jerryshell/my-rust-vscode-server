# My Rust VSCode Server

```bash
docker build . -t my-rust-vscode-server
```

```bash
docker run -d -p 2222:22 my-rust-vscode-server
```

```
vscode://vscode-remote/ssh-remote+root@HOST:2222/root
```

Password: `123456`

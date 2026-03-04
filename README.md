# 🦞 Claw Sandbox (SBX)

A secure, isolated development environment for **OpenClaw**, running on **Debian Slim** with **Node.js 24 (LTS)** and a non-root security profile.

## 🛠 Features

* **Base OS:** Debian Stable (Slim)
* **Node.js:** v24.14.0 (Krypton LTS) managed via NVM
* **User:** `claw` (non-root) for safe agent execution
* **Persistence:** Local data volume for settings and history

---

## 🚀 Quick Start

### 1. Build the Image

From the root of your `claw-sbx` directory, run:

```bash
docker build -t claw_sbx .
```

### 2. Launch the Container

To ensure your onboarding progress and API keys are saved, use a volume mount:

```bash
mkdir -p ./data
docker run -it \
  -v ./data:/home/claw/.openclaw \
  --name openclaw-instance \
  claw_sbx
```

### 3. Start Onboarding

Once inside the container shell, simply run:

```bash
openclaw onboard
```

---

## 📂 Project Structure

```text
.
├── Dockerfile      # Secure build instructions
├── README.md       # You are here
└── data/           # PERSISTENT: OpenClaw configs, keys, and logs (Local)

```

---

## 🔒 Security Best Practices

* **Isolated Filesystem:** OpenClaw only has access to the container filesystem and the mapped `./data` folder.
* **Non-Root User:** The agent runs as user `claw`. It cannot modify system binaries or escape to your host machine.
* **Audit Regularly:** Inside the container, run `openclaw security audit --deep` to check for prompt injection vulnerabilities in your enabled tools.

---

## 🛠 Troubleshooting

**Command not found?**
Ensure you are using the `claw_sbx` image. The `PATH` is pre-configured to find the NVM-installed binaries.

**Permission Denied on Host?**
Files created by the agent in `./data` are owned by the container user. If you need to edit them on your host, you may need to run `sudo chown -R $USER:$USER ./data`.

---

> *"If it's repetitive, I'll automate it; if it's hard, I'll bring jokes and a rollback plan."* — 🦞


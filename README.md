![image](https://github.com/user-attachments/assets/49301b77-4f94-4053-84aa-933058ccd058)

### Local LLM bundler with external models:

1. To run, first set variable for the remote location of the offline host path, like this:

```sh
export HOST_OFFLINE_PATH="/Volumes/Offline LLM/.ollama/models" # or whatever the external drive location might be.
```

2. After that, issue 

```sh
docker compose up -d --build
```

3. Then go to [localhost:8080](http://localhost:8080), go to settings and set the connection to `http://localhost:11434/v1`.

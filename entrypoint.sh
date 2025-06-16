#!/usr/bin/env bash
set -e

OLLAMA_HOME="/root/.ollama"
MODELS_DIR="${OLLAMA_HOME}/models"

if [[ -n "${OFFLINE_MODELS_PATH}" ]]; then
  if [[ ! -d "${OFFLINE_MODELS_PATH}" ]]; then
    echo "Warning: OFFLINE_MODELS_PATH='${OFFLINE_MODELS_PATH}' does not exist or is not a directory."
  else
    mkdir -p "${OLLAMA_HOME}"
    if [[ -e "${MODELS_DIR}" ]]; then
      rm -rf "${MODELS_DIR}"
    fi
    ln -s "${OFFLINE_MODELS_PATH}" "${MODELS_DIR}"
    echo "Created symlink: ${MODELS_DIR} -> ${OFFLINE_MODELS_PATH}"
  fi
fi

echo "Starting Ollama server"
ollama serve &
SERVE_PID=$!

echo "Waiting for Ollama server to be active"
timeout=60
interval=1
elapsed=0
while ! ollama list | grep -q 'NAME'; do
  sleep ${interval}
  elapsed=$((elapsed + interval))
  if [[ ${elapsed} -ge ${timeout} ]]; then
    echo "Error: Ollama server did not become active within ${timeout}s." >&2
    exit 1
  fi
done
echo "Ollama server is active."

wait ${SERVE_PID}


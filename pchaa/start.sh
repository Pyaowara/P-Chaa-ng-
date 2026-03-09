#!/bin/bash

# Start P-Chaa-ng Backend and Frontend in separate terminals

# Get the absolute path to the project directory
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Getting dependencies for pchaa_client..."
cd "$PROJECT_DIR/pchaa_client" && dart pub get

echo "Getting dependencies for pchaa_server..."
cd "$PROJECT_DIR/pchaa_server" && dart pub get

echo "Getting dependencies for pchaa_flutter..."
cd "$PROJECT_DIR/pchaa_flutter" && flutter pub get

echo "Generating Serverpod code..."
cd "$PROJECT_DIR/pchaa_server" && serverpod generate

echo "Starting Docker Compose (Database & Redis)..."
gnome-terminal -- bash -c "cd '$PROJECT_DIR/pchaa_server' && docker compose up; exec bash"

echo "Waiting for Docker services to initialize..."
sleep 5

echo "Starting P-Chaa-ng Backend and Frontend in separate terminals..."

# Start backend server in new terminal
echo "Opening backend terminal..."
gnome-terminal -- bash -c "cd '$PROJECT_DIR/pchaa_server' && echo 'Applying migrations...' && dart bin/main.dart --apply-migrations && echo 'Starting backend server...' && dart bin/main.dart; exec bash"

# Wait a moment for backend to initialize
sleep 3

# Start frontend in new terminal
echo "Opening frontend terminal..."
gnome-terminal -- bash -c "cd '$PROJECT_DIR/pchaa_flutter' && echo 'Starting Flutter app...' && flutter run; exec bash"

echo ""
echo "Backend and Frontend terminals opened!"
echo "Use 'r' for hot reload and 'R' for hot restart in the Flutter terminal"
echo "Close the terminal windows or press Ctrl+C in them to stop"

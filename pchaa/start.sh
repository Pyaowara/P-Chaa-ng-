#!/bin/bash

# Start P-Chaa-ng Backend and Frontend in separate terminals

echo "Starting P-Chaa-ng Backend and Frontend in separate terminals..."

# Get the absolute path to the project directory
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Start backend server in new terminal
echo "Opening backend terminal..."
gnome-terminal -- bash -c "cd '$PROJECT_DIR/pchaa_server' && echo 'Starting backend server...' && dart bin/main.dart; exec bash"

# Wait a moment for backend to initialize
sleep 2

# Start frontend in new terminal
echo "Opening frontend terminal..."
gnome-terminal -- bash -c "cd '$PROJECT_DIR/pchaa_flutter' && echo 'Starting Flutter app...' && flutter run; exec bash"

echo ""
echo "Backend and Frontend terminals opened!"
echo "Use 'r' for hot reload and 'R' for hot restart in the Flutter terminal"
echo "Close the terminal windows or press Ctrl+C in them to stop"

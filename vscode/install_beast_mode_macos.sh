#!/bin/zsh

# Get the dotfiles root directory
DOTFILES=$(realpath "$(dirname "$0")/..")

# Define paths
BEAST_MODE_FILE="$DOTFILES/vscode/beastmode.agent.md"
SETTINGS_FILE="$DOTFILES/vscode/settings.json"

# Download the Beast Mode agent file
curl -o "$BEAST_MODE_FILE" "https://gist.githubusercontent.com/burkeholland/88af0249c4b6aff3820bf37898c8bacf/raw/e1898331f1755aff3265d50e30106b8c6987c4f7/beastmode3.2.chatmode.md"

# Update settings.json with recommended Beast Mode settings
python3 -c "
import json
import os
settings_file = '$SETTINGS_FILE'
with open(settings_file) as f:
    settings = json.load(f)
settings['chat.tools.autoApprove'] = True
settings['chat.agent.maxRequests'] = 100
with open(settings_file, 'w') as f:
    json.dump(settings, f, indent=4)
"

echo "Beast Mode installed:"
echo "- Agent file downloaded to: $BEAST_MODE_FILE"
echo "- Settings updated in: $SETTINGS_FILE"
echo ""
echo "To use Beast Mode:"
echo "1. Copy $BEAST_MODE_FILE to .github/agents/beastmode.agent.md in your project workspace"
echo "2. Restart VSCode or reload the window"
echo "3. Select 'Beast Mode' from the agent dropdown in the chat sidebar"
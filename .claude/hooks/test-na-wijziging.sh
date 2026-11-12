#!/bin/sh
# PostToolUse hook: after a change in src/, run the program headless in the
# Electron emulator and tell Claude where the screenshot is.

file=$(jq -r '.tool_input.file_path // empty')
case "$file" in
  "$CLAUDE_PROJECT_DIR"/src/*) ;;
  *) exit 0 ;;
esac

if ! output=$(make -C "$CLAUDE_PROJECT_DIR" test 2>&1); then
  echo "make test failed:" >&2
  echo "$output" >&2
  exit 2
fi

jq -n '{hookSpecificOutput: {hookEventName: "PostToolUse",
  additionalContext: "The program ran in the Electron emulator. Look at build/screen.png to check the result."}}'

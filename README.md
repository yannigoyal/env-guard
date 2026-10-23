# env-guard


Stops Claude Code from reading your `.env` files, and checks whether any
`.env` files are tracked by git in your project.


## What it does


- **Hook (PreToolUse on Read and Bash):** before Claude reads a file or runs
 a shell command, `scripts/block-env.sh` checks whether it mentions a `.env`
 file. If it does, the action is blocked and Claude is told why.
 `.env.example`, `.env.sample` and `.env.template` are allowed.
- **Skill (`/env-guard:env-check`):** runs `git ls-files` and reports any
 tracked `.env` files, with steps to untrack them.


## What it does NOT do


- No network access. Nothing is sent anywhere.
- Never reads, logs or stores the contents of your `.env` files.
- Never changes `settings.json` or your permissions.
- Downloads and installs nothing.


## Requirements


`jq` must be installed. If it isn't, the hook prints a warning and does not
block anything.


## Limitations


This is a guardrail against accidental reads, not a security boundary.
A determined user or a cleverly encoded command can get around it.
It also blocks some harmless commands, such as `cp .env.example .env`.
Files you attach yourself with `@` in a prompt are not checked, because
they don't go through a tool call.
It only watches the Read and Bash tools. Claude can still write or edit
a .env file if you allow it.



## License


MIT
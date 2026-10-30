# env-guard

## Install


In Claude Code:


```
/plugin install env-guard --marketplace yannigoyal/env-guard
```


Or from the terminal:


```bash
claude plugin marketplace add yannigoyal/env-guard
claude plugin install env-guard@yannigoyal-plugins
```

Stops Claude Code from reading your `.env` files, and checks whether any
`.env` files are tracked by git in your project.


## What it does


- **Hook (PreToolUse on Read, Bash and Grep):** before Claude reads a file,
 runs a shell command or searches files, `scripts/block-env.sh` checks whether
 it mentions a `.env` file. If it does, the action is blocked and Claude is told why.
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
It only watches the Read, Bash and Grep tools. Claude can still write or edit
a .env file if you allow it.
For Grep, only the search path and glob are checked. A search over a whole
folder is not blocked, even if that folder contains a .env file.
Any Bash command that mentions `.env` is blocked, even when it only writes
the word as text (for example in a commit message or an `echo`).



## License


MIT
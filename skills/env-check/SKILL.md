---
name: env-check
description: Check whether any .env files are tracked by git in the current repository. Use when the user asks about leaked secrets or committed env files.
---

Run `git ls-files` and look for any tracked file whose name is `.env`
or starts with `.env.` — but ignore `.env.example` and `.env.sample`.


Report each tracked file you find. If there are any, explain how to stop
tracking them with `git rm --cached <file>` and suggest adding them to
`.gitignore`. Do not open or print the contents of any .env file.
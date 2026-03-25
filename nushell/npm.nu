$env.PATH = ($env.PATH | split row (char esep) | prepend '~/.npm-global/bin')

std = {
  -- Allow vim globals used in Neovim config
  vim = true,
  api = true,
}

ignore = {
  -- Ignore generated files
  '.*%.o$',
  '.*%.a$',
  '.*%.so$',
  '.*%.obj$',
  '.*%.exe$',
  '.*%.dll$',
  '.*%.lib$',
  '.*%.zip$',
  '.*%.7z$',
  '.*%.rar$',
  '.*%.gz$',
  '.*%.bz2$',
  '.*%.tar$',
  '.*%.png$',
  '.*%.jpg$',
  '.*%.jpeg$',
  '.*%.gif$',
  '.*%.bmp$',
  '.*%.ico$',
  '.*%.cur$',
  '.*%.wav$',
  '.*%.mp3$',
  '.*%.ogg$',
  '.*%.flac$',
  '.*%.woff$',
  '.*%.ttf$',
  '.*%.otf$',
  '.*%.eot$',
  '.*%.svg$',
  '.*%.swp$',
  '.*%.bak$',
  '.*%.tmp$',
}

files = {
  -- Include all Lua files in config directory
  '.*/?.lua$',
  '.*/?/lua/?*.lua$',
}

globals = {
  -- Allow common Neovim globals
  'vim',
  'api',
  'require',
  '_G',
  'package',
  'math',
  'string',
  'table',
  'coroutine',
  'io',
  'os',
  'debug',
  'tostring',
  'ipairs',
  'pairs',
  'Snacks',
}

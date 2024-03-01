-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
--

-- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
-- init.lua. If you want these files, they are in the repository, so you can just download them and
-- put them in the right spots if you want.

-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for kickstart
--
--  Here are some example plugins that I've included in the kickstart repository.
--  Uncomment any of the lines below to enable them (you will need to restart nvim).
--

-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
--    This is the easiest way to modularize your config.
--
--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
--    For additional information see: :help lazy.nvim-lazy.nvim-structuring-your-plugins
-- { import = 'custom.plugins' },
--
return {

  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
}

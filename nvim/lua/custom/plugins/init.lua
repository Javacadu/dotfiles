-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'folke/snacks.nvim',
    opts = {
      input = {},
      picker = {
        actions = {
          opencode_send = function(...)
            return require('opencode').snacks_picker_send(...)
          end,
        },
        win = {
          input = {
            keys = {
              ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
            },
          },
        },
      },
    },
  },
  {
    'nickjvandyke/opencode.nvim',
    version = '*',
    config = function()
      vim.g.opencode_opts = {
        prompts = {
          explain = { prompt = 'Explain @this and its context', submit = true },
          fix = { prompt = 'Fix @diagnostics', submit = true },
          review = { prompt = 'Review @this for correctness and readability', submit = true },
          test = { prompt = 'Add tests for @this', submit = true },
          optimize = { prompt = 'Optimize @this for performance and readability', submit = true },
          document = { prompt = 'Add comments documenting @this', submit = true },
        },
      }

      vim.o.autoread = true

      local opencode = require 'opencode'

      vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
        opencode.ask('@this: ', { submit = true })
      end, { desc = 'Ask opencode about current line/selection' })

      vim.keymap.set({ 'n', 'x' }, '<leader>ox', function()
        opencode.select()
      end, { desc = 'Open opencode action picker' })

      vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
        opencode.toggle()
      end, { desc = 'Toggle opencode panel' })

      vim.keymap.set({ 'n', 'x' }, 'go', function()
        return opencode.operator '@this '
      end, { desc = 'Add range to opencode', expr = true })

      vim.keymap.set('n', 'goo', function()
        return opencode.operator '@this ' .. '_'
      end, { desc = 'Add line to opencode', expr = true })

      vim.keymap.set('n', '<leader>ou', function()
        opencode.command 'session.half.page.up'
      end, { desc = 'Scroll opencode up' })

      vim.keymap.set('n', '<leader>od', function()
        opencode.command 'session.half.page.down'
      end, { desc = 'Scroll opencode down' })
    end,
  },
}

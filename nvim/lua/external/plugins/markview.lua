-- For `plugins/markview.lua` users.
return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
        "saghen/blink.cmp",
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<leader>ms", "<cmd>Markview splitToggle<cr>", desc = "Markview: Toggle Split Preview" },
        { "<leader>mp", "<cmd>Markview splitOpen<cr>",   desc = "Markview: Open Split Preview" },
        { "<leader>mc", "<cmd>Markview splitClose<cr>",  desc = "Markview: Close Split Preview" },
        { "<leader>mr", "<cmd>Markview splitRedraw<cr>", desc = "Markview: Redraw Split Preview" },
        { "<leader>mt", "<cmd>Markview toggle<cr>",      desc = "Markview: Toggle Inline Preview" },
    },
    opts = {
        preview = {
            enable = true,
            filetypes = { "markdown", "quarto", "rmd", "typst", "asciidoc" },
            ignore_buftypes = { "nofile" },
            callbacks = {
                on_attach = function(buf)
                    vim.schedule(function()
                        if vim.api.nvim_buf_is_valid(buf) then
                            pcall(vim.cmd, "Markview splitOpen " .. buf)
                        end
                    end)
                end,
            },
            splitview_winopts = {
                split = "right",
            },
        },
        markdown = {
            enable = true,
        },
        markdown_inline = {
            enable = true,
        },
        typst = {
            enable = true,
        },
        latex = {
            enable = true,
        },
        html = {
            enable = true,
        },
        yaml = {
            enable = true,
        },
    },
}



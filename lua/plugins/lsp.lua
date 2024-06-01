local map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = true
  opts.silent = true
  vim.keymap.set(mode, lhs, rhs, opts)
end

local on_attach = function(_, bufnr)
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("LspAutoformat", { clear = true }),
    callback = function()
      vim.lsp.buf.format()
    end,
  })

  map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show tooltip" })
  map("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Show signature help" })
  map("n", "<F2>", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
  map("n", "<F3>", vim.lsp.buf.format, { buffer = bufnr, desc = "Format buffer" })
  map("n", "<F4>", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
end

-- Copied from LazyVim
-- Utility function to extend or override a config table, similar to the way
-- that Plugin.opts works.
---@param config table
---@param custom function | table | nil
local function extend_or_override(config, custom, ...)
  if type(custom) == "function" then
    config = custom(config, ...) or config
  elseif custom then
    config = vim.tbl_deep_extend("force", config, custom) --[[@as table]]
  end
  return config
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "bashls",
        "clangd",
        "cssls",
        "dockerls",
        "docker_compose_language_service",
        "emmet_language_server",
        "eslint",
        "gopls",
        "html",
        "jdtls",
        "lemminx",
        "lua_ls",
        "marksman",
        "spectral",
        "sqlls",
        "tailwindcss",
        "templ",
        "tsserver",
        "volar",
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            on_attach = on_attach,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          })
        end,
        eslint = function()
          require("lspconfig").eslint.setup({
            on_attach = function(client, bufnr)
              on_attach(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
              })
            end,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          })
        end,
        jdtls = function() end,
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            on_attach = on_attach,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        end,
        tsserver = function()
          require("lspconfig").tsserver.setup({
            on_attach = on_attach,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location =
                  "/home/thxgg/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server",
                  languages = { "typescript", "javascript", "vue" },
                },
              },
            },
            filetypes = {
              "javascript",
              "typescript",
              "vue",
            },
          })
        end,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true
  },
  -- Copied from LazyVim
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "folke/which-key.nvim" },
    ft = "java",
    opts = function()
      return {
        -- How to find the root dir for a given filename. The default comes from
        -- lspconfig which provides a function specifically for java projects.
        root_dir = require("lspconfig.server_configurations.jdtls").default_config.root_dir,

        -- How to find the project name for a given root dir.
        project_name = function(root_dir)
          return root_dir and vim.fs.basename(root_dir)
        end,

        -- Where are the config and workspace dirs for a project?
        jdtls_config_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
        end,
        jdtls_workspace_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
        end,

        -- How to run jdtls. This can be overridden to a full java command-line
        -- if the Python wrapper script doesn't suffice.
        cmd = { vim.fn.exepath("jdtls") },
        full_cmd = function(opts)
          local fname = vim.api.nvim_buf_get_name(0)
          local root_dir = opts.root_dir(fname)
          local project_name = opts.project_name(root_dir)
          local cmd = vim.deepcopy(opts.cmd)
          if project_name then
            vim.list_extend(cmd, {
              "-configuration",
              opts.jdtls_config_dir(project_name),
              "-data",
              opts.jdtls_workspace_dir(project_name),
            })
          end
          return cmd
        end,

        -- These depend on nvim-dap, but can additionally be disabled by setting false here.
        dap = { hotcodereplace = "auto", config_overrides = {} },
        dap_main = {},
        test = true,
        on_attach = function(_, bufnr)
          -- Formatting
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspAutoformat", { clear = true }),
            callback = function()
              vim.lsp.buf.format()
            end,
          })

          -- Codelens
          pcall(vim.lsp.codelens.refresh)

          vim.api.nvim_create_autocmd("BufWritePost", {
            buffer = bufnr,
            desc = "refresh codelens",
            callback = function()
              pcall(vim.lsp.codelens.refresh)
            end,
          })

          -- Mappings
          map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show tooltip" })
          map("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Show signature help" })
          map("n", "<F2>", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
          map("n", "<F3>", vim.lsp.buf.format, { buffer = bufnr, desc = "Format buffer" })
          map("n", "<F4>", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
        end,
        setting = {
          java = {
            eclipse = {
              downloadSources = true,
            },
            configuration = {
              updateBuildConfiguration = "interactive",
              runtimes = {
                {
                  name = "JavaSE-17",
                  path = vim.fn.expand("/usr/lib/jvm/java-17-openjdk"),
                },
                -- Still waiting for Java 21 support
                -- {
                --     name = 'JavaSE-21',
                --     path = vim.fn.expand('/usr/lib/jvm/java-21-openjdk'),
                -- },
              },
            },
            maven = {
              downloadSources = true,
            },
            implementationsCodeLens = {
              enabled = true,
            },
            referencesCodeLens = {
              enabled = true,
            },
            inlayHints = {
              parameterNames = {
                enabled = "all", -- literals, all, none
              },
            },
          },
          signatureHelp = {
            enabled = true,
          },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
          },
          contentProvider = {
            preferred = "fernflower",
          },
          extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
          },
        },
        jdtls = function(opts)
          local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
          local jvmArg = "-javaagent:" .. install_path .. "/lombok.jar"
          table.insert(opts.cmd, "--jvm-arg=" .. jvmArg)
          return opts
        end,
      }
    end,
    config = function(_, opts)
      -- Find the extra bundles that should be passed on the jdtls command-line
      -- if nvim-dap is enabled with java debug/test.
      local mason_registry = require("mason-registry")
      local bundles = {} ---@type string[]
      if opts.dap and mason_registry.is_installed("java-debug-adapter") then
        local java_dbg_pkg = mason_registry.get_package("java-debug-adapter")
        local java_dbg_path = java_dbg_pkg:get_install_path()
        local jar_patterns = {
          java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
        }
        -- java-test also depends on java-debug-adapter.
        if opts.test and mason_registry.is_installed("java-test") then
          local java_test_pkg = mason_registry.get_package("java-test")
          local java_test_path = java_test_pkg:get_install_path()
          vim.list_extend(jar_patterns, {
            java_test_path .. "/extension/server/*.jar",
          })
        end
        for _, jar_pattern in ipairs(jar_patterns) do
          for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
            table.insert(bundles, bundle)
          end
        end
      end

      local function attach_jdtls()
        local fname = vim.api.nvim_buf_get_name(0)

        -- Configuration can be augmented and overridden by opts.jdtls
        local config = extend_or_override({
          cmd = opts.full_cmd(opts),
          root_dir = opts.root_dir(fname),
          init_options = {
            bundles = bundles,
          },
          -- enable CMP capabilities
          capabilities = require("cmp_nvim_lsp").default_capabilities() or nil,
        }, opts.jdtls)

        -- Existing server will be reused if the root_dir matches.
        require("jdtls").start_or_attach(config)
        -- not need to require("jdtls.setup").add_commands(), start automatically adds commands
      end

      -- Attach the jdtls for each java buffer. HOWEVER, this plugin loads
      -- depending on filetype, so this autocmd doesn't run for the first file.
      -- For that, we call directly below.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = attach_jdtls,
      })

      -- Setup keymap and dap after the lsp is fully attached.
      -- https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
      -- https://neovim.io/doc/user/lsp.html#LspAttach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "jdtls" then
            local wk = require("which-key")
            wk.register({
              ["<leader>r"] = { name = "+refactor" },
              ["<leader>rx"] = { name = "+extract" },
              ["<leader>rxv"] = { require("jdtls").extract_variable_all, "E[x]tract [V]ariable" },
              ["<leader>rxc"] = { require("jdtls").extract_constant, "E[x]tract [C]onstant" },
              ["<leader>roi"] = { require("jdtls").organize_imports, "[O]rganize [I]mports" },
            }, { mode = "n", buffer = args.buf })
            wk.register({
              ["<leader>r"] = { name = "+refactor" },
              ["<leader>rx"] = { name = "+extract" },
              ["<leader>rxm"] = {
                [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
                "E[x]tract [M]ethod",
              },
              ["<leader>rxv"] = {
                [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]],
                "E[x]tract [V]ariable",
              },
              ["<leader>rxc"] = {
                [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]],
                "E[x]tract [C]onstant",
              },
            }, { mode = "v", buffer = args.buf })

            if opts.dap and mason_registry.is_installed("java-debug-adapter") then
              -- custom init for Java debugger
              require("jdtls").setup_dap(opts.dap)
              require("jdtls.dap").setup_dap_main_class_configs(opts.dap_main)

              -- Java Test require Java debugger to work
              if opts.test and mason_registry.is_installed("java-test") then
                -- custom keymaps for Java test runner (not yet compatible with neotest)
                wk.register({
                  ["<leader>t"] = { name = "+test" },
                  ["<leader>tT"] = { require("jdtls.dap").test_class, "Run All [T]est" },
                  ["<leader>tn"] = {
                    require("jdtls.dap").test_nearest_method,
                    "Run [N]earest [T]est",
                  },
                  ["<leader>tt"] = { require("jdtls.dap").pick_test, "Run [T]est" },
                }, { mode = "n", buffer = args.buf })
              end
            end

            -- User can set additional keymaps in opts.on_attach
            if opts.on_attach then
              opts.on_attach(args)
            end
          end
        end,
      })

      -- Avoid race condition by calling attach the first time, since the autocmd won't fire.
      attach_jdtls()
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = {
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.prettierd,
        nls.builtins.formatting.google_java_format,
        nls.builtins.formatting.sqlfluff.with({
          extra_args = { "--dialect", "postgres" },
        })
      }
    end,
  },
}

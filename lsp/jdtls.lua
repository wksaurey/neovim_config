-- eclipse.jdt.ls -- https://github.com/eclipse-jdtls/eclipse.jdt.ls
-- Enabled in lua/config/lsp.lua. Server: ~/tools/jdtls, launched via bin/jdtls.

local home = vim.env.HOME

return {
    -- The server itself refuses to start on anything below Java 21, but
    -- JAVA_HOME stays on 17 for grid24's Android toolchain -- hence the
    -- explicit --java-executable rather than relying on the environment.
    cmd = {
        home .. '/tools/jdtls/bin/jdtls',
        '--java-executable', home .. '/tools/jdk-21/bin/java',
    },
    filetypes = { 'java' },
    root_markers = {
        'settings.gradle', 'settings.gradle.kts',
        'build.gradle', 'build.gradle.kts',
        'pom.xml', '.git',
    },

    settings = {
        java = {
            -- The server ships this OFF, so <C-S> reports "No signature help
            -- available" until it is turned on.
            signatureHelp = { enabled = true },
            configuration = {
                -- 17 is the default so diagnostics match the javac on PATH;
                -- 21 is listed only because the server runs on it.
                runtimes = {
                    { name = 'JavaSE-17', path = home .. '/tools/jdk-17', default = true },
                    { name = 'JavaSE-21', path = home .. '/tools/jdk-21' },
                },
            },
        },
    },
}

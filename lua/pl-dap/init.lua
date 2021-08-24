local dap = require('dap')

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

dap.set_log_level('TRACE')

dap.configurations.kotlin = {
    {
        type = "java";
        name = "Java Debug (Attach)";
        request = "attach";
        hostName = "localhost";
        port = 5005;
    },
    {
        type = 'kotlin';
        name = "Run Backend";
        request = 'launch';
        projectRoot = '${workspaceFolder}/backend';
        mainClass = "com.mkgroup.service.jirabridge.ApplicationKt";
    },
    {
        type = "kotlin";
        request = "launch";
        name = "Debug KotlinDebugAdapter";
        projectRoot = "${workspaceFolder}/adapter";
        mainClass = "org.javacs.ktda.KDAMainKt";
    },
}

dap.adapters.kotlin = {
  type = 'executable';
  command = DATA_PATH .. '/dap_adapters/kotlin/adapter/build/install/adapter/bin/kotlin-debug-adapter';
  args = {};
  options = {};
}



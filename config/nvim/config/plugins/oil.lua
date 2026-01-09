require("oil").setup({
    default_file_explorer = true, -- default: true
    delete_to_trash = true, -- default: false
    watch_for_changes = true, -- default: false

    columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
    },
})

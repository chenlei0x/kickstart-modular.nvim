local ls = require("luasnip")
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node



local date = function() return {os.date('%Y-%m-%d')} end


local c_file_header = snip("trigger", { text("Wow! Text!") })
ls.add_snippets("c",
	{
		snip(
			"printk",
			{
				text({"printk(\"### [%s:%s:%d]: \\n\", ", "__FILE__, __func__, __LINE__);"})
			}
		),
		snip(
			"printf",
			{
				text({"printf(\"### [%s:%s:%d]: \\n\", ", "__FILE__, __func__, __LINE__);"})
			}
		)
	}
)

ls.add_snippets("make",
	{
		snip(
			"gcc",
			{
				text({"gcc $< -o $@"})
			}
		),
	}
)

ls.add_snippets("python",
	{
		snip(
			"#header",
			{
				text(
					{
						"#! /usr/bin/env python3",
						"# -*- python -*-",
						"# -*- coding: utf-8 -*-"
					}
				)
			}
		),
	}
)

ls.add_snippets("sh",
	{
		snip(
			"rsync",
			{
				text(
					{
						"ip=",
						"sub_dir=.",
						"dest_dir=",
						"user=root",
						"passwd='HC!r0cks'",
						"sshpass -p ${passwd} rsync  -e 'ssh -o ServerAliveInterval=30 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' \\",
						"--delete -avzh \\",
						"--exclude='/.git' \\",
						"--filter=\"dir-merge,- .gitignore\" ${sub_dir} ${user}@${ip}:${dest_dir}"
					}
				)
			}
		),
		snip(
			"ssh",
			{
				text(
					{
						"ip=",
						"user=root",
						"passwd='HC!r0cks'",
						"sshpass -p ${passwd} ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null  -o LogLevel=ERROR ${user}@${ip}"
					}
				)
			}
		),
		snip(
			"ipmi",
			{
				text(
					{
						"ip=",
						"passwd='HC!r0cks'",
						"user='root'",
						"ipmitool -H ${ip} -I lanplus -P ${passwd} -U ${user} sol activate",
						"#ipmitool -H ${ip} -I lanplus -P ${passwd} -U ${user} chassis power diag"
					}
				)
			}
		),
		snip(
			"#header",
			{
				text(
					{
						"#! /bin/bash",
                        "set -E -e -u -o pipefail",
                        "SCRIPT_DIR=$( cd -- \"$( dirname -- \"${BASH_SOURCE[0]}\" )\" &> /dev/null && pwd )"
					}
				)
			}
		),
		snip(
			"docker",
			{
				text(
					{
						"if [ -f /.dockerenv ]; then",
						"\t# run in container",
						"else",
						"\tdocker run --privileged  -h libvirt-builder --net=host --rm -v/data:/data -w$(pwd) $docker_image ./$COMMAND",
						"fi"
					}
				)
			}
		)
	}
)
return {}

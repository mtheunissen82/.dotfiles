import { Plugin } from "@opencode/plugin"
import { execFile } from "node:child_process"
import { promisify } from "node:util"

// Requires: rtk >= 0.23.0 in PATH. All rewrite rules live in `rtk rewrite`.
const run = promisify(execFile)

async function rewrite(command: string) {
  // rtk exits non-zero (3) when it rewrites, so read stdout from the error too
  const stdout = await run("rtk", ["rewrite", command]).then(
    (r) => r.stdout,
    (e) => e.stdout ?? "",
  )
  const out = String(stdout).trim()
  return out && out !== command ? out : undefined
}

export default Plugin.define({
  id: "rtk",
  async setup(ctx) {
    await ctx.tool.hook("execute.before", async (event) => {
      if (event.tool !== "bash" && event.tool !== "shell") return
      const input = event.input as { command?: unknown } | undefined
      if (typeof input?.command !== "string" || !input.command) return
      const next = await rewrite(input.command)
      if (next) input.command = next
    })
  },
})

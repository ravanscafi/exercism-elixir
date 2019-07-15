System.put_env("EXERCISM_TEST_EXAMPLES", "true")

"*/*.exs"
|> Path.wildcard()
|> Enum.reject(&String.contains?(&1, "_test"))
|> Kernel.ParallelCompiler.require()

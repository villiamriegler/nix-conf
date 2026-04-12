local modules = {
	"mini.ai",
	"mini.comment",
	"mini.move",
	"mini.pairs",
	"mini.surround",
}

for _, mod in ipairs(modules) do
	require(mod).setup()
end


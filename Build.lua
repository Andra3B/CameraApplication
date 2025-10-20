local Seam = require("Seam.Seam")

local BuildTypeEnum = Enum.Create({
	Release = 1,
	Debug = 2
})

Seam.Options.BuildType = {
	DataType = Enum.OptionDataType.Enum,
	Default = BuildTypeEnum.Release,
	Enum = BuildTypeEnum
}

Seam.UpdateOptions(arg)

local BuildTypeAdditionalOptions = {
	[BuildTypeEnum.Release] = "-Wall -std=c11 -O2",
	[BuildTypeEnum.Debug] = "-Wall -std=c11 -g -Og -D DEBUG"
}

local MainApplication = Application.Create("Main")

MainApplication:AddSource("./Application/", nil, "*.c")

MainApplication.AdditionalCompilerOptions = BuildTypeAdditionalOptions[Seam.Options.BuildType.Value]

MainApplication:Build()
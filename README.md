# spbstu-homework

Just some code on lua.

`lib` is for global libraries:

- `deepcopy.lua` makes a copy of any table (default: pointer copy). Author: Community
- `serialization.lua` any* table -> string and back. Author: OpenComputers authors
- `checkArg.lua` serialization lib dependency. Author: OpenComputers authors
- `table_pack-unpack.lua` serialization lib ~dependency. Author: Me
- `json.lua` JSON encode/decode. Author: github.com/rxi/json.lua


(*) Any table without functions inside, they are not convertible

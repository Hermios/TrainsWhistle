require "__HermiosLibs__.data-libs"
require "constants"
require "prototypes.items"
require "prototypes.entities"
require "prototypes.recipes"
require "prototypes.technologies"

if not data.raw["custom-input"] or not data.raw["custom-input"]["whistle_train"] then
  data:extend({
    {
      type = "custom-input",
      name = "whistle_train",
      key_sequence = "H"
    }
  })
end

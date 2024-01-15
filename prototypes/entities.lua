-- Equipment
createdata("movement-bonus-equipment","exoskeleton-equipment",train_whistle_equipment,
{
	energy_consumption = "1J",
	movement_bonus = 0,
	shape =
    {
      width = 2,
      height = 2,
      type = "full"
    },
	sprite =
    {
      filename = "__"..modname.."__/graphics/equipment/"..train_whistle_equipment..".png",
      width = 64,
      height = 64,
      priority = "medium"
    },
	categories={"armor"}
})
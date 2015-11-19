local DifficultySelection = import "..views.module.test.DifficultySelection"

local M = {
		difficultySelection = 
		{   --关卡选择面板
			name = "difficultySelection",
			url = "ui/DifficultySelectionView.csb",
			viewClass = DifficultySelection,
			openAnim  = "fromTop",
			closeAnim  = "toTop",
			data = {}
		},
}
return M


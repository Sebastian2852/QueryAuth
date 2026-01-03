--[=[
	Checks to see if the player has not met this condition before.
	@function Once
	@within QueryAuth
	@return AuthCondition -- A lambda that returns true if the player did not get checked by the condition before.
]=]
return function()
    local used = {}

    return function(player: Player)
        if used[player] then
            return false
        end
        
        used[player] = true

        return true
    end
end